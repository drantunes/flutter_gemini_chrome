import 'package:flutter/material.dart';
import 'package:flutter_gemini_chrome/app/services/gemini_nano_service.dart';

enum FactsStatus { empty, loading, ok, error }

const int numberOfFacts = 6;

class FactsController extends ChangeNotifier {
  FactsStatus status = FactsStatus.empty;
  String factTheme = "...";
  List<String> facts = [];

  void setFactTheme(String val) {
    factTheme = val;
    notifyListeners();
  }

  void reset() {
    status = FactsStatus.empty;
    notifyListeners();
  }

  Future<void> generate() async {
    status = FactsStatus.loading;
    notifyListeners();

    final geminiService = GeminiNanoService();
    facts = await geminiService.prompt(factTheme);

    (facts.isEmpty) ? status = FactsStatus.error : status = FactsStatus.ok;

    notifyListeners();
  }
}
