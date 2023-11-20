// ignore_for_file: avoid_print
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:sims_ppob_irfan_ghozali/configs/constants.dart';
import 'package:sims_ppob_irfan_ghozali/model/auth_login.dart';
import 'package:sims_ppob_irfan_ghozali/model/auth_register.dart';
import 'package:sims_ppob_irfan_ghozali/model/balance.dart';
import 'package:sims_ppob_irfan_ghozali/model/history.dart';
import 'package:sims_ppob_irfan_ghozali/model/profile.dart';
import 'package:sims_ppob_irfan_ghozali/model/sims_banner.dart';
import 'package:sims_ppob_irfan_ghozali/model/sims_service.dart';
import 'package:sims_ppob_irfan_ghozali/model/transaction.dart';
import 'package:sims_ppob_irfan_ghozali/shared/shared_prefs.dart';

class ApiService {
  static Future<LoginAuth?> initLogin(String mEmail, String mPassword) async {
    try {
      String url = Constants.apiServices.userLoginApi;
      Dio dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (_) => true,
      ));
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var responseDio = await dio.post(
        url,
        data: {'email': mEmail, 'password': mPassword},
      );

      print("LOGIN Response Body ${responseDio.data}");

      return LoginAuth.fromJson(responseDio.data);
    } on DioError catch (e) {
      print("Exception $e");
      return null;
    }
  }

  static Future<RegisterAuth?> initRegister(
      {required String email,
      required String firstName,
      required String lastName,
      required String password}) async {
    try {
      String url = Constants.apiServices.userRegisterApi;
      Dio dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (_) => true,
      ));
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var responseDio = await dio.post(
        url,
        options: Options(headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        data: {
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'password': password,
        },
      );

      print("REGISTER Response Body ${responseDio.data}");
      return RegisterAuth.fromJson(responseDio.data);
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  static Future<Profile?> initializeProfile() async {
    String? auth =
        await SharedPrefManager().getStringValueSF(KEY_USER_AUTH_TOKEN);
    print('GET PROFILE TOKEN = ${auth!}');
    try {
      String url = Constants.apiServices.profileApi;
      Dio dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (_) => true,
      ));
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var responseDio = await dio.get(
        url,
        options: Options(headers: <String, String>{
          'Authorization': 'Bearer $auth',
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        }),
      );
      print("PROFILE Response Body ${responseDio.data}");
      return Profile.fromJson(responseDio.data);
    } on DioError catch (e) {
      print("Exception $e");
      return null;
    }
  }

  static Future<Balance?> initializeBalance() async {
    String? auth =
        await SharedPrefManager().getStringValueSF(KEY_USER_AUTH_TOKEN);
    try {
      String url = Constants.apiServices.balanceApi;
      Dio dio = Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var responseDio = await dio.get(
        url,
        options: Options(headers: <String, String>{
          'Authorization': 'Bearer $auth',
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        }),
      );
      print("BALANCE Response Body ${responseDio.data}");
      return Balance.fromJson(responseDio.data);
    } on DioError catch (e) {
      print("Exception $e");
      return null;
    }
  }

  static Future<SimsService?> initializeServices() async {
    String? auth =
        await SharedPrefManager().getStringValueSF(KEY_USER_AUTH_TOKEN);
    try {
      String url = Constants.apiServices.servicesApi;
      Dio dio = Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var responseDio = await dio.get(
        url,
        options: Options(headers: <String, String>{
          'Authorization': 'Bearer $auth',
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        }),
      );
      print("SERVICE Response Body ${responseDio.data}");
      return SimsService.fromJson(responseDio.data);
    } on DioError catch (e) {
      print("Exception $e");
      return null;
    }
  }

  static Future<SimsBanners?> initializeBanners() async {
    String? auth =
        await SharedPrefManager().getStringValueSF(KEY_USER_AUTH_TOKEN);
    try {
      String url = Constants.apiServices.bannersApi;
      Dio dio = Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var responseDio = await dio.get(
        url,
        options: Options(headers: <String, String>{
          'Authorization': 'Bearer $auth',
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        }),
      );
      print("BANNERS Response Body ${responseDio.data}");
      return SimsBanners.fromJson(responseDio.data);
    } on DioError catch (e) {
      print("Exception $e");
      return null;
    }
  }

  static Future<History?> initializeTransactionHistory(
      int offset, int limit) async {
    String? auth =
        await SharedPrefManager().getStringValueSF(KEY_USER_AUTH_TOKEN);
    try {
      String url = Constants.apiServices.trxHistoryApi;
      Dio dio = Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var responseDio = await dio.get(
        url,
        options: Options(headers: <String, String>{
          'Authorization': 'Bearer $auth',
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        }),
        queryParameters: {'offset': offset, 'limit': limit},
      );
      print("HISTORY Response Body ${responseDio.data}");
      return History.fromJson(responseDio.data);
    } on DioError catch (e) {
      print("Exception $e");
      return null;
    }
  }

  static Future<Balance?> attempTopupBalance(int topUpAmount) async {
    String? auth =
        await SharedPrefManager().getStringValueSF(KEY_USER_AUTH_TOKEN);
    try {
      String url = Constants.apiServices.topUpBalanceApi;
      Dio dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (_) => true,
      ));
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var responseDio = await dio.post(
        url,
        options: Options(headers: <String, String>{
          'Authorization': 'Bearer $auth',
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        }),
        data: {'top_up_amount': topUpAmount},
      );

      print("TOPUP BALANCE Response Body ${responseDio.data}");

      return Balance.fromJson(responseDio.data);
    } on DioError catch (e) {
      print("Exception $e");
      return null;
    }
  }

  static Future<Transaction?> paymentTransaction(String serviceCode) async {
    String? auth =
        await SharedPrefManager().getStringValueSF(KEY_USER_AUTH_TOKEN);
    try {
      String url = Constants.apiServices.trxPaymentApi;
      Dio dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (_) => true,
      ));
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var responseDio = await dio.post(
        url,
        options: Options(headers: <String, String>{
          'Authorization': 'Bearer $auth',
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        }),
        data: {'service_code': serviceCode},
      );

      print("TRX PAYMENT Response Body ${responseDio.data}");

      return Transaction.fromJson(responseDio.data);
    } on DioError catch (e) {
      print("Exception $e");
      return null;
    }
  }

  static Future<Profile?> updateProfile(
      String firstName, String lastName) async {
    String? auth =
        await SharedPrefManager().getStringValueSF(KEY_USER_AUTH_TOKEN);
    try {
      String url = Constants.apiServices.profileUpdateApi;
      Dio dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (_) => true,
      ));
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var responseDio = await dio.put(
        url,
        options: Options(headers: <String, String>{
          'Authorization': 'Bearer $auth',
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        }),
        data: {'first_name': firstName, 'last_name': lastName},
      );

      print("UPDATE PROFILE Response Body ${responseDio.data}");

      return Profile.fromJson(responseDio.data);
    } on DioError catch (e) {
      print("Exception $e");
      return null;
    }
  }

  static Future<Profile?> updateProfileImage(String mImagePath) async {
    String? auth =
        await SharedPrefManager().getStringValueSF(KEY_USER_AUTH_TOKEN);
    try {
      String url = Constants.apiServices.profileImageUpdateApi;
      String fileName = mImagePath.split('/').last;
      Dio dio = Dio(BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (_) => true,
      ));
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          mImagePath,
          filename: fileName,
        ),
      });

      var responseDio = await dio.put(
        url,
        options: Options(headers: <String, String>{
          'Authorization': 'Bearer $auth',
          'Content-Type': 'multipart/form-data',
        }),
        data: formData,
      );

      print("UPDATE PROFILE Response Body ${responseDio.data}");

      return Profile.fromJson(responseDio.data);
    } on DioError catch (e) {
      print("Exception $e");
      return null;
    }
  }
}
