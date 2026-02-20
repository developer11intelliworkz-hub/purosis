import 'package:file_picker/file_picker.dart';


class CommonFunction{

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

}