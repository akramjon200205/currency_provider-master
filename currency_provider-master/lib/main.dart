import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/currency_model.dart';
import 'package:flutter_application_1/providers/main_provider.dart';
import 'package:flutter_application_1/utills/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  await Hive.initFlutter();
  Hive.registerAdapter<CurrencyModel>(CurrencyModelAdapter());
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CurrencyProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => Routes.generateRoute(settings),
      ),
    );
  }
}
