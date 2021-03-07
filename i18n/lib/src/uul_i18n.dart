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
          "Schedule": "Schedule",
          "Gym booking is not available for this day yet": "Gym booking is not available for this day yet",
          "No data for this day":  "No data for this day",
          "No gyms set": "No gyms set",
          "Gym %s" : "Gym %s",
          "All %s places are available": "All %s places are available",
          "The only place is available": "The only place is available",
          "%d places left" : "%d places left"
            .zero("No places left")
            .one("One place left"),
          "Places left: %s": "Places left: %s",
          "Also booked by:\n\n%s": "Also booked by:\n\n%s",
          "Book": "Book",
          "To book, please log in": "To book, please log in",
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
          "Schedule": "Horario",
          "Gym booking is not available for this day yet": "La reserva del gimnasio aún no está disponible para este día",
          "No data for this day": "No hay datos para este día",
          "No gyms set": "No hay gimnasios establecidos",
          "Gym %s": "Gymnasio %s",
          "All %s places are available": "Los %s lugares están disponibles",
          "The only place is available": "El único lugar está disponible",
          "%d places left" : "Quedan %d lugares"
              .zero("No quedan lugares")
              .one("Queda un lugar"),
          "Places left: %s": "Quedan %s lugares",
          "Also booked by:\n\n%s": "También reservado por: \n\n%s",
          "Book": "Reservar",
          "To book, please log in": "Para reservar, inicie sesión"
        }
      };
  String get i18n => localize(this, _t);
  String plural(int value) => localizePlural(value, this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}