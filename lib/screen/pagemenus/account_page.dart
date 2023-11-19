import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/provider/home_provider.dart';
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
  HomeProvider? homeProvider;

  bool isEditProfile = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FadedScaleAnimation(
        child: Column(
          children: [
            ActionBarWidget(
              actionBarTitle: 'Akun',
              onActionBackToDashboard: widget.onBackPressed,
            ),
            _detailView(),
            spaceHeight24,
            _formEditProfile(),
          ],
        ),
      ),
    );
  }

  Widget _detailView() {
    homeProvider = Provider.of<HomeProvider>(context);
    return Column(
      children: [
        spaceHeight24,
        homeProvider!.profile.data!.profileImage!.contains('null')
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
                    imageUrl: homeProvider!.userImagePreference,
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
        spaceHeight16,
        Text(
          '${homeProvider!.profile.data!.firstName!} ${homeProvider!.profile.data!.lastName!}',
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
    homeProvider = Provider.of<HomeProvider>(context);
    emailController.text = homeProvider!.profile.data!.email!;
    firstNameController.text = homeProvider!.profile.data!.firstName!;
    lastNameController.text = homeProvider!.profile.data!.lastName!;

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
