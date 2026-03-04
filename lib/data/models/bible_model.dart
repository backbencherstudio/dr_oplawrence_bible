class BibleBook {
  final String id;
  final String name;

  BibleBook({required this.id, required this.name});

  factory BibleBook.fromJson(Map<String, dynamic> json) {
    return BibleBook(id: json['id'], name: json['name']);
  }
}

class BibleChapter {
  final String id;
  final int number;
  BibleChapter({required this.id, required this.number});
  factory BibleChapter.fromJson(Map<String, dynamic> json) {
    return BibleChapter(id: json['id'], number: json['number'] as int);
  }
}

class BibleVerse {
  final String id;
  final int number;
  final String text;
  BibleVerse({required this.id, required this.number,required this.text});
  factory BibleVerse.fromJson(Map<String, dynamic> json) {
    return BibleVerse(id: json['id'], number: json['number'] as int,text: json['text'],);
  }
}