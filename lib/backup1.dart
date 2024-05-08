// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:june/core/src/june_main.dart';
// import 'package:june/instance/june_instance.dart';
// import 'package:june/state_manager/src/simple/controllers.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workmanager/workmanager.dart';
//
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//
//     var state = June.getState(CounterVM());
//     state.count++;
//     state.setState();
//
//     // Your background task logic goes here
//     Timer.periodic(const Duration(seconds: 15), (Timer t) async {
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       List<String> times = prefs.getStringList('savedTimes') ?? [];
//       //setState(() {
//       state.savedTimes = times;
//       state.setState();
//
//
//     });
//
//     return Future.value(true);
//   });
// }
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Workmanager().initialize(callbackDispatcher);
//   Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
//   Workmanager().registerPeriodicTask(
//     'periodicTask',
//     'storeCurrentTime',
//     frequency: Duration(minutes: 15),
//   );
//   runApp(MyApp());
// }
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   //List<String> savedTimes = [];
//
//   var state = June.getState(CounterVM());
//
//
//   @override
//   void initState() {
//     super.initState();
//     getSavedTimes();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Local Data Example'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 9, // 90% of the screen
//             child: ListView.builder(
//               itemCount: state.savedTimes.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: ListTile(
//                     title: Text(state.savedTimes[index]),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Expanded(
//             flex: 1, // 10% of the screen
//             child: ElevatedButton(
//               onPressed: () {
//                 saveToLocalData();
//                 var state = June.getState(CounterVM());
//                 state.count++;
//                 state.setState();
//               },
//               child: Text('Save Current Time to Local Data'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void saveToLocalData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String currentTime = DateTime.now().toString();
//     await prefs.setString('currentTime', currentTime);
//     print('Current time saved to local data: $currentTime');
//     //setState(() {
//     state.savedTimes.add(currentTime);
//     state.setState();
//     //});
//   }
//
//   void getSavedTimes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> times = prefs.getStringList('savedTimes') ?? [];
//     //setState(() {
//     state.savedTimes = times;
//     state.setState();
//     //});
//   }
// }
//
// class CounterVM extends JuneState {
//   int count = 0;
//   List<String> savedTimes = [];
// }
