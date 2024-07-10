import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class BackgroundScaffold extends StatelessWidget {
  const BackgroundScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedMeshGradient(
        colors: [
          Colors.cyan,
          Colors.limeAccent.shade200,
          Colors.orangeAccent,
          Colors.greenAccent,
        ],
        options: AnimatedMeshGradientOptions(
          frequency: 5,
          amplitude: 15,
          speed: 2,
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 400,
                  maxWidth: 400,
                  minHeight: 500,
                  maxHeight: 500,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
