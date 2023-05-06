// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:bored_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

const List<String> typeList = [
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
];

class BoredApi {
  Future<Map<String, dynamic>> fetchActivity(String type) async {
    const baseUrl = 'https://www.boredapi.com/api/activity/';

    final String url;
 
      url = '$baseUrl?type=$type';
    
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load activity');
    }
  }
}

class BoredActivity extends StatefulWidget {
  const BoredActivity(
      {super.key,
      required this.activity,
      required this.onRefresh,
      required this.dropdownButton});
  final Map<String, dynamic> activity;
  final VoidCallback onRefresh;
  final DropdownButton dropdownButton;

  @override
  State<BoredActivity> createState() => _BoredActivityState();
}

class _BoredActivityState extends State<BoredActivity> {
  late String selectedType = '';
  late BoredApi boredApi = BoredApi();

  @override
  void initState() {
    super.initState();
    boredApi = BoredApi();
    fetchActivity(selectedType);
  }

  void dropdownCallback(String? value) {
    setState(() {
      selectedType = value ?? typeList[0];
    });
    fetchActivity(selectedType);
  }

  // Map<String, dynamic> _activity = {};

  Future fetchActivity(String selectedType) async {
    try {
      Map<String, dynamic> activity =
          await boredApi.fetchActivity(selectedType);
      widget.onRefresh();
      setState(() {
        widget.activity.clear();
        widget.activity.addAll(activity);
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 440,
      width: 365,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color.fromRGBO(89, 165, 216, 100),
      ),
      child: FutureBuilder<Map<String, dynamic>>(
        future: boredApi.fetchActivity(selectedType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error loading activity',
                style: TextStyle(
                  fontFamily: 'Quattrocento-Sans',
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            );
          } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  kTextWidget(
                    text: 'Type'.toUpperCase(),
                    decoration: TextDecoration.underline,
                  ),
                  widget.dropdownButton,
                  kTextWidget(
                    text: widget.activity['type'].toString().titleCase,
                    decoration: TextDecoration.none,
                  ),
                  kTextWidget(
                    text: 'Activity'.toUpperCase(),
                    decoration: TextDecoration.underline,
                  ),
                  kTextWidget(
                    text: widget.activity['activity'],
                    decoration: TextDecoration.none,
                  ),
                  kTextWidget(
                    text: 'Participants'.toUpperCase(),
                    decoration: TextDecoration.underline,
                  ),
                  kTextWidget(
                    text: widget.activity['participants'].toString(),
                    decoration: TextDecoration.none,
                  ),
                ],
              );
            
          }
        },
      ),
    );
  }
}
