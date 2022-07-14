import 'package:flutter/material.dart';
import 'package:imageeditor/provider/saveImagesProvider.dart';
import 'package:imageeditor/provider/textprovider.dart';
import 'package:provider/provider.dart';

import 'provider/filterprovider.dart';
import 'screens/home.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => TextProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => FilterProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SaveImages(),
          ),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      title: 'Material App',
      home: const HomeScreen(),
    );
  }
}
