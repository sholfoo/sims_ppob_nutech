import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/widget_dialog_expired_token.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/widget_dialog_loading.dart';

class Utility {
  showLoaderDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text(
                message,
                textScaleFactor: 1.0,
                style: const TextStyle(color: Colors.black87, fontSize: 12),
              )),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // DIALOG
  static void loadingDialog(
      BuildContext context, bool dismissable, Color color) {
    showDialog(
      context: context,
      barrierDismissible: dismissable,
      builder: (BuildContext context) => DialogLoading(
        dialogColor: color,
      ),
    );
  }

  static void snackbarAlert(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: backgroundBaseApp,
      content: Text(
        message,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void snackbarFieldAlert(BuildContext context, String field) {
    final snackBar = SnackBar(
      backgroundColor: backgroundBaseApp,
      content: Text(
        '$field field is required, \nplease complete the form properly!',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showExpiredAuthDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: backgroundBaseWhite,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: const EdgeInsets.only(top: 0.0),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return WidgetDialogExpiredAuth(
                  message: message,
                );
              },
            ),
          );
        });
  }
}

String rupiah(value, {String separator = '.', String trailing = ''}) {
  return "Rp ${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}$separator')}$trailing";
}

String setupIDR(value, {String separator = '.', String trailing = ''}) {
  return "${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}$separator')}$trailing";
}
