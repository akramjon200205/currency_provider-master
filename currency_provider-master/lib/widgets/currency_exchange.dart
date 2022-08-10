import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/currency_model.dart';
import 'package:flutter_application_1/providers/currency_provider.dart';
import 'package:flutter_application_1/utills/routes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../utills/constants.dart';

class CurrencyExchange extends StatelessWidget {
  CurrencyExchange(this.topCur, this.bottomCur, this.listCurrency,
      this.controller, this.model, this.focusNode, this.callback,
      {Key? key})
      : super(key: key);
  TextEditingController controller;
  CurrencyModel model;
  FocusNode focusNode;
  Function callback;
  List<CurrencyModel> listCurrency;

  CurrencyModel topCur;
  CurrencyModel bottomCur;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: '0.00',
                    hintStyle:
                        kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.currencyPage,
                    arguments: {
                      'list_currency': listCurrency,
                      'top_cur': topCur.ccy,
                      'bottom_cur': bottomCur.ccy
                    }).then((value) => callback(value)),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xff10a4d4)),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SvgPicture.asset(
                          'assets/flags/${model.ccy?.substring(0, 2).toLowerCase()}.svg',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: Text(
                          model.ccy ?? 'UNK',
                          style:
                              kTextStyle(size: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.white54,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Text(
            controller.text.isNotEmpty
                ? (double.parse(controller.text) * 0.05).toStringAsFixed(2)
                : '0.00',
            style:
                kTextStyle(fontWeight: FontWeight.w600, color: Colors.white54),
          )
        ],
      ),
    );
  }
}
