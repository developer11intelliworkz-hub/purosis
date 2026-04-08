class SupportModel {
  int? id;
  String? email;
  String? phoneNo;
  String? officeTimings;
  String? note;
  String? createdAt;
  String? updatedAt;

  SupportModel({
    this.id,
    this.email,
    this.phoneNo,
    this.officeTimings,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  static SupportModel fromJson(Map<String, dynamic> json) {
    return SupportModel(
      id: json['id'],
      email: json['email'],
      phoneNo: json['phone_no'],
      officeTimings: json['office_timings'],
      note: json['note'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone_no': phoneNo,
      'office_timings': officeTimings,
      'note': note,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
