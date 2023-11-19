import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/model/sims_banner.dart';

class ListItemBanner extends StatefulWidget {
  final Datum banner;
  const ListItemBanner({super.key, required this.banner});

  @override
  State<ListItemBanner> createState() => _ListItemBannerState();
}

class _ListItemBannerState extends State<ListItemBanner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: SizedBox(
        width: 340,
        // ignore: unnecessary_null_comparison
        child: widget.banner.bannerImage == null
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: backgroundBaseDark,
                    width: 1.5,
                  ),
                ),
                child: const Placeholder())
            : ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                  imageUrl: widget.banner.bannerImage,
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
              ),
      ),
    );
  }
}
