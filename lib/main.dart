import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/provider/balance_provider.dart';
import 'package:sims_ppob_irfan_ghozali/provider/history_provider.dart';
import 'package:sims_ppob_irfan_ghozali/provider/home_provider.dart';
import 'package:sims_ppob_irfan_ghozali/provider/profile_provider.dart';
import 'package:sims_ppob_irfan_ghozali/provider/trx_provider.dart';
import 'package:sims_ppob_irfan_ghozali/screen/auth/login_page.dart';
import 'package:sims_ppob_irfan_ghozali/provider/auth_provider.dart';
import 'package:sims_ppob_irfan_ghozali/screen/home_page.dart';
import 'package:sims_ppob_irfan_ghozali/shared/shared_prefs.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/custom_animation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => BalanceProvider()),
      ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ChangeNotifierProvider(create: (_) => TrxProvider()),
    ],
    child: const SIMSApp(),
  ));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class SIMSApp extends StatefulWidget {
  const SIMSApp({super.key});

  @override
  State<SIMSApp> createState() => _SIMSAppState();
}

class _SIMSAppState extends State<SIMSApp> {
  bool userIsLoggedin = false;

  getLoginState() async {
    await SharedPrefManager().getBoolValueSF(KEY_IS_LOGGEDIN).then((value) {
      setState(() {
        {
          if (value != null) {
            userIsLoggedin = value;
          } else {
            userIsLoggedin = false;
          }
        }
      });
    });
  }

  @override
  void initState() {
    getLoginState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: fontFamily,
        primarySwatch: Colors.red,
      ),
      home: userIsLoggedin ? const HomePageScreen() : const LoginPageScreen(),
      builder: EasyLoading.init(),
    );
  }
}
