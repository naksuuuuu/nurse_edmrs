import 'package:bu_edmrs/common/widgets/curved_edges.dart';
// import 'package:e_commerce/common/widgets/curved_edges.dart';
import 'package:flutter/material.dart';

class CustomCurveWidget extends StatelessWidget {
  const CustomCurveWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CustomCurveEdges(), child: child);
  }
}