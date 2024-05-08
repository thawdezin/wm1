import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  final _homePageKey = GlobalKey<_HomePageState>();
  Workmanager().executeTask((task, inputData) {
    final savedTimes = _homePageKey.currentState?.savedTimes;
    // Now you can access savedTimes here
    Timer.periodic(const Duration(seconds: 15), (Timer t) async {
      saveToLocalData();
    });

    saveToLocalData();
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> savedTimes = [];

  @override
  void initState() {
    super.initState();
    getSavedTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Data Example'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9, // 90% of the screen
            child: ListView.builder(
              itemCount: savedTimes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(savedTimes[index]),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1, // 10% of the screen
            child: ElevatedButton(
              onPressed: () {
                saveToLocalData();
              },
              child: Text('Save Current Time to Local Data'),
            ),
          ),
        ],
      ),
    );
  }

  void saveToLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentTime = DateTime.now().toString();
    await prefs.setString('currentTime', currentTime);
    print('Current time saved to local data: $currentTime');
    setState(() {
      savedTimes.add(currentTime);
    });
  }

  void getSavedTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> times = prefs.getStringList('savedTimes') ?? [];
    setState(() {
      savedTimes = times;
    });
  }
}


void saveToLocalData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentTime = DateTime.now().toString();
  await prefs.setString('currentTime', currentTime);
  print('Current time saved to local data: $currentTime');

  final _homePageKey = GlobalKey<_HomePageState>();
  final savedTimes = _homePageKey.currentState?.savedTimes;
  savedTimes?.add(currentTime);

}