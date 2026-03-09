import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class AppDownloader {
  static Future<String?> downloadFile(
    String url,
    String? subModulePath,
    String fileName,
  ) async {
    final dir = await getApplicationCacheDirectory();
    String? subPath = "$subModulePath/";
    final filePath =
        '${dir.path}/${subModulePath != null ? subPath : ""}$fileName';

    Dio dio = Dio();
    await dio.download(url, filePath);

    return filePath;
  }

  static Future openFile({
    required String url,
    String? subModulePath,
    required String fileName,
  }) async {
    final dir = await getApplicationCacheDirectory();
    String? subPath = "$subModulePath/";
    final filePath =
        '${dir.path}/${subModulePath != null ? subPath : ""}$fileName';
    if (await File(filePath).exists()) {
      // await OpenFilex.open(filePath);
    } else {
      final downloadedFilePath = await downloadFile(
        url,
        subModulePath,
        fileName,
      );
      if (downloadedFilePath != null) {
        // await OpenFilex.open(filePath);
      }
    }
  }

  // static Future<void> download(String url)async{
  //   final dir = await getApplicationCacheDirectory();
  //   await FileDownloader.downloadFile(
  //       url: url,
  //       name: url.split("/").last,
  //       subPath: dir.path,
  //       onProgress: (fileName,progress) {
  //         print('FILE fileName HAS PROGRESS $progress');
  //       },
  //       onDownloadCompleted: (String path) {
  //         print('FILE DOWNLOADED TO PATH: $path');
  //       },
  //       onDownloadError: (String error) {
  //         print('DOWNLOAD ERROR: $error');
  //       });
  // }
}
