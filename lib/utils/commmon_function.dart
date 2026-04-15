import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:purosis/utils/app_toast.dart';

class CommonFunction {
  static Future<List<PlatformFile>> pickMultipleImages({
    required int alreadySelected,
    int maxLimit = 6,
  }) async {
    final remaining = maxLimit - alreadySelected;
    if (remaining <= 0) return [];

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      return result.files.take(remaining).toList();
    }
    return [];
  }

  static String colorToHex(Color color) {
    // return value like #000000
    return "#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}";
  }

  static Color hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Future<File?> downloadFile(String url, String fileName) async {
    try {
      // Get directory
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';

      // Download file
      await Dio().download(url, filePath);

      // Convert to File
      final file = File(filePath);

      return file;
    } catch (e) {
      return null;
    }
  }

  static Future<PlatformFile> urlToPlatformFile(String imageUrl) async {
    final dio = Dio();

    final dir = await getTemporaryDirectory();
    final filePath =
        '${dir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';

    await dio.download(
      imageUrl,
      filePath,
      options: Options(responseType: ResponseType.bytes),
    );
    File file = File(filePath);
    final bytes = await file.readAsBytes();

    return PlatformFile(
      name: file.path.split('/').last,
      path: file.path,
      size: bytes.length,
      bytes: bytes,
    );
  }

  static Future<void> convertCardToImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3);

      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) return;

      Uint8List pngBytes = byteData.buffer.asUint8List();

      final dir = await getApplicationCacheDirectory();

      final file = File(
        "${dir.path}/festival_post_${DateTime.now().millisecondsSinceEpoch}.png",
      );

      final fileWrite = await file.writeAsBytes(pngBytes);
      final result = await saveToDownload(fileWrite.path);
      if (result?.isSuccessful ?? false) {
        await OpenFilex.open(fileWrite.path);
      } else {
        AppToast.error();
      }
    } catch (e) {
      AppToast.error();
    }
  }

  static Future<SaveInfo?> saveToDownload(String filePath) async {
    try {
      final mediaStore = MediaStore();
      final result = await mediaStore.saveFile(
        tempFilePath: filePath,
        dirType: DirType.download,
        dirName: DirName.download,
      );
      print("Saved: ${result?.uri}");
      return result;
    } catch (e) {
      print("Save Error: $e");
      return null;
    }
  }

  static String convertUtcToLocalFormatted(String utcDateString) {
    final utcDate = DateTime.parse("${utcDateString}Z");
    final localDate = utcDate.toLocal();
    return DateFormat("dd MMM yyyy, hh:mm a").format(localDate);
  }
}
