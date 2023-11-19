import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/model/history.dart';
import 'package:sims_ppob_irfan_ghozali/services/api_services.dart';

class HistoryProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoadMore = false;

  History? _history;
  History get transactionHistory => _history!;

  int? _offset = 0;
  int get lastOffset => _offset!;

  List<Record> _records = [];
  List<Record> get recordHistory => _records;

  Future<void> getTransactionHistory() async {
    isLoading = true;
    _records = [];
    final response = await ApiService.initializeTransactionHistory(0, 5);
    _history = response;
    _records.addAll(response!.data.records);
    isLoading = false;
    _offset = 6;
    notifyListeners();
  }

  Future<void> loadMoreTransactionHistory(int offset, int limit) async {
    isLoadMore = true;
    notifyListeners();
    final response =
        await ApiService.initializeTransactionHistory(offset, limit);
    _history = response;
    _records.addAll(response!.data.records);
    isLoadMore = false;
    _offset = (_offset! + limit);
    notifyListeners();
  }
}
