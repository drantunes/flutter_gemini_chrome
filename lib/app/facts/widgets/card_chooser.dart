import 'package:flutter/material.dart';
import 'package:flutter_gemini_chrome/app/facts/facts_controller.dart';

import '../../widgets/theme.dart';

class CardChooser extends StatelessWidget {
  const CardChooser({
    super.key,
    required this.factsController,
  });

  final FactsController factsController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DropdownMenu(
              width: 200,
              hintText: 'Tema',
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 'Food', label: 'Food'),
                DropdownMenuEntry(value: 'Technology', label: 'Technology'),
                DropdownMenuEntry(value: 'Animals', label: 'Animals'),
                DropdownMenuEntry(value: 'Vehicles', label: 'Vehicles'),
                DropdownMenuEntry(value: 'Sports', label: 'Sports'),
              ],
              onSelected: (val) => factsController.setFactTheme(val ?? '...'),
            ),
            FilledButton(
              onPressed:
                  factsController.factTheme != '...' ? factsController.generate : null,
              child: const Text(
                'Gerar',
                style: buttonStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
