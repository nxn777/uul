class NewsPaper {
  final List<News> news;

  NewsPaper(this.news);
}

class News {
  final int id;
  final String title;
  final String content;
  final String author;
  final DateTime createAt;
  final DateTime updatedAt;
  final DateTime modifiedAt;
  final Auditory auditory;
  final NewsType type;

  News(this.id, this.title, this.content, this.author, this.createAt, this.updatedAt, this.modifiedAt, this.auditory, this.type);
}

enum Auditory {
  GUESTS, REGISTERED, ACTIVATED
}

enum NewsType {
  INFO, ALERT, CALL_TO_ACTION, POLL, REMINDER
}

extension AuditoryFromInt on int {
  Auditory toAuditory(Auditory defaultValue) {
    switch (this) { // TODO maybe use values and indexes
      case 0: return Auditory.GUESTS;
      case 1: return Auditory.REGISTERED;
      case 2: return Auditory.ACTIVATED;
    }
    return defaultValue;
  }
}

extension NewsTypeFromInt on int {
  NewsType toNewsType(NewsType defaultValue) {
    var result = NewsType.INFO;
    try {
      result = NewsType.values.elementAt(this);
    } catch (e) {
      result = defaultValue;
    }
    return result;
  }
}