import 'package:file_picker/file_picker.dart';

class ImageItem {
  final String? url;
  final PlatformFile? file;

  ImageItem({this.url, this.file});

  bool get isNetwork => url != null;
}
