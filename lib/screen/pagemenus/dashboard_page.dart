import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/provider/balance_provider.dart';
import 'package:sims_ppob_irfan_ghozali/provider/home_provider.dart';
import 'package:sims_ppob_irfan_ghozali/utils/util.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/items/list_item_banner.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/items/list_item_service.dart';
import 'package:animation_wrappers/animation_wrappers.dart';

class DashboardPageScreen extends StatefulWidget {
  const DashboardPageScreen({super.key});

  @override
  State<DashboardPageScreen> createState() => _DashboardPageScreenState();
}

class _DashboardPageScreenState extends State<DashboardPageScreen> {
  HomeProvider? homeProvider;
  BalanceProvider? balanceProvider;
  bool isShowBalance = false;

  @override
  void initState() {
    super.initState();
    final balanceProvider =
        Provider.of<BalanceProvider>(context, listen: false);
    balanceProvider.getBalance();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getProfile();
    homeProvider.getAllServices();
    homeProvider.getAllBanners();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FadedScaleAnimation(
        child: Column(
          children: [
            _topWidget(),
            spaceHeight16,
            _balanceWidget(),
            spaceHeight16,
            _serviceWidget(),
            _bannerWidget(),
          ],
        ),
      ),
    );
  }

  Widget _topWidget() {
    homeProvider = Provider.of<HomeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: paddingExtraWide, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceHeight24,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/ic_logo_sims.png',
                      width: 24, height: 24),
                  spaceWidth5,
                  const Text(
                    'SIMS PPOB',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      height: 1,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              homeProvider!.isLoadingProfile
                  ? Container(
                      margin: const EdgeInsets.only(top: 18),
                      width: 16,
                      height: 16,
                      child: const CircularProgressIndicator(
                        color: baseTextBlackDark,
                        strokeWidth: 1.5,
                      ),
                    )
                  : homeProvider!.profile.data!.profileImage!.contains('null')
                      ? Image.asset('assets/images/img_default_profile.png',
                          width: 36, height: 36)
                      : CachedNetworkImage(
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                          imageUrl: homeProvider!.profile.data!.profileImage!,
                          placeholder: (context, url) => const Center(
                              child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(baseTextApp),
                            ),
                          )),
                          errorWidget: (context, url, error) => Image.asset(
                              'assets/images/img_default_profile.png',
                              width: 36,
                              height: 36),
                        ),
            ],
          ),
          spaceHeight16,
          const Text(
            'Selamat datang,',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          homeProvider!.isLoadingProfile
              ? const Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: baseTextBlackDark,
                        strokeWidth: 1.5,
                      ),
                    ),
                    spaceWidth8,
                    Text(
                      'Fetching data...',
                      style: TextStyle(color: baseTextBlackDark),
                    )
                  ],
                )
              : Text(
                  '${homeProvider!.profile.data!.firstName!} ${homeProvider!.profile.data!.lastName!}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    height: 1,
                    fontSize: 28,
                  ),
                )
        ],
      ),
    );
  }

  Widget _balanceWidget() {
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
          balanceProvider!.isLoadingBalance
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: paddingExtraWide),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: backgroundBaseWhite,
                          strokeWidth: 1.5,
                        ),
                      ),
                      spaceWidth8,
                      Text(
                        'Fetching balance...',
                        style: TextStyle(color: baseTextWhite),
                      )
                    ],
                  ),
                )
              : isShowBalance
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

  Widget _serviceWidget() {
    homeProvider = Provider.of<HomeProvider>(context);
    return homeProvider!.isLoadingService
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: paddingExtraWide),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: baseTextBlackDark,
                    strokeWidth: 1.5,
                  ),
                ),
                spaceWidth8,
                Text(
                  'Fetching all service...',
                  style: TextStyle(color: baseTextBlackDark),
                )
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(
                horizontal: paddingExtraWide, vertical: paddingWide),
            child: GridView.builder(
                padding: const EdgeInsets.only(
                    left: 6, right: 6, top: 0, bottom: 16),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.70),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeProvider!.service.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListItemService(
                    simsService: homeProvider!.service.data[index],
                  );
                }),
          );
  }

  Widget _bannerWidget() {
    homeProvider = Provider.of<HomeProvider>(context);
    return homeProvider!.isLoadingBanner
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: paddingExtraWide),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: baseTextBlackDark,
                    strokeWidth: 1.5,
                  ),
                ),
                spaceWidth8,
                Text(
                  'Fetching all promos...',
                  style: TextStyle(color: baseTextBlackDark),
                )
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: paddingExtraWide),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Temukan promo menarik',
                  style: TextStyle(fontSize: 14, color: baseTextBlackDark),
                ),
                spaceHeight8,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 144,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    itemCount: homeProvider!.banners.data.length,
                    itemBuilder: (context, index) {
                      return ListItemBanner(
                        banner: homeProvider!.banners.data[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
