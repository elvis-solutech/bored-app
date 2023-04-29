import 'package:flutter/material.dart';
import 'bored_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> _activity = {};

  Future <void> refreshActivity() async {
    final BoredApi boredApi = BoredApi();
    Map<String, dynamic> activity = await boredApi.fetchActivity();
    setState(() {
      _activity = activity;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('THE BORED APP'),
        titleTextStyle: const TextStyle(
          fontFamily: 'Quattrocento-Sans',
          fontSize: 30.0,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        color: const Color.fromRGBO(41, 47, 54, 25),
        // General column
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Center(
              child: Text(
                textAlign: TextAlign.center,
                'Cure your boredom with random activities!',
                style: TextStyle(
                  fontFamily: 'Ovo',
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            BoredActivity(
              activity: _activity,
              onRefresh: refreshActivity,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  shape: const StadiumBorder(),
                  backgroundColor: const Color.fromRGBO(56, 111, 164, 100)),
              onPressed: () {
                setState(() {
                  refreshActivity();
                });
              },
              child: const Text(
                'RANDOMIZE',
                style: TextStyle(
                  fontFamily: 'Ovo',
                  fontSize: 20.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
