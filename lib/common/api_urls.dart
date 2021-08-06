class ApiUrls {
  //DEV
  // static const String baseUrl = 'https://dev.sortstring.co/api/';
  // static const String baseUrlMain = 'https://dev.sortstring.co';

  //Production Url
  static const String baseUrl = 'https://healthways.sortstring.co.in/api/';
  static const String baseUrlMain = 'https://healthways.sortstring.co.in';

  static const String login = baseUrl + 'login';
  static const String logout = baseUrl + 'logout';
  static const String sendOtp = baseUrl + 'send-otp';
  static const String getUserOrderList = baseUrl + 'get-user-order-list';
  static const String getUserList = baseUrl + 'get-user-list';
  static const String getUserVehicleList = baseUrl + 'get-user-vehicle-list';
  static const String getMasterData = baseUrl + 'get-master-data';
  static const String dispatchCrates = baseUrl + 'dispatch-crates';
  static const String receivedCrates = baseUrl + 'received-crates';
}
