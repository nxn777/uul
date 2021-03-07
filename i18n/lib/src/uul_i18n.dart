import 'package:i18n_extension/i18n_extension.dart';
extension Localization on String {
  static var _t = Translations.byLocale("en") +
      {
        "en": {
          "News": "News",
          "By: %s": "By: %s",
          "Last modified at:  %s": "Last modified at: %s",
          "Information": "Information",
          "Alert": "Alert",
          "Call to action": "Call to action",
          "Poll": "Poll",
          "Reminder": "Reminder",
          "Unknown": "Unknown",
        },
        "es": {
          "News": "Noticias",
          "By: %s": "Por: %s", // as in News by -> Noticias by
          "Last modified at: %s": "Última modificación en: %s", // as Last modified at: March 6, 12-00
          "Information": "Información",
          "Alert": "Alerta",
          "Call to action": "Llamada a la acción",
          "Poll": "Encuesta",
          "Reminder": "Recordatorio",
          "Unknown": "Desconocido",
        }
      };
  String get i18n => localize(this, _t);
  String plural(int value) => localizePlural(value, this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}