import 'dart:io';

class ImageModel {
  ImageModel({this.filePath, this.colorCode, this.colorName});

  ImageModel.fromJson(dynamic json) {
    filePath = json['filePath'];
    colorCode = json['colorCode'];
    colorName = json['colorName'];
  }

  List<File>? filePath;
  String? colorCode;
  String? colorName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['filePath'] = filePath;
    map['colorCode'] = colorCode;
    map['colorName'] = colorName;
    return map;
  }
}
