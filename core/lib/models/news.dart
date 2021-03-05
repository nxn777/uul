class News {
  final int id;
  final String title;
  final String content;
  final String author;
  final DateTime createAt;
  final DateTime updatedAt;
  final DateTime modifiedAt;
  final Auditory auditory;

  News(this.id, this.title, this.content, this.author, this.createAt, this.updatedAt, this.modifiedAt, this.auditory);
}

enum Auditory {
  GUESTS, REGISTERED, ACTIVATED
}
