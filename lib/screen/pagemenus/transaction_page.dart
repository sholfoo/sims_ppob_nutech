import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/provider/balance_provider.dart';
import 'package:sims_ppob_irfan_ghozali/provider/history_provider.dart';
import 'package:sims_ppob_irfan_ghozali/utils/util.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/action_bar_widget.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/items/list_item_history.dart';
import 'package:animation_wrappers/animation_wrappers.dart';

class TransactionPageScreen extends StatefulWidget {
  final VoidCallback onBackPressed;
  const TransactionPageScreen({super.key, required this.onBackPressed});

  @override
  State<TransactionPageScreen> createState() => _TransactionPageScreenState();
}

class _TransactionPageScreenState extends State<TransactionPageScreen> {
  HistoryProvider? provider;
  BalanceProvider? balanceProvider;
  bool isShowBalance = false;

  @override
  void initState() {
    final provider = Provider.of<HistoryProvider>(context, listen: false);
    provider.getTransactionHistory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FadedScaleAnimation(
        child: Column(
          children: [
            ActionBarWidget(
              actionBarTitle: 'Transaksi',
              onActionBackToDashboard: widget.onBackPressed,
            ),
            _balanceView(),
            spaceHeight32,
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingExtraWide),
                  child: Text(
                    'Transaksi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
            spaceHeight8,
            _transactionHistory(),
            spaceHeight16,
          ],
        ),
      ),
    );
  }

  Widget _transactionHistory() {
    provider = Provider.of<HistoryProvider>(context);
    return provider!.isLoading
        ? const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpinKitChasingDots(
                color: backgroundBaseApp,
                size: 60.0,
              ),
              spaceWidth8,
              Text('Fetching Transaction History...')
            ],
          )
        : provider!.recordHistory.isEmpty
            ? const Text('Tidak ada riwayat transaksi.')
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingExtraWide),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      clipBehavior: Clip.none,
                      itemCount: provider!.recordHistory.length,
                      itemBuilder: (context, index) {
                        return ListItemHistory(
                          history: provider!.recordHistory[index],
                        );
                      },
                    ),
                  ),
                  provider!.isLoadMore
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: paddingExtraWide),
                          child: const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: baseTextBlackDark,
                              strokeWidth: 1.5,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            final offset = provider!.lastOffset;
                            provider!.loadMoreTransactionHistory(offset, 5);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: paddingExtraWide,
                                vertical: paddingNormal),
                            child: Text(
                              'Show More',
                              style:
                                  TextStyle(color: baseTextApp, fontSize: 14),
                            ),
                          ),
                        ),
                ],
              );
  }

  Widget _balanceView() {
    balanceProvider = Provider.of<BalanceProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: paddingExtraWide),
      padding: const EdgeInsets.symmetric(
          horizontal: paddingExtraWide, vertical: paddingWide),
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
          spaceHeight16,
          isShowBalance
              ? Text(
                  rupiah(balanceProvider!.balance.data.balance),
                  style: const TextStyle(
                      fontSize: 40,
                      color: baseTextWhite,
                      fontWeight: FontWeight.w900),
                )
              : const Text(
                  'Rp ********',
                  style: TextStyle(
                      fontSize: 40,
                      color: baseTextWhite,
                      fontWeight: FontWeight.w900),
                ),
          spaceHeight16,
          InkWell(
            onTap: () {
              setState(() {
                isShowBalance = !isShowBalance;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  isShowBalance ? 'Sembunyikan Saldo' : 'Lihat Saldo',
                  style: const TextStyle(
                    fontSize: 14,
                    color: baseTextWhite,
                    decoration: TextDecoration.underline,
                  ),
                ),
                spaceWidth4,
                Icon(
                  isShowBalance ? Icons.visibility : Icons.visibility_off,
                  size: 12,
                  color: baseTextWhite,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
