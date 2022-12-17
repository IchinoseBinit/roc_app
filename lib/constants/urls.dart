import 'constants.dart';

class ApiEndpoints {
  static const _baseUrl = "https://office.kushtech.com.np";
  static const loginUrl = "$_baseUrl/api-login/";

  static const _apiUrl = "$_baseUrl/api";

  static const branchUrl = "$_apiUrl/branch/";
  static const imagesUrl = "$_apiUrl/images/";
  static const newsUrl = "$_apiUrl/news/";
  static const noticeUrl = "$_apiUrl/notice/";
  static const staffUrl = "$_apiUrl/staff/";
  static const videosUrl = "$_apiUrl/videos/";

  static const weatherUrl =
      "https://api.openweathermap.org/data/2.5/weather?lat=latitude&lon=longitude&appid=${UserConstants.apiKey}&units=metric";
}
