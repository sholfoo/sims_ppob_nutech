import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/model/transaction.dart';
import 'package:sims_ppob_irfan_ghozali/services/api_services.dart';

class TrxProvider extends ChangeNotifier {
  bool isLoading = false;

  Transaction? _trxPayment;
  Transaction get transaction => _trxPayment!;

  Future<void> attempTrxPayment(String serviceCode) async {
    isLoading = true;
    notifyListeners();

    final response = await ApiService.paymentTransaction(serviceCode);

    if (response!.status == 0) {
      _trxPayment = response;

      isLoading = false;
      notifyListeners();
    }
  }
}
