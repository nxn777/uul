import 'package:rest/rest.dart';
import 'rules_dtos.dart';

class RulesApiClient {
  static Future<UULResponse<RulesDTO>> fetchRules() async {
    var response;
    try {
      response = await getDio().get("/api/Rules");
      return UULResponse.fromResponse(response, RulesDTO());
    } catch (e) {
      return UULResponse.fromException(e);
    }
  }
}
