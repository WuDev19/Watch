import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:gal/gal.dart';

class FfmpegDownloadTaskHandler extends TaskHandler {
  String? _currentOutputPath;
  bool _isCancelled = false;
  String? slug; //tạm thời chưa dùng

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    debugPrint('onDestroy: $isTimeout');
    if (_currentOutputPath != null) {
      try {
        final file = File(_currentOutputPath!);
        if (await file.exists()) {
          await file.delete();
          debugPrint('Đã xóa file dở dang do service bị hủy đột ngột: $_currentOutputPath');
        }
      } catch (e) {
        debugPrint('Không thể xóa file dở dang trong onDestroy: $e');
      }
    }
  }

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    debugPrint('onStart');
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  void onNotificationButtonPressed(String id) async {
    if (id != 'cancel_button') return;
    _isCancelled = true;
    await FFmpegKit.cancel();
    if (_currentOutputPath != null) {
      try {
        final file = File(_currentOutputPath!);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        debugPrint('Không thể xóa file dở dang: $e');
      }
    }
    FlutterForegroundTask.stopService();
  }

  @override
  void onNotificationPressed() async {
    if (!await FlutterForegroundTask.isAppOnForeground) {
      FlutterForegroundTask.launchApp();
    }
  }

  @override
  void onReceiveData(Object data) async {
    if (data is! Map) return;
    slug = data['slug'] as String?;
    final String? movieName = data['name'] as String?;
    final String? episode = data['episode'] as String?;
    final String? url = data['url'] as String?;
    final String? path = data['path'] as String?;
    final double totalDurationMs =
        (data['durationMs'] as num?)?.toDouble() ?? 0;
    if (url == null || url.isEmpty || path == null || path.isEmpty) {
      FlutterForegroundTask.updateService(
        notificationTitle: 'Lỗi tải xuống',
        notificationText: 'Thiếu thông tin đường dẫn hoặc URL video.',
      );
      await Future.delayed(const Duration(seconds: 2));
      FlutterForegroundTask.stopService();
      return;
    }
    _currentOutputPath = path;
    _isCancelled = false;
    final List<String> commandArguments = [
      '-user_agent',
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
          '(KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36',
      '-i',
      url,
      '-c',
      'copy',
      '-movflags',
      '+faststart',
      path,
    ];
    await FFmpegKit.executeWithArgumentsAsync(
      commandArguments,
      (session) async {
        if (_isCancelled) return;
        final returnCode = await session.getReturnCode();
        if (ReturnCode.isSuccess(returnCode)) {
          await _saveToGalleryAndCleanup(path);
        } else {
          final output = await session.getOutput();
          final failStackTrace = await session.getFailStackTrace();
          debugPrint('FFmpeg returnCode: $returnCode');
          debugPrint('FFmpeg output/logs: $output');
          debugPrint('FFmpeg failStackTrace: $failStackTrace');

          FlutterForegroundTask.updateService(
            notificationTitle: 'Tải thất bại',
            notificationText: 'Đã xảy ra lỗi trong quá trình xử lý.',
          );
        }
        await Future.delayed(const Duration(seconds: 2));
        FlutterForegroundTask.stopService();
      },
      (log) {
        debugPrint('FFmpeg log: ${log.getMessage()}');
      },
      (stats) {
        if (totalDurationMs <= 0) return;
        final double currentProgressMs = stats.getTime().toDouble();
        final int progressPercent =
            ((currentProgressMs / totalDurationMs) * 100).clamp(0, 100).toInt();
        FlutterForegroundTask.updateService(
          notificationTitle: 'Đang tải tập $episode phim $movieName...',
          notificationText: 'Tiến trình: $progressPercent%',
        );
      },
    );
  }

  Future<void> _saveToGalleryAndCleanup(String tempPath) async {
    try {
      final hasAccess = await Gal.hasAccess() || await Gal.requestAccess();
      if (!hasAccess) {
        FlutterForegroundTask.updateService(
          notificationTitle: 'Thiếu quyền truy cập',
          notificationText: 'Không thể lưu video vào thư viện ảnh.',
        );
        return;
      }

      await Gal.putVideo(tempPath, album: 'MovieApp');

      FlutterForegroundTask.updateService(
        notificationTitle: 'Tải thành công!',
        notificationText: 'Video đã được lưu vào thư viện ảnh.',
      );
    } on GalException catch (e) {
      debugPrint('GalException: ${e.type} - ${e.type}');
      FlutterForegroundTask.updateService(
        notificationTitle: 'Lỗi khi lưu vào thư viện',
        notificationText: _mapGalError(e),
      );
    } catch (e) {
      debugPrint('Gal error: $e');
      FlutterForegroundTask.updateService(
        notificationTitle: 'Lỗi khi lưu vào thư viện',
        notificationText: 'Video đã tải xong nhưng lưu vào Gallery thất bại.',
      );
    } finally {
      await _deleteTempFile(tempPath);
    }
  }
  Future<void> _deleteTempFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('Không thể xóa file tạm: $e');
    }
  }

  String _mapGalError(GalException e) {
    switch (e.type) {
      case GalExceptionType.accessDenied:
        return 'Ứng dụng chưa được cấp quyền truy cập thư viện ảnh.';
      case GalExceptionType.notEnoughSpace:
        return 'Thiết bị không đủ dung lượng lưu trữ.';
      case GalExceptionType.notSupportedFormat:
        return 'Định dạng video không được hỗ trợ.';
      default:
        return 'Đã xảy ra lỗi không xác định khi lưu video.';
    }
  }
}

@pragma('vm:entry-point')
void ffmpegDownloadStartCallback() {
  FlutterForegroundTask.setTaskHandler(FfmpegDownloadTaskHandler());
}
