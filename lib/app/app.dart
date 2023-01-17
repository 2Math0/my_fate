import 'package:flutter/material.dart';
import 'package:my_fate/presentation/view/nav_bar.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fate',
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(context),
      home: const NavBarScreen(),
    );
  }
}
