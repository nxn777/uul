import 'package:rest/rest.dart';
import 'news_dtos.dart';

abstract class NewsApiClient {
  Future<UULResponse<NewsPaperDTO>> fetchNewsPaper();
}

class DefaultNewsApiClient implements NewsApiClient {
  UULDio _uulDio;

  DefaultNewsApiClient(this._uulDio);

  @override
  Future<UULResponse<NewsPaperDTO>> fetchNewsPaper() async {
    var response;
    try {
      response = await _uulDio.getInstance().get("/api/news/list");
      var result = UULResponse.fromResponse(response, NewsPaperDTO());
      return result;
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }

}