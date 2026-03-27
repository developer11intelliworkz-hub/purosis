import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

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
}
