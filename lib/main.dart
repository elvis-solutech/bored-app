import 'package:bored_app/bored_api.dart';
import 'package:bored_app/home.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: BoredApi().fetchActivity(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: Text(
                  'Loading...',
                  style: TextStyle(
                    fontFamily: 'Quattrocento-Sans',
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            return const Home();
          }
        },
      ),
    );
  }
}
