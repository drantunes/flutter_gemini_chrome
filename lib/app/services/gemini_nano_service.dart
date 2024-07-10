import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';

import '../facts/facts_controller.dart';

@JS("ai.createTextSession")
external JSPromise<AITextSession> createTextSession();

extension type AITextSession(JSObject _) implements JSObject {
  @JS()
  external JSPromise<JSString> prompt(JSString input);
}

class GeminiNanoService {
  Future<List<String>> prompt(String theme) async {
    final String input = '''
      Let's create a list of $numberOfFacts facts about $theme, contain short sentence.
      The output should be translate to Portuguese and strickly in the following JSON format: 
      [{"fact": "O primeiro computador pessoal foi inventado em 1942 por John Atanasoff e Clifford Berry."}]
      ''';
    try {
      final session = await createTextSession().toDart;
      final response = await session.prompt(input.toJS).toDart;
      final result = response.toDart.toString();

      final parsedResult =
          result.replaceAll('```json', '').replaceAll('```', '').replaceAll('\n', "");

      final facts = (jsonDecode(parsedResult) as List)
          .map((fact) => fact['fact'].toString())
          .toList();

      return facts;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
