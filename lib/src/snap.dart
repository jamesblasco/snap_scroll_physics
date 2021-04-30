
import 'package:flutter/widgets.dart';

abstract class Snap {
 
  bool shouldApplyFor(ScrollMetrics position, double proposedEnd);

  double targetPixelsFor(
    ScrollMetrics position,
    double proposedEnd,
    Tolerance tolerance,
    double velocity,
  );
}

class PreventSnapArea extends Snap {
  final double minExtent;
  final double maxExtent;
  final double delimiter;

  PreventSnapArea(this.minExtent, this.maxExtent, [double? delimiter])
      : assert(
            delimiter == null ||
                (delimiter >= minExtent) && (delimiter <= maxExtent),
            'The delimiter value should be between the minExtent and maxExtent'),
        this.delimiter = delimiter ?? (minExtent + (maxExtent - minExtent) / 2);

  bool shouldApplyFor(ScrollMetrics position, double proposedEnd) {
    return proposedEnd > minExtent && proposedEnd < maxExtent;
  }

  double targetPixelsFor(
    ScrollMetrics position,
    double proposedEnd,
    Tolerance tolerance,
    double velocity,
  ) {
    /*  if (velocity > tolerance.velocity) {
      return maxExtent;
    } else if (velocity < -tolerance.velocity) {
      return minExtent;
    } else  */
    if (delimiter > proposedEnd) {
      return maxExtent;
    } else {
      return minExtent;
    }
  }
}