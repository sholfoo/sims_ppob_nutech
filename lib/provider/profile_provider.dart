import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/model/profile.dart';
import 'package:sims_ppob_irfan_ghozali/services/api_services.dart';
import 'package:sims_ppob_irfan_ghozali/shared/shared_prefs.dart';

class ProfileProvider extends ChangeNotifier {
  bool isLoadingProfile = false;
  bool isUpdatingProfile = false;

  Profile? _profile;
  Profile get profile => _profile!;

  String? _userNamePref;
  String get userNamePreference => _userNamePref!;

  String? _userEmailPref;
  String get userEmailPreference => _userEmailPref!;

  String? _userImagePref;
  String get userImagePreference => _userImagePref!;

  Future<void> getProfile() async {
    isLoadingProfile = true;

    final response = await ApiService.initializeProfile();
    _profile = response;

    SharedPrefManager().addStringToSF(KEY_USER_EMAIL, _profile!.data!.email!);
    SharedPrefManager().addStringToSF(KEY_USER_NAME,
        '${_profile!.data!.firstName!} ${_profile!.data!.lastName}');
    SharedPrefManager()
        .addStringToSF(KEY_USER_AVATAR, _profile!.data!.profileImage!);

    isLoadingProfile = false;
    notifyListeners();
  }

  Future<void> updateProfile(String firstName, String lastName) async {
    isLoadingProfile = true;

    final response = await ApiService.updateProfile(firstName, lastName);
    _profile = response;

    SharedPrefManager().addStringToSF(KEY_USER_EMAIL, _profile!.data!.email!);
    SharedPrefManager().addStringToSF(KEY_USER_NAME,
        '${_profile!.data!.firstName!} ${_profile!.data!.lastName}');

    isLoadingProfile = false;
    notifyListeners();
  }

  Future<void> updateProfileImage(String selectedImagePath) async {
    isLoadingProfile = true;

    final response = await ApiService.updateProfileImage(selectedImagePath);
    _profile = response;

    SharedPrefManager()
        .addStringToSF(KEY_USER_AVATAR, _profile!.data!.profileImage!);

    isLoadingProfile = false;
    notifyListeners();
  }

  Future<void> getSavedPreferences() async {
    await SharedPrefManager().getStringValueSF(KEY_USER_NAME).then((value) {
      if (value != null) {
        _userNamePref = value;
        notifyListeners();
      }
    });
    await SharedPrefManager().getStringValueSF(KEY_USER_AVATAR).then((value) {
      if (value != null) {
        _userImagePref = value;
        notifyListeners();
      }
    });
    await SharedPrefManager().getStringValueSF(KEY_USER_EMAIL).then((value) {
      if (value != null) {
        _userEmailPref = value;
        notifyListeners();
      }
    });
  }
}
