import 'package:flutter/widgets.dart';

abstract class Snap {
  factory Snap(
    double extent, {
    double? distance = 10,
    double? trailingDistance,
    double? leadingDistance,
  }) =>
      _SnapPoint(
        extent,
        toleranceDistance: distance,
        trailingToleranceDistance: trailingDistance,
        leadingToleranceDistance: leadingDistance,
      );

  factory Snap.avoidZone(
    double minExtent,
    double maxExtent, {
    double? delimiter,
  }) = _PreventSnapArea;

  bool shouldApplyFor(ScrollMetrics position, double proposedEnd);

  double targetPixelsFor(
    ScrollMetrics position,
    double proposedEnd,
    Tolerance tolerance,
    double velocity,
  );
}

class _SnapPoint implements Snap {
  final double extent;
  final double trailingExtent;
  final double leadingExtent;

  _SnapPoint(
    this.extent, {
    double? toleranceDistance,
    double? trailingToleranceDistance,
    double? leadingToleranceDistance,
  })  : this.leadingExtent =
            extent - (leadingToleranceDistance ?? toleranceDistance ?? 0),
        this.trailingExtent =
            extent + (trailingToleranceDistance ?? toleranceDistance ?? 0);

  bool shouldApplyFor(ScrollMetrics position, double proposedEnd) {
    return proposedEnd > leadingExtent && proposedEnd < trailingExtent;
  }

  double targetPixelsFor(
    ScrollMetrics position,
    double proposedEnd,
    Tolerance tolerance,
    double velocity,
  ) {
    return extent;
  }
}

class _PreventSnapArea implements Snap {
  final double minExtent;
  final double maxExtent;
  final double delimiter;

  _PreventSnapArea(this.minExtent, this.maxExtent, {double? delimiter})
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
    if (delimiter < proposedEnd) {
      return maxExtent;
    } else {
      return minExtent;
    }
  }
}
