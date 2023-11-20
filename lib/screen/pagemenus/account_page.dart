import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/provider/profile_provider.dart';
import 'package:sims_ppob_irfan_ghozali/utils/util.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/action_bar_widget.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/button_fill_widget.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/button_outlined_widget.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/textformfield_widget.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/widget_dialog_logout.dart';
import 'package:animation_wrappers/animation_wrappers.dart';

class AccountPageScreen extends StatefulWidget {
  final VoidCallback onBackPressed;
  const AccountPageScreen({super.key, required this.onBackPressed});

  @override
  State<AccountPageScreen> createState() => _AccountPageScreenState();
}

class _AccountPageScreenState extends State<AccountPageScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  ProfileProvider? profileProvider;

  bool isEditProfile = false;

  final ImagePicker _picker = ImagePicker();
  String? _imgSelectPath;

  Future<void> getImage() async {
    try {
      XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imgSelectPath = pickedFile.path;

          Utility.loadingDialog(context, false, baseTextApp);
          Provider.of<ProfileProvider>(context, listen: false)
              .updateProfileImage(_imgSelectPath!)
              .then((value) => {
                    if (value == 'success')
                      {
                        Navigator.pop(context),
                        Utility.snackbarAlert(
                            context, 'Update foto profile berhasil.'),
                      }
                    else
                      {
                        Navigator.pop(context),
                        Utility.snackbarAlert(context, value),
                      }
                  });
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ActionBarWidget(
            actionBarTitle: 'Akun',
            onActionBackToDashboard: widget.onBackPressed,
          ),
          FadedScaleAnimation(child: _detailView()),
          spaceHeight24,
          FadedScaleAnimation(child: _formEditProfile()),
        ],
      ),
    );
  }

  Widget _detailView() {
    profileProvider = Provider.of<ProfileProvider>(context);
    return Column(
      children: [
        spaceHeight24,
        InkWell(
          onTap: () => getImage(),
          child: profileProvider!.profile.data!.profileImage!.contains('null')
              ? CircleAvatar(
                  radius: 56,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/img_default_profile.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 36,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: profileProvider!.userImagePreference,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: baseTextBlackDark,
                        strokeWidth: 1.5,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
        ),
        spaceHeight16,
        Text(
          '${profileProvider!.profile.data!.firstName!} ${profileProvider!.profile.data!.lastName!}',
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            height: 1,
            fontSize: 28,
          ),
        )
      ],
    );
  }

  Widget _formEditProfile() {
    profileProvider = Provider.of<ProfileProvider>(context);
    emailController.text = profileProvider!.profile.data!.email!;
    firstNameController.text = profileProvider!.profile.data!.firstName!;
    lastNameController.text = profileProvider!.profile.data!.lastName!;

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: paddingExtraWide, vertical: paddingWide),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Email'),
          spaceHeight6,
          TextFormFieldWidget(
            controller: emailController,
            inputType: TextInputType.emailAddress,
            maxLines: 1,
            textHint: 'Masukkan email anda',
            iconData: Icons.alternate_email,
            readOnly: isEditProfile ? false : true,
          ),
          spaceHeight16,
          const Text('Nama Depan'),
          spaceHeight6,
          TextFormFieldWidget(
            controller: firstNameController,
            inputType: TextInputType.text,
            maxLines: 1,
            textHint: 'Masukkan email anda',
            iconData: Icons.person_outline,
            readOnly: isEditProfile ? false : true,
          ),
          spaceHeight16,
          const Text('Nama Belakang'),
          spaceHeight6,
          TextFormFieldWidget(
            controller: lastNameController,
            inputType: TextInputType.text,
            maxLines: 1,
            textHint: 'Masukkan email anda',
            iconData: Icons.person_outline,
            readOnly: isEditProfile ? false : true,
          ),
          spaceHeight32,
          isEditProfile ? _editButton() : _defaultButton(),
        ],
      ),
    );
  }

  Widget _defaultButton() {
    return Column(
      children: [
        ButtonOutlinedWidget(
          actionText: 'Edit Profile',
          onTap: () {
            // init Register
            setState(() {
              isEditProfile = true;
            });
          },
        ),
        spaceHeight16,
        ButtonFillWidget(
          actionText: 'Logout',
          onTap: () {
            // init Register
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    contentPadding: EdgeInsets.only(top: 10.0),
                    content:
                        SizedBox(width: 300.0, child: WidgetDialogLogout()),
                  );
                });
          },
        ),
      ],
    );
  }

  Widget _editButton() {
    return Column(
      children: [
        ButtonFillWidget(
          actionText: 'Simpan',
          onTap: () {
            // init Register
            setState(() {
              isEditProfile = false;
              Utility.loadingDialog(context, false, baseTextApp);
              Provider.of<ProfileProvider>(context, listen: false)
                  .updateProfile(firstNameController.text.toString(),
                      lastNameController.text.toString())
                  .then((value) => {
                        Navigator.pop(context),
                        Utility.snackbarAlert(
                            context, 'Update profile berhasil.'),
                      });
            });
          },
        ),
        spaceHeight16,
        ButtonOutlinedWidget(
          actionText: 'Batalkan',
          onTap: () {
            // init Register
            setState(() {
              isEditProfile = false;
            });
          },
        ),
      ],
    );
  }
}
