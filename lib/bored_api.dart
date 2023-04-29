import 'dart:convert';
import 'package:bored_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class BoredApi {
  final String url = 'https://www.boredapi.com/api/activity?';

  Future<Map<String, dynamic>> fetchActivity() async {
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
      {super.key, required this.activity, required this.onRefresh});
  final Map<String, dynamic> activity;
  final VoidCallback onRefresh;

  @override
  State<BoredActivity> createState() => _BoredActivityState();
}

class _BoredActivityState extends State<BoredActivity> {
  late BoredApi boredApi = BoredApi();
  // Map<String, dynamic> _activity = {};

  void fetchActivity() async {
    Map<String, dynamic> activity = await boredApi.fetchActivity();
    widget.onRefresh();
    setState(() {
      widget.activity.clear();
      widget.activity.addAll(activity);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchActivity();
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
        future: boredApi.fetchActivity(),
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
            Map<String, dynamic> activity = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                kTextWidget(
                  text: 'Type'.toUpperCase(),
                  decoration: TextDecoration.underline,
                ),
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
