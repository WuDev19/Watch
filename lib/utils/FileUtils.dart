import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import 'extension.dart';

@lazySingleton
class FileUtils {
  Future<String> createTmpFile({
    required String fileName,
    required Extension extension,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final downloadTempFolder = Directory('${tempDir.path}/downloads_tmp');
    if (!await downloadTempFolder.exists()) {
      await downloadTempFolder.create(recursive: true);
    }
    return '${downloadTempFolder.path}/${fileName}_${DateTime.now().millisecondsSinceEpoch}.${extension.name}';
  }
}
