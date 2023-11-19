import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/model/sims_service.dart';
import 'package:sims_ppob_irfan_ghozali/screen/detail/detail_payment.dart';

class ListItemService extends StatefulWidget {
  final Datum simsService;
  const ListItemService({
    super.key,
    required this.simsService,
  });

  @override
  State<ListItemService> createState() => _ListItemServiceState();
}

class _ListItemServiceState extends State<ListItemService> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 200),
            reverseDuration: const Duration(milliseconds: 200),
            child: DetailPaymentPage(
              simsService: widget.simsService,
            ),
          ),
        );
      },
      child: Column(
        children: [
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
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
          spaceHeight4,
          Text(
            widget.simsService.serviceName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
