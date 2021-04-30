

import 'package:flutter/material.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class MaterialExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: SnapScrollPhysics(snaps: [
        Snap.avoidZone(0, 200.0 - kToolbarHeight),
        Snap.avoidZone(200.0 - kToolbarHeight, 200.0)
      ]),
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          title: Text('Hello'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(title: Text('Item $index'));
          }),
        ),
      ],
    );
  }
}
