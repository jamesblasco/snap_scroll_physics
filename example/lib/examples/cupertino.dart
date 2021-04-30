


import 'package:flutter/cupertino.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class CupertinoExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: SnapScrollPhysics.cupertinoAppBar,
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text('Hello'),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            return;
          },
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: CupertinoSearchTextField(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.all(12),
                children: [
                  CupertinoFormRow(
                    prefix: Text('Hello'),
                    child: SizedBox(),
                  ),
                  CupertinoFormRow(
                    prefix: Text('Hello'),
                    child: SizedBox(),
                  ),
                  CupertinoFormRow(
                    prefix: Text('Hello'),
                    child: SizedBox(),
                  )
                ]);
          }),
        ),
      ],
    );
  }
}
