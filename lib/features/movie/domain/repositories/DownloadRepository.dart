import '../models/DownloadStart.dart';
import '../models/DownloadStartResult.dart';

abstract class DownloadRepository {
  Future<DownloadStartResult> startDownload(DownloadStart request);

  Future<void> cancelDownload();
}
