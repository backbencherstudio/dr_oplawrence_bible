class SearchModel {
  String? topic;
  int? page;
  int? limit;
  int? total;
  List<VerseData>? data;

  SearchModel({this.topic, this.page, this.limit, this.total, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    page = json['page'];
    limit = json['limit'];
    total = json['total'];

    if (json['data'] != null) {
      data = <VerseData>[];
      json['data'].forEach((v) {
        data!.add(VerseData.fromJson(v));
      });
    }
  }
}

class VerseData {
  String? id;
  String? text;
  int? verseNumber;
  int? chapter;
  String? bookName;
  String? reference;

  VerseData({
    this.id,
    this.text,
    this.verseNumber,
    this.chapter,
    this.bookName,
    this.reference,
  });

  VerseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    verseNumber = json['verseNumber'];
    chapter = json['chapter'];
    bookName = json['bookName'];
    reference = json['reference'];
  }
}