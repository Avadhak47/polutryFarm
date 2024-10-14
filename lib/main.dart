import 'package:farm_app/home/home_2.dart';
import 'package:farm_app/home/render.dart';
import 'package:farm_app/home/home_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'render.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bird App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: RenderPage(),
    );
  }
}