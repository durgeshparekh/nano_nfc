class HttpHandler {
  static String baseUrl = 'http://3.110.94.182:3002/mobileapp/';

  static String userLoginUrl = baseUrl + 'auth/login';
  static String userRegistrationUrl = baseUrl + 'auth/register';
  static String forgotPasswordUrl = baseUrl + 'auth/forgotPassword';

  static String fetchDataUrl = baseUrl + 'sync/fetchData';
  static String manageDataUrl = baseUrl + 'sync/manageData';
  static String deleteDataUrl = baseUrl + 'sync/deleteData';
}
