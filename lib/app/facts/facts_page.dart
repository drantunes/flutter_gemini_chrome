import 'package:flutter/material.dart';
import 'package:flutter_gemini_chrome/app/facts/widgets/card_chooser.dart';
import 'package:flutter_gemini_chrome/app/facts/widgets/card_error.dart';

import '../widgets/background_scaffold.dart';
import '../widgets/theme.dart';
import 'facts_controller.dart';
import 'widgets/facts_carousel.dart';

class FactsPage extends StatefulWidget {
  const FactsPage({super.key});

  @override
  State<FactsPage> createState() => _FactsPageState();
}

class _FactsPageState extends State<FactsPage> {
  final _factsController = FactsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScaffold(
        child: ListenableBuilder(
            listenable: _factsController,
            builder: (context, _) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      "Facts about ${_factsController.factTheme}",
                      style: titleStyle,
                    ),
                  ),
                  switch (_factsController.status) {
                    FactsStatus.empty => CardChooser(factsController: _factsController),
                    FactsStatus.loading => const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 36.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    FactsStatus.ok => FactsCarousel(factsController: _factsController),
                    FactsStatus.error => CardError(factsController: _factsController),
                  }
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _factsController.dispose();
    super.dispose();
  }
}
