import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

final kMusicImageUrl =
    'https://images.unsplash.com/photo-1509114397022-ed747cca3f65?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2775&q=80';
final kMusicCoverImageUrl =
    'https://images.unsplash.com/photo-1502773860571-211a597d6e4b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80';

class MusicExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expandedHeight = 600.0;
    return CustomScrollView(
      physics: SnapScrollPhysics.preventStopInZones(
        areas: [
          PreventSnapArea(0, 100, 0),
          PreventSnapArea(expandedHeight - kToolbarHeight - 100,
              expandedHeight - kToolbarHeight, expandedHeight - kToolbarHeight),
        ],
      ),
      slivers: [
        SliverPersistentHeader(
          delegate: CustomHeaderDelegate(expandedHeight),
          pinned: true,
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

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;

  CustomHeaderDelegate(this.height);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final showBar = height - kToolbarHeight - 120 < shrinkOffset;
    final opacity = 1 - shrinkOffset / height;
    final appBarColor = Colors.white;
    final titleColor = Colors.pinkAccent[200];
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 1,
          child: Image.network(
            kMusicImageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
                Theme.of(context).scaffoldBackgroundColor
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        )),
        Positioned(
          //  bottom: 32,
          left: 0,
          right: 0,
          top: 120 - shrinkOffset * 0.2,
          child: Opacity(
            opacity: opacity,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      'https://images.unsplash.com/photo-1619583541439-63542c5d8d52?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Brave Love',
                    style: TextStyle(
                        color: titleColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 32),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Alexis North',
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(1)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 1]),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: -shrinkOffset / 1.1,
          child: Container(
            height: height,
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 120),
              height: (100.0 - shrinkOffset).clamp(0.0, 62.0),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1), blurRadius: 12),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text('Start'),
                    Spacer(),
                    Stack(children: [
                      Container(
                        height: 24,
                        width: 24,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: titleColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: TweenAnimationBuilder(
            tween: ColorTween(
                begin: appBarColor.withOpacity(0),
                end: appBarColor.withOpacity(showBar ? 1 : 0)),
            duration: Duration(milliseconds: 400),
            builder: (context, color, child) => AppBar(
              elevation: 0,
              backgroundColor: color,
              title: AnimatedDefaultTextStyle(
                  child: Text('Luigi Comba'),
                  style:
                      TextStyle(color: titleColor.withOpacity(showBar ? 1 : 0)),
                  duration: Duration(milliseconds: 400)),
              brightness: showBar ? Brightness.dark : Brightness.light,
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => kToolbarHeight;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
