import 'package:injectable/injectable.dart';

import '../models/DownloadStart.dart';
import '../models/DownloadStartResult.dart';
import '../repositories/DownloadRepository.dart';

@lazySingleton
class DownloadMovieUseCase {
  final DownloadRepository _downloadRepository;

  DownloadMovieUseCase(this._downloadRepository);

  Future<DownloadStartResult> execute(DownloadStart request) {
    return _downloadRepository.startDownload(request);
  }
}
