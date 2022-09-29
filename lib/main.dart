import 'package:flutter/material.dart';
import 'package:moneybag/screen/home_screen.dart';
import 'package:provider/provider.dart';

import 'model/transaction_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TransactionProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.black,
          primary: Colors.black,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
