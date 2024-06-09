import 'package:flutter/material.dart';
import 'dashboard.dart';

class WebmotorsApp extends StatelessWidget {
  const WebmotorsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
