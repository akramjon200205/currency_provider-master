import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/currency_model.dart';
import 'package:flutter_application_1/providers/currency_provider.dart';
import 'package:flutter_application_1/utills/constants.dart';
import 'package:flutter_application_1/utills/hive_util.dart';
import 'package:flutter_application_1/widgets/app_bar.dart';
import 'package:flutter_application_1/widgets/currency_exchange.dart';
import 'package:flutter_application_1/widgets/exchange.dart';
import 'package:provider/provider.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({Key? key}) : super(key: key);

  @override
  State<ComparePage> createState() => ComparePageState();
}

class ComparePageState extends State<ComparePage> with HiveUtil {
  late CurrencyProvider currencyProvider;

  @override
  void initState() {
    super.initState();
    currencyProvider = context.read<CurrencyProvider>();
    currencyProvider.editingControllerTopfunc();
    currencyProvider.editingControllerBottomFunc();
  }

  @override
  void dispose() {
    context.read<CurrencyProvider>().onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xff1f2235),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  const CustomAppBar(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      CurrencyExchange(
                                        provider.topCur,
                                        provider.bottomCur,
                                        provider.listCurrency,
                                        provider.editingControllerTop,
                                        provider.topCur,
                                        provider.topFocus,
                                        ((value) {
                                          if (value is CurrencyModel) {
                                            provider.callbackFuncTop(value);
                                          }
                                        }),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      CurrencyExchange(
                                        provider.topCur,
                                        provider.bottomCur,
                                        provider.listCurrency,
                                        provider.editingControllerBottom,
                                        provider.bottomCur,
                                        provider.bottomFocus,
                                        ((value) {
                                          if (value is CurrencyModel) {
                                            provider.callbackFuncBottom(value);
                                          }
                                        }),
                                      ),
                                    ],
                                  ),
                                  Exchange(),
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
}
