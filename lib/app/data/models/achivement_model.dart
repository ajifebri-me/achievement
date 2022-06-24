class AchivementModel {
  bool? success;
  int? code;
  String? message;
  List<DataAchivement>? data;

  AchivementModel({this.success, this.code, this.message, this.data});

  AchivementModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataAchivement>[];
      json['data'].forEach((v) {
        data!.add(new DataAchivement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataAchivement {
  int? id;
  String? userId;
  String? achievementName;
  String? level;
  String? organizer;
  String? year;
  String? file;

  DataAchivement(
      {this.id,
      this.userId,
      this.achievementName,
      this.level,
      this.organizer,
      this.year,
      this.file});

  DataAchivement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    achievementName = json['achievement_name'];
    level = json['level'];
    organizer = json['organizer'];
    year = json['year'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['achievement_name'] = this.achievementName;
    data['level'] = this.level;
    data['organizer'] = this.organizer;
    data['year'] = this.year;
    data['file'] = this.file;
    return data;
  }
}
