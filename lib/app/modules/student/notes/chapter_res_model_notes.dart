class ChapterResModelNotes {
  String? message;
  List<Chapter>? data;
  bool? success;

  ChapterResModelNotes({this.message, this.data, this.success});

  ChapterResModelNotes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Chapter>[];
      json['data'].forEach((v) {
        data!.add(Chapter.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Chapter {
  String? chapterName;
  String? chapterId;
  List<Topic>? topics;

  Chapter({this.chapterName, this.chapterId, this.topics});

  Chapter.fromJson(Map<String, dynamic> json) {
    chapterName = json['chapter_name'];
    chapterId = json['chapter_id'];
    if (json['topics'] != null) {
      topics = <Topic>[];
      json['topics'].forEach((v) {
        topics!.add(Topic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_name'] = this.chapterName;
    data['chapter_id'] = this.chapterId;
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topic {
  String? topicName;
  String? topicId;

  Topic({this.topicName, this.topicId});

  Topic.fromJson(Map<String, dynamic> json) {
    topicName = json['topic_name'];
    topicId = json['topic_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topic_name'] = this.topicName;
    data['topic_id'] = this.topicId;
    return data;
  }
}