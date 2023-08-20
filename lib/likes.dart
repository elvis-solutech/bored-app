import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Tracking'),
        centerTitle: true,
      ),
      body: Consumer<ActivitiesModel>(
        builder: (context, activitiesModel, child) {
          final activityList = activitiesModel.activity;
          return ListView.builder(
            itemCount: activityList.length,
            itemBuilder: (context, index) {
            
            final activity = activityList[index];

            return ListTileGen(
              title: activity['title'],
              subtitle: activity['subtitle'],
            );
          });
        },
      ),
    );
    // bottomNavigationBar: BottomNavigationBar(items: items),
  }
}

class ListTileGen extends StatelessWidget {
  final String title;
  final String subtitle;
  const ListTileGen({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        tileColor: Colors.teal,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}

class ActivitiesModel extends ChangeNotifier {
  List<Map<String, dynamic>> _activity = [];
  List<Map<String, dynamic>> get activity => _activity;
  void setActivity(Map<String, dynamic> newActivity) {
    _activity.add(newActivity);
    notifyListeners();
  }
}
