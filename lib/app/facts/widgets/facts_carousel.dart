import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';
import 'package:flutter_gemini_chrome/app/facts/facts_controller.dart';
import 'package:flutter_gemini_chrome/app/facts/widgets/fact_card.dart';

import '../../widgets/theme.dart';

class FactsCarousel extends StatefulWidget {
  final FactsController factsController;

  const FactsCarousel({super.key, required this.factsController});

  @override
  State<FactsCarousel> createState() => _FactsCarouselState();
}

class _FactsCarouselState extends State<FactsCarousel> {
  final _scrollController = CustomCarouselScrollController();
  List<Widget> items = [];

  @override
  void initState() {
    Future.delayed(300.ms, _shuffleDeck);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _buildCarousel(),
    );
  }

  Widget _buildCarousel() {
    List<Widget> items = widget.factsController.facts
        .map(
          (fact) => FactCard(
            child: Text(fact, style: factStyle),
          ),
        )
        .toList();

    items = [
      FactCard(
        child: ElevatedButton(
          onPressed: widget.factsController.reset,
          child: const Text('Gerar novamente'),
        ),
      ),
      ...items
    ];

    // Note: we could wrap the carousel in IgnorePointer to prevent user interaction.
    // but it's kinda fun to play with in the demo, so we'll leave it enabled.

    return CustomCarousel(
      // Enable `sticky` physics so you can only "throw" one card at a time:
      physics: const CustomCarouselScrollPhysics(sticky: true),
      // Creates the stack of 3 cards behind the selected card:
      itemCountBefore: 3,
      // We don't want any cards left on screen after they "scroll off":
      itemCountAfter: 0,
      // Start all the cards in the middle (we'll move them around from there):
      alignment: Alignment.center,
      // The user will use horizontal scroll interactions:
      scrollDirection: Axis.horizontal,
      // Slow down scroll interactions a bit:
      scrollSpeed: 0.5,
      // We don't want to let the user tap to scroll to (ie. select) a card:
      tapToSelect: true,
      // We'll use our own controller so that we can navigate the cards via
      // the "Next Card" / "Shuffle Deck" button:
      controller: _scrollController,
      // Create the effectsBuilder using Animate, so we can leverage pre-built
      // effects like shimmer, tint, and shadows:
      effectsBuilder: CustomCarousel.effectsBuilderFromAnimate(
        // This is quite a complex effects list, but we'll try to break it
        // down into understandable chunks.
        //
        // The specific duration doesn't really matter, but to make it
        // easier to think about, we'll use 200ms. The "middle" at 100ms
        // is when the card is selected. So 0-100ms is "before"
        // the card is selected, and 100-200ms is "after".
        //
        // Effects are applied in the order they are added to the list, so
        // we'll start with the effects that happen "on the card", versus
        // "to the card".
        effects: EffectList()
            // This tint will run from 0-100, so untint as it approaches the
            // front of the stack (ie. approaches the middle). It's what makes
            // the cards in the background a little darker.
            .untint(
              duration: 100.ms,
              color: Colors.white38,
            )
            // Inherits the 100ms duration, and the delay makes this run from
            // 100-200, so it animates as the card leaves the stack
            // (ie. leaves the middle). It creates the gloss effect across
            // the face of the card as it flips.
            .shimmer(
              delay: 100.ms,
              color: Colors.white10,
              angle: 3.1,
            )
            // This inherits the 100-200 timing from the shimmer. It animates
            // the shadow behind the card as it flips.
            .boxShadow(
              begin: const BoxShadow(
                color: Colors.white10,
                blurRadius: 0,
                spreadRadius: -10,
                offset: Offset(0, 0),
              ),
              end: BoxShadow(
                color: Colors.white.withOpacity(0),
                blurRadius: 24,
                offset: const Offset(-48, 0),
              ),
              borderRadius: BorderRadius.circular(24),
            )
            // the following effects happen "to the card" (ex. moving it around)
            // so we'll add them at the end of the list.
            //
            // This rotation resets the delay to 0, thereby running from 0-100.
            // It subtley rotates the cards in the stack as they move to the front.
            .rotate(
              delay: 0.ms,
              curve: Curves.easeIn,
              begin: 0.03,
            )
            // The 2.5d card flip as it leaves the stack (100-200).
            .flipH(
              delay: 100.ms,
              end: -0.15,
              alignment: Alignment.center,
              perspective: 2,
            )
            // Slides the card to the right as it leaves the stack (100-200).
            .slideX(end: 1.5),
      ),
      // This is mostly just used to update the "Next Card" button to say
      // "Shuffle Deck" when the last card is selected.
      // onSelectedItemChanged: (i) => print(i),
      children: items,
    );
  }

  _shuffleDeck() {
    setState(() {
      _scrollController.animateToItem(numberOfFacts + 1, duration: 1000.ms);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
}
