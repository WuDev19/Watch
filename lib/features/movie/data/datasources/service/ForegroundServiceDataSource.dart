import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/utils/constants.dart';

import 'FfmpegDownloadTaskHandler.dart';

@lazySingleton
class ForegroundServiceDataSource {
  Future<bool> isRunning() => FlutterForegroundTask.isRunningService;

  Future<NotificationPermission> checkNotificationPermission() {
    return FlutterForegroundTask.checkNotificationPermission();
  }

  Future<void> requestNotificationPermission() {
    return FlutterForegroundTask.requestNotificationPermission();
  }

  Future<bool> isIgnoringBatteryOptimizations() {
    return FlutterForegroundTask.isIgnoringBatteryOptimizations;
  }

  Future<void> requestIgnoreBatteryOptimizations() {
    return FlutterForegroundTask.requestIgnoreBatteryOptimization();
  }

  Future<void> init() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'video_downloader_channel',
        channelName: 'Tải Video Chạy Nền',
        channelDescription: 'Hiển thị tiến trình tải video m3u8 từ ứng dụng.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.nothing(),
        autoRunOnBoot: false,
        allowWakeLock: true,
      ),
    );
  }

  Future<bool> startService() async {
    final result = await FlutterForegroundTask.startService(
      notificationTitle: 'Đang chuẩn bị tải...',
      notificationText: 'Vui lòng chờ trong giây lát.',
      callback: ffmpegDownloadStartCallback,
      notificationButtons: [
        NotificationButton(id: Constants.cancelButton, text: 'Cancel'),
      ],
    );
    return result is ServiceRequestSuccess;
  }

  Future<void> stopService() => FlutterForegroundTask.stopService();

  void sendToTask(Map<String, dynamic> data) {
    FlutterForegroundTask.sendDataToTask(data);
  }
}
