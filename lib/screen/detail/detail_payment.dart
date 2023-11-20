import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/model/sims_service.dart';
import 'package:sims_ppob_irfan_ghozali/provider/balance_provider.dart';
import 'package:sims_ppob_irfan_ghozali/provider/trx_provider.dart';
import 'package:sims_ppob_irfan_ghozali/utils/util.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/action_bar_widget.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/button_fill_widget.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/textformfield_widget.dart';
import 'package:animation_wrappers/animation_wrappers.dart';

class DetailPaymentPage extends StatefulWidget {
  final Datum simsService;
  const DetailPaymentPage({super.key, required this.simsService});

  @override
  State<DetailPaymentPage> createState() => _DetailPaymentPageState();
}

class _DetailPaymentPageState extends State<DetailPaymentPage> {
  TextEditingController nominalController = TextEditingController();

  TrxProvider? trxProvider;

  int? valueNominal;

  @override
  void initState() {
    valueNominal = widget.simsService.serviceTariff;
    nominalController.text = rupiah(valueNominal.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBaseWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ActionBarWidget(
              actionBarTitle: 'Transaksi',
              onActionBackToDashboard: () => Navigator.pop(context),
            ),
            FadedScaleAnimation(child: _balanceView()),
            spaceHeight32,
            FadedScaleAnimation(
              child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingExtraWide),
                    child: Text(
                      'Pembayaran',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            spaceHeight16,
            FadedScaleAnimation(child: _detailPayment()),
            spaceHeight16,
          ],
        ),
      ),
    );
  }

  Widget _balanceView() {
    final balanceProvider = Provider.of<BalanceProvider>(context);
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
            rupiah(balanceProvider.balance.data.balance),
            style: const TextStyle(
                fontSize: 40,
                color: baseTextWhite,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _detailPayment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingExtraWide),
      child: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                // ignore: unnecessary_null_comparison
                imageUrl: (widget.simsService.serviceIcon == null)
                    ? "https://i2.wp.com/www.kinerja.org/wp-content/uploads/2019/07/no-image-2.jpg?fit=%2C&ssl=1"
                    : widget.simsService.serviceIcon,
                placeholder: (context, url) => const Center(
                    child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(baseTextApp),
                  ),
                )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              spaceWidth8,
              Text(
                widget.simsService.serviceName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          spaceHeight16,
          TextFormFieldWidget(
            readOnly: true,
            controller: nominalController,
            inputType: TextInputType.number,
            maxLines: 1,
            textHint: 'Masukkan nominal topup',
            iconData: Icons.pin_outlined,
          ),
          spaceHeight16,
          ButtonFillWidget(
            actionText: 'Bayar',
            onTap: () {
              Utility.loadingDialog(context, false, baseTextApp);
              Provider.of<TrxProvider>(context, listen: false)
                  .attempTrxPayment(widget.simsService.serviceCode)
                  .then((value) => {
                        Navigator.pop(context),
                        Utility.snackbarAlert(
                            context, 'Transaksi Pembayaran Berhasil.'),
                        Provider.of<BalanceProvider>(context, listen: false)
                            .getBalance(),
                      });
            },
          ),
        ],
      ),
    );
  }
}
