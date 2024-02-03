import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'screens/Sepeda/Sepeda.dart';
import 'screens/Sparepart/Sparepart.dart';
import 'screens/Perlengkapan/Perlengkapan.dart';

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserHomePage(),
      routes: {
        '/screens/Sepeda': (context) => SepedaPage(),
        '/screens/Sparepart': (context) => SparepartPage(),
        '/screens/Perlengkapan': (context) => PerlengkapanPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => UnknownRoutePage(), // Replace with your fallback screen
        );
      },
    );
  }
}

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xtreme Bike App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SquareButton('Sepeda', '/screens/Sepeda'),
            SquareButton('Sparepart', '/screens/Sparepart'),
            SquareButton('Perlengkapan', '/screens/Perlengkapan'),
          ],
        ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String title;
  final String route;

  SquareButton(this.title, this.route);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(title),
      ),
    );
  }
}

// Replace this with your actual fallback screen/widget
class UnknownRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unknown Route'),
      ),
      body: Center(
        child: Text('Oops! This route is not defined.'),
      ),
    );
  }
}
