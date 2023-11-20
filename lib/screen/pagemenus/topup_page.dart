import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/provider/balance_provider.dart';
import 'package:sims_ppob_irfan_ghozali/utils/util.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/action_bar_widget.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/button_fill_widget.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/items/list_item_topup.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/textformfield_widget.dart';
import 'package:animation_wrappers/animation_wrappers.dart';

class TopupPageScreen extends StatefulWidget {
  final VoidCallback onBackPressed;
  const TopupPageScreen({super.key, required this.onBackPressed});

  @override
  State<TopupPageScreen> createState() => _TopupPageScreenState();
}

class _TopupPageScreenState extends State<TopupPageScreen> {
  TextEditingController nominalController = TextEditingController();
  int minValue = 10000;
  int maxValue = 1000000;
  List<int> nominal = [10000, 20000, 50000, 100000, 250000, 500000];

  int? selectedNominal = 0;
  BalanceProvider? balanceProvider;

  @override
  void initState() {
    nominalController.addListener(() {
      String nominalStr = nominalController.text.toString();
      if (nominalStr.length > 1) {
        setState(() {
          selectedNominal = int.parse(nominalController.text.toString());
        });
      } else {
        setState(() {
          selectedNominal = 0;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ActionBarWidget(
            actionBarTitle: 'Top Up',
            onActionBackToDashboard: widget.onBackPressed,
          ),
          FadedScaleAnimation(child: _balanceView()),
          spaceHeight32,
          FadedScaleAnimation(
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingExtraWide),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Silahkan Masukkan',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Nominal Top Up',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        height: 1,
                        fontSize: 26,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          spaceHeight24,
          FadedScaleAnimation(child: _formTopupWidget()),
        ],
      ),
    );
  }

  Widget _formTopupWidget() {
    balanceProvider = Provider.of<BalanceProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingExtraWide),
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: nominalController,
            inputType: TextInputType.number,
            maxLines: 1,
            textHint: 'Masukkan nominal topup',
            iconData: Icons.pin_outlined,
          ),
          spaceHeight16,
          GridView.builder(
              padding:
                  const EdgeInsets.only(left: 2, right: 2, top: 0, bottom: 2),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
                childAspectRatio: 2.5,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: nominal.length,
              itemBuilder: (BuildContext context, int index) {
                return ListItemTopup(
                  topupValue: nominal[index],
                  onSelectedNominal: (value) {
                    setState(() {
                      selectedNominal = value;
                      nominalController.text = selectedNominal.toString();
                    });
                  },
                );
              }),
          spaceHeight24,
          ButtonFillWidget(
            actionText: 'Top Up',
            buttonColor:
                selectedNominal == 0 ? backgroundBaseDark : backgroundBaseApp,
            onTap: () {
              if (selectedNominal! < minValue) {
                Utility.snackbarAlert(context,
                    'Minimal nominal yang diterima untuk proses top up adalah Rp 10.000');
                return;
              }
              if (selectedNominal! > maxValue) {
                Utility.snackbarAlert(context,
                    'Maksimum nominal yang diterima untuk proses top up adalah Rp 1.000.000');
                return;
              }

              Utility.loadingDialog(context, false, baseTextApp);
              Provider.of<BalanceProvider>(context, listen: false)
                  .attempTopUpBalance(selectedNominal!)
                  .then((value) => {
                        Navigator.pop(context),
                        Utility.snackbarAlert(context, 'Topup Berhasil'),
                      });
            },
          ),
        ],
      ),
    );
  }

  Widget _balanceView() {
    balanceProvider = Provider.of<BalanceProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: paddingExtraWide),
      padding: const EdgeInsets.symmetric(
          horizontal: paddingExtraWide, vertical: paddingExtraWide),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/bg_saldo.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(paddingWide),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saldo Anda',
            style: TextStyle(fontSize: 14, color: baseTextWhite),
          ),
          Text(
            rupiah(balanceProvider!.balance.data.balance),
            style: const TextStyle(
                fontSize: 40,
                color: baseTextWhite,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
