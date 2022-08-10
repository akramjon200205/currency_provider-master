import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/main_provider.dart';
import 'package:provider/provider.dart';

class Exchange extends StatelessWidget {
  Exchange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CurrencyProvider>().exchange();
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
    );
  }
}
