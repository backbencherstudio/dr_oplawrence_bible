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
  BibleVerse({required this.id, required this.number, required this.text});
  factory BibleVerse.fromJson(Map<String, dynamic> json) {
    return BibleVerse(
      id: json['id'],
      number: json['number'] as int,
      text: json['text'],
    );
  }
}

class BibleNote {
  final String id;
  final String verseId;
  final String note;
  final String reference;
  final DateTime createdAt;
  final DateTime updatedAt;

  BibleNote({
    required this.id,
    required this.verseId,
    required this.note,
    required this.reference,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BibleNote.fromJson(Map<String, dynamic> json) {
    return BibleNote(
      id: json['id'] ?? '',
      verseId: json['verseId'] ?? '',
      note: json['note'] ?? '',
      reference: json['reference'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "verseId": verseId,
      "note": note,
      "reference": reference,
    };
  }
}