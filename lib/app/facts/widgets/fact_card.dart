import 'package:flutter/material.dart';

class FactCard extends StatelessWidget {
  const FactCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade900,
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
