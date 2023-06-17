class LikesQuestionModel {
  Data? data;

  LikesQuestionModel({this.data});

  LikesQuestionModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? count;
  bool? isLiked;

  Data({this.count, this.isLiked});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    isLiked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['is_liked'] = this.isLiked;
    return data;
  }
}
