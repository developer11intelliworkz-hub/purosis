import 'package:dio/dio.dart';

class DeleteContentQuery {
  DeleteContentQuery({
    this.brochureId,
    this.videoId,
    this.leafletId,
    this.postId,
    this.reelId,
  });

  DeleteContentQuery.fromJson(dynamic json) {
    brochureId = json['brochure_id'];
    videoId = json['video_id'];
    leafletId = json['leaflet_id'];
    postId = json['post_id'];
    reelId = json['reel_id'];
  }

  int? brochureId;
  int? videoId;
  int? leafletId;
  int? postId;
  int? reelId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (brochureId != null) map['brochure_id'] = brochureId;
    if (videoId != null) map['video_id'] = videoId;
    if (leafletId != null) map['leaflet_id'] = leafletId;
    if (postId != null) map['post_id'] = postId;
    if (reelId != null) map['reel_id'] = reelId;

    return map;
  }

  FormData toFormData() {
    return FormData.fromMap({
      if (brochureId != null) "brochure_id": brochureId,
      if (videoId != null) "video_id": videoId,
      if (leafletId != null) "leaflet_id": leafletId,
      if (postId != null) "post_id": postId,
      if (reelId != null) "reel_id": reelId,
    });
  }
}
