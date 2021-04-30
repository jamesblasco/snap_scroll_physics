library snap_scroll_physics;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
export 'src/snap.dart';
import 'package:snap_scroll_physics/src/snap.dart';

const double _kNavBarLargeTitleHeightExtension = 52.0;

mixin _SnapScrollPhysics on ScrollPhysics {
  BaseSnapScrollPhysics applyTo(ScrollPhysics? ancestor);
}

abstract class SnapScrollPhysics extends ScrollPhysics with _SnapScrollPhysics {
  factory SnapScrollPhysics({
    ScrollPhysics? parent,
    List<Snap> snaps,
  }) = RawSnapScrollPhysics;

  factory SnapScrollPhysics.builder(
    SnapBuilder builder, {
    ScrollPhysics? parent,
  }) = BuilderSnapScrollPhysics;

  static final cupertinoAppBar = SnapScrollPhysics._forCupertinoAppBar();

  factory SnapScrollPhysics._forCupertinoAppBar() =
      CupertinoAppBarSnapScrollPhysics;

  factory SnapScrollPhysics.preventStopBetween(
    double minExtent,
    double maxExtent, {
    double? delimiter,
    ScrollPhysics? parent,
  }) {
    return SnapScrollPhysics(parent: parent, snaps: [
      Snap.avoidZone(minExtent, maxExtent, delimiter: delimiter),
    ]);
  }
}

class RawSnapScrollPhysics extends BaseSnapScrollPhysics {
  RawSnapScrollPhysics({
    ScrollPhysics? parent,
    this.snaps = const [],
  }) : super(parent: parent);

  @override
  final List<Snap> snaps;

  @override
  RawSnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return RawSnapScrollPhysics(
      parent: buildParent(ancestor),
      snaps: snaps,
    );
  }
}

class CupertinoAppBarSnapScrollPhysics extends BaseSnapScrollPhysics {
  CupertinoAppBarSnapScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);
  @override
  final List<Snap> snaps = [
    Snap.avoidZone(0, _kNavBarLargeTitleHeightExtension)
  ];

  @override
  CupertinoAppBarSnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CupertinoAppBarSnapScrollPhysics(
      parent: buildParent(ancestor),
    );
  }
}

typedef SnapBuilder = List<Snap> Function();

class BuilderSnapScrollPhysics extends BaseSnapScrollPhysics {
  BuilderSnapScrollPhysics(this.builder, {ScrollPhysics? parent})
      : super(parent: parent);

  final SnapBuilder builder;

  @override
  List<Snap> get snaps => builder();

  @override
  BuilderSnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BuilderSnapScrollPhysics(
      builder,
      parent: buildParent(ancestor),
    );
  }
}

abstract class BaseSnapScrollPhysics extends ScrollPhysics
    implements SnapScrollPhysics {
  BaseSnapScrollPhysics({
    ScrollPhysics? parent,
  }) : super(parent: parent);

  List<Snap> get snaps;

  double _getTargetPixels(ScrollMetrics position, double proposedEnd,
      Tolerance tolerance, double velocity) {
    Snap? snap = getSnap(position, proposedEnd, tolerance, velocity);
    if (snap == null) return proposedEnd;

    return snap.targetPixelsFor(position, proposedEnd, tolerance, velocity);
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final simulation = super.createBallisticSimulation(position, velocity);
    final proposedPixels = simulation?.x(double.infinity) ?? position.pixels;

    final double target =
        _getTargetPixels(position, proposedPixels, this.tolerance, velocity);
    print('p $proposedPixels, $target');
    if ((target - proposedPixels).abs() > precisionErrorTolerance) {
      if (simulation is BouncingScrollSimulation) {
        return BouncingScrollSimulation(
          leadingExtent: math.min(target, position.pixels),
          trailingExtent: math.max(target, position.pixels),
          velocity: velocity,
          position: position.pixels,
          spring: spring,
          tolerance: tolerance,
        );
      }
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }
    return simulation;
  }

  @override
  bool get allowImplicitScrolling => false;

  Snap? getSnap(ScrollMetrics position, double proposedEnd, Tolerance tolerance,
      double velocity) {
    for (final snap in snaps) {
      if (snap.shouldApplyFor(position, proposedEnd)) return snap;
    }
    return null;
  }
}
