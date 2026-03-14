class DetailModel {
  DetailModel({
    this.brochureCategory,
    this.postCategory,
    this.reelCategory,
    this.videoCategory,
    this.videoType,
    this.userTypes,
  });

  DetailModel.fromJson(Map<String, dynamic> json) {
    brochureCategory = _parseList(json['brochure_category']);
    postCategory = _parseList(json['post_category']);
    reelCategory = _parseList(json['reel_category']);
    videoCategory = _parseList(json['video_category']);
    videoType = _parseList(json['video_type']);
    userTypes = json['user_types']?.cast<String>() ?? [];
  }

  List<CategoryItem>? brochureCategory;
  List<CategoryItem>? postCategory;
  List<CategoryItem>? reelCategory;
  List<CategoryItem>? videoCategory;
  List<CategoryItem>? videoType;
  List<String>? userTypes;

  static List<CategoryItem>? _parseList(dynamic list) {
    if (list == null) return null;
    return (list as List).map((e) => CategoryItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'brochure_category': brochureCategory?.map((e) => e.toJson()).toList(),
      'post_category': postCategory?.map((e) => e.toJson()).toList(),
      'reel_category': reelCategory?.map((e) => e.toJson()).toList(),
      'video_category': videoCategory?.map((e) => e.toJson()).toList(),
      'video_type': videoType?.map((e) => e.toJson()).toList(),
      'user_types': userTypes,
    };
  }
}

class CategoryItem {
  CategoryItem({this.key, this.value});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  String? key;
  String? value;

  Map<String, dynamic> toJson() {
    return {'key': key, 'value': value};
  }
}
