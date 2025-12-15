class ApiConstants {
  static const String mainUrl = "https://doctor-api.smartmobile.uz";
  static const apiEgov = "/api/egov";
  static const apiDoctor = "/api/doctor";
  static const apiList = '/api/list';

  // Auth
  static const String login = "$apiEgov/auth";
  static const String register = "$apiDoctor/register";
  static const String token = "$apiEgov/get-token";
  static const String logout = "$apiEgov/logout";

  // Profile
  static const String avatar = "$apiDoctor/file/avatar";
  static const String document = "$apiDoctor/file";

  // Work Schedule
  static const String workSchedule = "$apiDoctor/schedule";

  // Clinic
  static const String clinic = "$apiList/clinic";
  static const String region = "$apiList/region";
  static const String degree = "$apiList/degree";

  // Issue
  static const String issue = "$mainUrl/api/issue";
}
