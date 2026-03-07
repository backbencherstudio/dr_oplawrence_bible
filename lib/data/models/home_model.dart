// ============== prayer and Maditation ============
class MaditationModel {
  Verse? maditaionVerse;
  String? meditation;
  String? prayer;

  MaditationModel({this.maditaionVerse, this.meditation, this.prayer});

  MaditationModel.fromJson(Map<String, dynamic> json) {
    maditaionVerse = json['verse'] != null ? new Verse.fromJson(json['verse']) : null;
    meditation = json['meditation'];
    prayer = json['prayer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.maditaionVerse != null) {
      data['verse'] = this.maditaionVerse!.toJson();
    }
    data['meditation'] = this.meditation;
    data['prayer'] = this.prayer;
    return data;
  }
}

class maditaionVerse {
  String? id;
  String? text;
  String? reference;
  String? bookName;
  int? chapter;
  int? verseNumber;

  maditaionVerse(
      {this.id,
      this.text,
      this.reference,
      this.bookName,
      this.chapter,
      this.verseNumber});

  maditaionVerse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    reference = json['reference'];
    bookName = json['bookName'];
    chapter = json['chapter'];
    verseNumber = json['verseNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['reference'] = this.reference;
    data['bookName'] = this.bookName;
    data['chapter'] = this.chapter;
    data['verseNumber'] = this.verseNumber;
    return data;
  }
}


// ============ Bible Search ===============
class BibleSearch {
  String? topic;
  int? page;
  int? limit;
  int? total;
  List<Data>? data;

  BibleSearch({this.topic, this.page, this.limit, this.total, this.data});

  BibleSearch.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic'] = this.topic;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? text;
  int? verseNumber;
  int? chapter;
  String? bookName;
  String? reference;

  Data(
      {this.id,
      this.text,
      this.verseNumber,
      this.chapter,
      this.bookName,
      this.reference});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    verseNumber = json['verseNumber'];
    chapter = json['chapter'];
    bookName = json['bookName'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['verseNumber'] = this.verseNumber;
    data['chapter'] = this.chapter;
    data['bookName'] = this.bookName;
    data['reference'] = this.reference;
    return data;
  }
}

// ============ Bible Daily ==============
class BibleDaily {
  Verse? verse;
  String? prayer;

  BibleDaily({this.verse, this.prayer});

  BibleDaily.fromJson(Map<String, dynamic> json) {
    verse = json['verse'] != null ? new Verse.fromJson(json['verse']) : null;
    prayer = json['prayer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verse != null) {
      data['verse'] = this.verse!.toJson();
    }
    data['prayer'] = this.prayer;
    return data;
  }
}

class Verse {
  String? id;
  String? text;
  String? reference;
  String? bookName;
  int? chapter;
  int? verseNumber;

  Verse(
      {this.id,
      this.text,
      this.reference,
      this.bookName,
      this.chapter,
      this.verseNumber});

  Verse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    reference = json['reference'];
    bookName = json['bookName'];
    chapter = json['chapter'];
    verseNumber = json['verseNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['reference'] = this.reference;
    data['bookName'] = this.bookName;
    data['chapter'] = this.chapter;
    data['verseNumber'] = this.verseNumber;
    return data;
  }
}
