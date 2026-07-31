import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/ffprobe_kit.dart';
import 'package:flutter_foreground_task/models/notification_permission.dart';
import 'package:gal/gal.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/domain/models/DownloadStart.dart';
import 'package:movie_app/features/movie/domain/models/DownloadStartResult.dart';
import 'package:movie_app/features/movie/domain/repositories/DownloadRepository.dart';
import 'package:path_provider/path_provider.dart';

import '../datasources/service/ForegroundServiceDataSource.dart';

@LazySingleton(as: DownloadRepository)
class DownloadRepositoryImpl implements DownloadRepository {
  final ForegroundServiceDataSource _foregroundDataSource;

  DownloadRepositoryImpl(this._foregroundDataSource);

  Future<bool> _ensurePermissions() async {
    final notificationPermission = await _foregroundDataSource
        .checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await _foregroundDataSource.requestNotificationPermission();
    }

    if (Platform.isAndroid) {
      if (!await _foregroundDataSource.isIgnoringBatteryOptimizations()) {
        await _foregroundDataSource.requestIgnoreBatteryOptimizations();
      }
    }
    return true;
  }

  @override
  Future<DownloadStartResult> startDownload(DownloadStart request) async {
    if (await _foregroundDataSource.isRunning()) {
      return DownloadStartResult.alreadyRunning;
    }
    final granted = await _ensurePermissions();
    if (!granted) {
      return DownloadStartResult.permissionDenied;
    }
    final hasGalAccess = await Gal.hasAccess() || await Gal.requestAccess();
    if (!hasGalAccess) {
      return DownloadStartResult.permissionDenied;
    }
    final tempDir = await getTemporaryDirectory();
    final safeFileName = '${request.movieSlug}_${request.episodeName}'
        .replaceAll(RegExp(r'[^\w\-]'), '_');
    final downloadTempFolder = Directory('${tempDir.path}/downloads_tmp');
    if (!await downloadTempFolder.exists()) {
      await downloadTempFolder.create(recursive: true);
    }
    final savePath =
        '${downloadTempFolder.path}/${safeFileName}_${DateTime.now().millisecondsSinceEpoch}.mp4';
    await _foregroundDataSource.init();
    final started = await _foregroundDataSource.startService();
    if (!started) {
      return DownloadStartResult.failedToStart;
    }
    final session = await FFprobeKit.getMediaInformation(request.videoUrl);
    final info = session.getMediaInformation();
    await Future.delayed(const Duration(milliseconds: 500));
    _foregroundDataSource.sendToTask({
      'slug': request.movieSlug,
      'name': request.movieName,
      'episode': request.episodeName,
      'url': request.videoUrl,
      'path': savePath,
      'durationMs': double.tryParse(info?.getDuration() ?? "0")! * 1000,
    });
    return DownloadStartResult.started;
  }

  @override
  Future<void> cancelDownload() async {
    if (await _foregroundDataSource.isRunning()) {
      await FFmpegKit.cancel();
      await _foregroundDataSource.stopService();
    }
  }
}
