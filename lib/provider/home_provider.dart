import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/model/sims_banner.dart';
import 'package:sims_ppob_irfan_ghozali/model/sims_service.dart';
import 'package:sims_ppob_irfan_ghozali/services/api_services.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoadingService = false;
  bool isLoadingBanner = false;

  SimsService? _service;
  SimsService get service => _service!;

  SimsBanners? _simsBanners;
  SimsBanners get banners => _simsBanners!;

  Future<void> getAllServices() async {
    isLoadingService = true;

    final response = await ApiService.initializeServices();
    _service = response;
    isLoadingService = false;
    notifyListeners();
  }

  Future<void> getAllBanners() async {
    isLoadingBanner = true;

    final response = await ApiService.initializeBanners();
    _simsBanners = response;
    isLoadingBanner = false;
    notifyListeners();
  }
}
