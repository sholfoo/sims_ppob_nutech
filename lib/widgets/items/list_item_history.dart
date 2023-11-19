import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/model/history.dart';
import 'package:sims_ppob_irfan_ghozali/utils/formatter.dart';
import 'package:sims_ppob_irfan_ghozali/utils/util.dart';

class ListItemHistory extends StatefulWidget {
  final Record? history;
  const ListItemHistory({super.key, this.history});

  @override
  State<ListItemHistory> createState() => _ListItemHistoryState();
}

class _ListItemHistoryState extends State<ListItemHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
          color: backgroundBaseDark,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.history!.transactionType == 'TOPUP'
                    ? '+ ${rupiah(widget.history!.totalAmount)}'
                    : '- ${rupiah(widget.history!.totalAmount)}',
                style: TextStyle(
                    color: widget.history!.transactionType == 'TOPUP'
                        ? Colors.green
                        : baseTextApp,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.history!.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: baseTextBlackDark,
                    fontFamily: fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Text(
            '${Formatter().formatDate(widget.history!.createdOn)} WIB',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: backgroundBaseDark,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
