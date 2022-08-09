import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_n_morty_fan_app/Screens/Pager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Pager(),
    );
  }
}

///TODOS
// Create 1st Page with the main list showing the tiles
  // make it paginated
// Make Pop Up / 2nd page with Character/Episode Info
// Add loading indicators while awaiting Futures to complete