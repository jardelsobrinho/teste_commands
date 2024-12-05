import 'package:flutter/material.dart';
import 'package:teste_command/ui/count/count_screen.dart';
import 'package:teste_command/ui/count/count_viewmodel.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final countViewModel = CountViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CountScreen(viewModel: countViewModel),
    );
  }
}
