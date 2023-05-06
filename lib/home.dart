import 'package:flutter/material.dart';
import 'bored_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> _activity = {};
  String selectedType = '';

  Future<void> refreshActivity() async {
    final BoredApi boredApi = BoredApi();
    Map<String, dynamic> activity = await boredApi.fetchActivity(selectedType);
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
            Visibility(
              visible: false,
              child: DropdownButton(
                  value: selectedType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedType = newValue!;
                      refreshActivity();
                    });
                  },
                  items: <String>[
                    '',
                    'education',
                    'recreational',
                    'social',
                    'diy',
                    'charity',
                    'cooking',
                    'relaxation',
                    'music',
                    'busywork'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
            ),
            BoredActivity(
              activity: _activity,
              onRefresh: refreshActivity,
              dropdownButton: DropdownButton(
                underline: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.white, style: BorderStyle.solid)),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(30)),

                icon: const Icon(
                  Icons.arrow_drop_down_circle_rounded,
                  color: Colors.white,
                ),
                hint: const Text(
                  'Random',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.amber,
                  ),
                ),
                dropdownColor: const Color.fromRGBO(41, 47, 54, 54),
                style: const TextStyle(
                  fontFamily: 'Quattrocento-Sans',
                  fontSize: 20.0,
                  color: Colors.white,
                ),
                value: selectedType,
                onChanged: (newValue) {
                  setState(() {
                    selectedType = newValue!;
                    refreshActivity();
                  });
                },
                items: <String>[
                  '',
                  'education',
                  'recreational',
                  'social',
                  'diy',
                  'charity',
                  'cooking',
                  'relaxation',
                  'music',
                  'busywork'
                ].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
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
