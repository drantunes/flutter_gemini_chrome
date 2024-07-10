import 'package:flutter/material.dart';
import 'package:flutter_gemini_chrome/app/widgets/theme.dart';

import 'facts/facts_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const FactsPage(),
    );
  }
}
