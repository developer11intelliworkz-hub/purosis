import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';

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

  static Future<File?> convertCardToImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3);

      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) return null;

      Uint8List pngBytes = byteData.buffer.asUint8List();

      final dir = await getApplicationDocumentsDirectory();

      final file = File(
        "${dir.path}/festival_post_${DateTime.now().millisecondsSinceEpoch}.png",
      );

      await file.writeAsBytes(pngBytes);
      final fileDownload = await saveToDownload(pngBytes);
      //
      // if (file != null) {
      //   print("Saved in Download: ${file.path}");
      // }

      return file;
    } catch (e) {
      debugPrint("Capture Error: $e");
      return null;
    }
  }

  static Future<File?> saveToDownload(Uint8List bytes) async {
    try {
      /// Ask permission
      var status = await Permission.storage.request();

      if (!status.isGranted) {
        print("Permission Denied");
        return null;
      }

      /// Download folder path (Android)
      Directory directory = Directory("/storage/emulated/0/Download");

      /// Create file
      String filePath =
          "${directory.path}/festival_${DateTime.now().millisecondsSinceEpoch}.png";

      File file = File(filePath);

      await file.writeAsBytes(bytes);

      return file;
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
