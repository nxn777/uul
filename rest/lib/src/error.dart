import 'package:i18n/i18n.dart';
// should be in sync with Error.cs
class UULError {
  // Auth
  static const int AuthFailed = 101;
// Profile errors
      static const int ProfileNotFound = 1001;
  static const int ProfileHabitantLookupFailed = 1002;
  static const int ProfileLastHabitantDeletion = 1003;
  static const int ProfileNotActivated = 1004;
  static const int ProfileValidationFailed = 1005;
  static const int ProfileChangePwdFailed = 1006;
  static const int ProfileAddHabitantFailed = 1007;
  static const int ProfileEditHabitantFailed = 1008;
  static const int ProfileDeleteHabitantFailed = 1009;
  static const int ProfileDeletionFailed = 1010;
  static const int ProfileLoginFailed = 1011;
  static const int ProfileAlreadyExists = 1012;
  static const int ProfileCreationFailed = 1013;
  static const int ProfileGetInfoFailed = 1014;
// Rules errors
  static const int RulesNotFound = 2001;
  static const int RulesGetFailed = 2002;
// TimeSlot errors
  static const int TimeSlotNotFound = 3001;
  static const int TimeSlotNotToday = 3002;
  static const int TimeSlotFull = 3003;
  static const int TimeSlotOverbooking = 3004;
  static const int TimeSlotsBookingFailed = 3005;
  static const int TimeSlotsGetFailed = 3006;
// Gym errors
  static const int GymClosed = 4001;
// News errors
  static const int NewsGetFailed = 5001;

  static String getMessage(int code) {
    switch (code) {
      case UULError.ProfileNotFound:
        return "Profile not found".i18n;
      case UULError.ProfileHabitantLookupFailed:
        return "Inhabitant not found".i18n;
      case UULError.ProfileLastHabitantDeletion:
        return "Can not delete the last inhabitant".i18n;
      case UULError.RulesNotFound:
        return "Rules not found".i18n;
      case UULError.ProfileNotActivated:
        return "Profile is not activated".i18n;
      case UULError.TimeSlotNotFound:
        return "Timeslot not found".i18n;
      case UULError.GymClosed:
        return "Gym is closed".i18n;
      case UULError.TimeSlotNotToday:
        return "Only todays' timeslots can be booked".i18n;
      case UULError.TimeSlotFull:
        return "TimeSlot is full".i18n;
      case UULError.TimeSlotOverbooking:
        return "This inhabitant already booked a gym today".i18n;
      case UULError.AuthFailed:
        return "Wrong credentials".i18n;
      case UULError.ProfileValidationFailed:
        return "Profile data is not valid".i18n;
      case UULError.ProfileChangePwdFailed:
        return "Failed to change password".i18n;
      case UULError.ProfileAddHabitantFailed:
        return "Failed to add the inhabitant".i18n;
      case UULError.ProfileEditHabitantFailed:
        return "Failed to edit the inhabitant".i18n;
      case UULError.ProfileDeleteHabitantFailed:
        return "Failed to delete the inhabitant".i18n;
      case UULError.ProfileDeletionFailed:
        return "Failed to delete the profile".i18n;
      case UULError.ProfileLoginFailed:
        return "Login failed".i18n;
      case UULError.ProfileAlreadyExists:
        return "Profile already exists".i18n;
      case UULError.ProfileCreationFailed:
        return "Profile creation failed".i18n;
      case UULError.ProfileGetInfoFailed:
        return "Profile info retrieval failed".i18n;
      case UULError.RulesGetFailed:
        return "Rules retrieval failed".i18n;
      case UULError.TimeSlotsBookingFailed:
        return "Timeslot booking failed".i18n;
      case UULError.TimeSlotsGetFailed:
        return "Timeslots retrieval failed".i18n;
      case UULError.NewsGetFailed:
        return "News retrieval failed".i18n;
    }
    return "No description".i18n;
  }
}