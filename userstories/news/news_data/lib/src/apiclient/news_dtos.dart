
import 'package:core/core.dart';
import 'package:rest/rest.dart';
class NewsPaperDTO implements HasFromJson, HasMapToDomain<NewsPaper> {
  List<NewsDto> news;

  NewsPaperDTO({this.news});

  @override
  NewsPaper mapToDomain() {
    return NewsPaper(news.map((e) => e.mapToDomain()).toList());
  }

  @override
  populateFromJson(jsonRaw) {
    news = jsonRaw['news'] != null ? (jsonRaw['news'] as List).map((e) => NewsDto.fromJson(e)).toList() : [];
  }
}

class NewsDto implements HasFromJson, HasMapToDomain<News>{
    int auditory;
    String author;
    String content;
    String createdAt;
    int id;
    String lastModifiedAt;
    String title;
    String updatedAt;

    NewsDto({this.auditory, this.author, this.content, this.createdAt, this.id, this.lastModifiedAt, this.title, this.updatedAt});

    factory NewsDto.fromJson(Map<String, dynamic> json) {
        return NewsDto(
            auditory: json['auditory'],
            author: json['author'],
            content: json['content'],
            createdAt: json['createdAt'],
            id: json['id'],
            lastModifiedAt: json['lastModifiedAt'],
            title: json['title'],
            updatedAt: json['updatedAt'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['auditory'] = this.auditory;
        data['author'] = this.author;
        data['content'] = this.content;
        data['createdAt'] = this.createdAt;
        data['id'] = this.id;
        data['lastModifiedAt'] = this.lastModifiedAt;
        data['title'] = this.title;
        data['updatedAt'] = this.updatedAt;
        return data;
    }

  @override
  News mapToDomain() {
    return News(id, title, content, author, DateTime.tryParse(createdAt).toLocal(), DateTime.tryParse(updatedAt).toLocal(), DateTime.tryParse(lastModifiedAt).toLocal(), auditory.toAuditory(Auditory.GUESTS));
  }

  @override
  populateFromJson(json) {
    auditory = json['auditory'];
    author = json['author'];
    content = json['content'];
    createdAt = json['createdAt'];
    id = json['id'];
    lastModifiedAt = json['lastModifiedAt'];
    title = json['title'];
    updatedAt = json['updatedAt'];
  }
}