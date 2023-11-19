import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/model/balance.dart';
import 'package:sims_ppob_irfan_ghozali/services/api_services.dart';
import 'package:sims_ppob_irfan_ghozali/shared/shared_prefs.dart';

class BalanceProvider extends ChangeNotifier {
  bool isLoadingBalance = false;
  bool isLoadingTopUp = false;

  Balance? _balance;
  Balance get balance => _balance!;

  Future<void> getBalance() async {
    isLoadingBalance = true;

    final response = await ApiService.initializeBalance();
    _balance = response;
    isLoadingBalance = false;
    notifyListeners();
  }

  Future<void> attempTopUpBalance(int topUpAmount) async {
    isLoadingTopUp = true;
    notifyListeners();

    final response = await ApiService.attempTopupBalance(topUpAmount);

    if (response!.status == 0) {
      _balance = response;
      SharedPrefManager().addIntToSF(KEY_USER_BALANCE, _balance!.data.balance);

      isLoadingTopUp = false;
      notifyListeners();
    }
  }
}
