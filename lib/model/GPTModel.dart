class GPTModel {
  Data? data;

  GPTModel({this.data});

  GPTModel.fromJson(Map<String, dynamic> json) {
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
  String? answer;
  List<Instructions>? instructions;
  List<PopularQuestions>? popularQuestions;

  Data({this.answer, this.instructions, this.popularQuestions});

  Data.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    if (json['instructions'] != null) {
      instructions = <Instructions>[];
      json['instructions'].forEach((v) {
        instructions!.add(new Instructions.fromJson(v));
      });
    }
    if (json['popular_questions'] != null) {
      popularQuestions = <PopularQuestions>[];
      json['popular_questions'].forEach((v) {
        popularQuestions!.add(new PopularQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    if (this.instructions != null) {
      data['instructions'] = this.instructions!.map((v) => v.toJson()).toList();
    }
    if (this.popularQuestions != null) {
      data['popular_questions'] =
          this.popularQuestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Instructions {
  int? id;
  String? title;

  Instructions({this.id, this.title});

  Instructions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class PopularQuestions {
  int? id;
  int? categoryId;
  String? question;
  int? totalLikes;

  PopularQuestions({this.id, this.categoryId, this.question, this.totalLikes});

  PopularQuestions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    question = json['question'];
    totalLikes = json['total_likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['question'] = this.question;
    data['total_likes'] = this.totalLikes;
    return data;
  }
}
