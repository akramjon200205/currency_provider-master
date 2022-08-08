import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/currency_model.dart';
import 'package:flutter_application_1/providers/main_provider.dart';
import 'package:flutter_application_1/utills/constants.dart';
import 'package:flutter_application_1/utills/hive_util.dart';
import 'package:flutter_application_1/utills/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({Key? key}) : super(key: key);

  @override
  State<ComparePage> createState() => ComparePageState();
}

class ComparePageState extends State<ComparePage> with HiveUtil {
  @override
  void initState() {
    super.initState();
    context.read<MainProvider>().editingControllerTopfunc();
    context.read<MainProvider>().editingControllerBottomFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Scaffold(
      backgroundColor: const Color(0xff1f2235),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Hello Akramjon,\n',
                      style: kTextStyle(size: 16),
                      children: [
                        TextSpan(
                          text: 'Wellcome Back',
                          style:
                              kTextStyle(size: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white12),
                      ),
                      child: const Icon(
                        Icons.more_vert,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              FutureBuilder(
                future: provider.listCurrency.isEmpty
                    ? provider.loadData()
                    : null,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.symmetric(vertical: 25),
                      decoration: BoxDecoration(
                        color: const Color(0xff2d334d),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Exchange',
                                style: kTextStyle(
                                    size: 16, fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                onPressed: () {},
                                iconSize: 20,
                                icon: const Icon(
                                  Icons.settings,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                children: [
                                  _itemExch(
                                   provider
                                        .editingControllerTop,
                                    provider.topCur,
                                    provider.topFocus,
                                    ((value) {
                                      if (value is CurrencyModel) {
                                       provider
                                            .callbackFuncTop(value);
                                      }
                                    }),
                                    context.watch<MainProvider>(),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  _itemExch(
                                    provider
                                        .editingControllerBottom,
                                   provider.bottomCur,
                                    provider.bottomFocus,
                                    ((value) {
                                      if (value is CurrencyModel) {
                                        provider
                                            .callbackFuncBottom(value);
                                      }
                                    }),
                                    provider,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  provider.exchange();
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2d334d),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white12),
                                  ),
                                  child: const Icon(
                                    Icons.currency_exchange,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'Error',
                          style: kTextStyle(size: 18),
                        ),
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
      },
    );
    
  }

  Widget _itemExch(
    TextEditingController controller,
    CurrencyModel? model,
    FocusNode focusNode,
    Function callback,
    MainProvider provider,
  ) {
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
                      'list_currency': provider.listCurrency,
                      'top_cur': provider.topCur?.ccy,
                      'bottom_cur': provider.bottomCur?.ccy
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
                          'assets/flags/${model?.ccy?.substring(0, 2).toLowerCase()}.svg',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: Text(
                          model?.ccy ?? 'UNK',
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
