import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/currency_model.dart';
import 'package:flutter_application_1/providers/main_provider.dart';
import 'package:flutter_application_1/utills/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage(this._listCurrency, this.topCur, this.bottomCur,
      {Key? key})
      : super(key: key);
  final List<CurrencyModel> _listCurrency;
  final String topCur;
  final String bottomCur;

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {  
  @override
  void initState() {
    super.initState();
    context.read<CurrencyProvider>().filterList.addAll(widget._listCurrency);
  }

  @override
  void dispose() {
    super.dispose();    
    context.read<CurrencyProvider>().editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xff1f2235),
            title: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                fillColor: const Color(0xff2d334d),
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.white,
                  size: 20,
                ),
                hintText: 'Search',
                hintStyle: kTextStyle(
                    color: Colors.white54,
                    size: 16,
                    fontWeight: FontWeight.w500),
                suffixIcon: IconButton(
                    onPressed: () {
                      provider.editingController.clear();
                      provider.filterList.clear();
                      provider.filterList.addAll(provider.listCurrency);
                    },
                    icon:
                        const Icon(Icons.clear, color: Colors.white, size: 20)),
              ),
              style: kTextStyle(size: 16, fontWeight: FontWeight.w500),
              onChanged: (value) {
                provider.filterList.clear();
                if (value.isNotEmpty) {
                  for (final item in provider.listCurrency) {
                    if (item.ccy!.toLowerCase().contains(value.toLowerCase()) ||
                        item.ccyNmEn!
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                      provider.filterList.add(item);
                    }
                  }
                } else {
                  provider.filterList.addAll(provider.listCurrency);
                }
              },
            ),
          ),
          backgroundColor: const Color(0xff1f2235),
          body: ListView.separated(
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                var model = provider.listCurrency[index];
                bool isChoosen = provider.topCur.ccy == model.ccy ||
                    provider.bottomCur.ccy == model.ccy;

                return ListTile(
                  tileColor: const Color(0xff2d334d),
                  onTap: () {
                    if (isChoosen) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Is has been choosen!!!',
                            style: kTextStyle(fontWeight: FontWeight.w100),
                          ),
                        ),
                      );
                    } else {
                      Navigator.pop(context, model);
                    }
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(27.5),
                    child: SvgPicture.asset(
                      'assets/flags/${model.ccy?.substring(0, 2).toLowerCase()}.svg',
                      height: 45,
                      width: 45,
                    ),
                  ),
                  title: Text(
                    model.ccyNmEn ?? '',
                    style: kTextStyle(size: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    model.ccyNmEn ?? '',
                    style: kTextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    model.rate ?? '',
                    style: kTextStyle(size: 16, fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: isChoosen
                          ? const BorderSide(color: Color(0xff10a4d4), width: 2)
                          : BorderSide.none),
                );
              }),
              separatorBuilder: ((context, index) => const SizedBox(
                    height: 10,
                  )),
              itemCount: provider.filterList.length),
        );
      },
    );
  }
}
