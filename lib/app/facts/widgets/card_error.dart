import 'package:flutter/material.dart';
import 'package:flutter_gemini_chrome/app/facts/facts_controller.dart';

import 'fact_card.dart';

class CardError extends StatelessWidget {
  const CardError({super.key, required this.factsController});

  final FactsController factsController;

  @override
  Widget build(BuildContext context) {
    return FactCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Erro ao gerar os fatos...',
              style: TextStyle(color: Colors.white),
            ),
          ),
          FilledButton.tonal(
            onPressed: factsController.generate,
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}
