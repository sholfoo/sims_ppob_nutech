import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/model/auth_login.dart';
import 'package:sims_ppob_irfan_ghozali/model/auth_register.dart';
import 'package:sims_ppob_irfan_ghozali/screen/home_page.dart';
import 'package:sims_ppob_irfan_ghozali/services/api_services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sims_ppob_irfan_ghozali/shared/shared_prefs.dart';
import 'package:sims_ppob_irfan_ghozali/utils/util.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;

  LoginAuth? _loginAuth;
  LoginAuth get profile => _loginAuth!;

  RegisterAuth? _registerAuth;
  RegisterAuth get balance => _registerAuth!;

  Future<void> initLogin(
      BuildContext context, String email, String password) async {
    if (email.isEmpty && password.isEmpty) {
      Utility.snackbarFieldAlert(context, 'Email & Password');
      return;
    }

    Utility.loadingDialog(context, false, baseTextApp);
    isLoading = true;
    notifyListeners();

    final response = await ApiService.initLogin(email, password);

    if (!context.mounted) return;

    if (response!.status == 0) {
      _loginAuth = response;
      SharedPrefManager().addBoolToSF(KEY_IS_LOGGEDIN, true);
      SharedPrefManager()
          .addStringToSF(KEY_USER_AUTH_TOKEN, response.data!.token!);
      print('TOKEN = ${response.data!.token!}');
      isLoading = false;
      notifyListeners();
      Navigator.pop(context);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          reverseDuration: const Duration(milliseconds: 200),
          child: const HomePageScreen(),
        ),
      );
    } else {
      Navigator.pop(context);
      Utility.snackbarAlert(context, response.message!);
    }
  }

  Future<void> initRegister(
      BuildContext context,
      String email,
      String firstName,
      String lastName,
      String password,
      String confirmPass) async {
    if (email.isEmpty) {
      Utility.snackbarFieldAlert(context, 'Email');
      return;
    }

    if (firstName.isEmpty) {
      Utility.snackbarFieldAlert(context, 'First Name');
      return;
    }

    if (lastName.isEmpty) {
      Utility.snackbarFieldAlert(context, 'Last Name');
      return;
    }

    if (password.isEmpty) {
      Utility.snackbarFieldAlert(context, 'Password');
      return;
    }

    if (confirmPass.isEmpty) {
      Utility.snackbarFieldAlert(context, 'Confirmation Password');
      return;
    }

    Utility.loadingDialog(context, false, baseTextApp);
    isLoading = true;
    notifyListeners();

    final response = await ApiService.initRegister(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password);

    if (!context.mounted) return;

    if (response!.status == 0) {
      _registerAuth = response;
      isLoading = false;
      notifyListeners();

      Navigator.pop(context);
      Utility.snackbarAlert(context, response.message);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      Utility.snackbarAlert(context, response.message);
    }
    _registerAuth = response;
    isLoading = false;
    notifyListeners();
  }
}
