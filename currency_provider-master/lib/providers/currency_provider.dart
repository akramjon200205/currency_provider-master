import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../models/currency_model.dart';
import '../utills/constants.dart';
import '../utills/hive_util.dart';

class CurrencyProvider extends ChangeNotifier with HiveUtil {
  final TextEditingController editingControllerTop = TextEditingController();
  final TextEditingController editingControllerBottom = TextEditingController();
  final TextEditingController editingController = TextEditingController();

  final FocusNode topFocus = FocusNode();
  final FocusNode bottomFocus = FocusNode();
  final List<CurrencyModel> filterList = [];

  List<CurrencyModel> listCurrency = [];

  late CurrencyModel topCur;
  late CurrencyModel bottomCur;  

  void exchange() {
    var model = topCur.copyWith();
    topCur = bottomCur.copyWith();
    bottomCur = model;
    editingControllerTop.clear();
    editingControllerBottom.clear();

    notifyListeners();
  }

  void update() {
    notifyListeners();
  }

  void initChange() {
    filterList.addAll(listCurrency);
    notifyListeners();
  }

  void callbackFuncBottom(dynamic value) {
    bottomCur = value;
    notifyListeners();
  }

  void callbackFuncTop(dynamic value) {
    topCur = value;
    notifyListeners();
  }

  void editingControllerBottomFunc() async {
    editingControllerTop.addListener(() {
      if (topFocus.hasFocus) {
        if (editingControllerTop.text.isNotEmpty) {
          double sum = double.parse(topCur.rate ?? '0') /
              double.parse(bottomCur.rate ?? '0') *
              double.parse(editingControllerTop.text);
          editingControllerBottom.text = sum.toStringAsFixed(2);
        } else {
          editingControllerBottom.clear();
        }
      }
    });
    notifyListeners();
  }

  void editingControllerTopfunc() async {
    editingControllerBottom.addListener(() {
      if (bottomFocus.hasFocus) {
        if (editingControllerBottom.text.isNotEmpty) {
          double sum = double.parse(bottomCur.rate ?? '0') /
              double.parse(topCur.rate ?? '0') *
              double.parse(editingControllerBottom.text);
          editingControllerTop.text = sum.toStringAsFixed(2);
        } else {
          editingControllerTop.clear();
        }
      }
    });
    notifyListeners();
  }

  Future<bool?> loadData() async {
    if (await loadLocalData()) {
      try {
        var response = await get(
            Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));
        if (response.statusCode == 200) {
          for (final item in jsonDecode(response.body)) {
            var model = CurrencyModel.fromJson(item);
            if (model.ccy == 'USD') {
              topCur = model;
            } else if (model.ccy == 'RUB') {
              bottomCur = model;
            }
            listCurrency.add(model);
            await saveBox<String>(dateBox, topCur.date ?? "", key: dateKey);
            await saveBox<List<CurrencyModel>>(currencyBox, listCurrency,
                key: currencyListKey);
          }
          return true;
        } else {
          log('Unknown Error');
        }
      } on SocketException {
        log("Connection Error");
      } catch (e) {
        (e.toString());
      }
    }
    notifyListeners();
    return null;
  }

  Future<bool> loadLocalData() async {
    try {
      var date = await getBox<String>(dateBox, key: dateKey);
      if (date ==
          DateFormat('dd.MM.yyyy').format(
            DateTime.now().add(
              const Duration(days: -1),
            ),
          )) {
        listCurrency = await getBox(currencyBox, key: currencyListKey) ?? [];
        return false;
      } else {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
    return true;
  }

  void onDispose() {
    editingControllerTop.dispose();
    editingControllerBottom.dispose();
    topFocus.dispose();
    bottomFocus.dispose();
  }
}
