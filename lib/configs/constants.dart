class Constants {
  static ApiServices get apiServices => ApiServices();
  static NavigationMenu get navigation => NavigationMenu();
  static DateFormat get dateFormat => DateFormat();
}

class NavigationMenu {
  String get navigationHome => 'Home';
  String get navigationTopup => 'Top Up';
  String get navigationTrx => 'Transaction';
  String get navigationNotification => 'Inbox';
  String get navigationAccount => 'Account';
}

class DateFormat {
  String get dateFormatDayAndMonth => 'EEEE, dd MMM yyyy';
  String get dateFormatMonth => 'dd MMM yyyy';
  String get dateFormatRequest => 'yyyy-MM-dd';
  String get dateFormatWeekday => 'EEEE';
  String get dateFormatMonthAndYear => 'MMMM yyyy';
}

class ApiServices {
  String get apiBaseUrl => "https://take-home-test-api.nutech-integrasi.app/";
  String get userLoginApi => "${apiBaseUrl}login";
  String get userRegisterApi => "${apiBaseUrl}registration";
  String get profileApi => "${apiBaseUrl}profile";
  String get balanceApi => "${apiBaseUrl}balance";
  String get servicesApi => "${apiBaseUrl}services";
  String get bannersApi => "${apiBaseUrl}banner";
  String get trxHistoryApi => "${apiBaseUrl}transaction/history?";
  String get topUpBalanceApi => "${apiBaseUrl}topup";
  String get trxPaymentApi => "${apiBaseUrl}transaction";
}
