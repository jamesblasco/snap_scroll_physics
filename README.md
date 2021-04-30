# snap_scroll_physics


```dart
physics: SnapScrollPhysics(
    snaps: [
        Snap(200, distance: 50), // If the scroll offset is expected to stop between 150-250 the scroll will snap to 200,
        Snap(200, leadingDistance: 50), // If the scroll offset is expected to stop  between 150-200 the scroll will snap to 200,
        Snap(200, trailingDistance: 50), // If the scroll offset is expected to stop between 150-200 the scroll will snap to 200,
        Snap(200, trailingDistance: 50), // If the scroll offset is expected to stop between 150-200 the scroll will snap to 200,
        Snap.avoidZone(0, 200), // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-99, and to 200 if it is between 100-200,
        Snap.avoidZone(0, 200, delimiter: 50), // If the scroll offset is expected to stop between 0-200, the scroll will snap to 0 if the expected one is between 0-49, and to 200 if it is between 50-200
    ]
),
```

IMPORTANT! Sadly ScrollPhysics are not reactivily updated, so if you change the values, they won't be automatically  updated. [See #80051](https://github.com/flutter/flutter/issues/80051).


This can be temporaly fixed by this, while is discouraged in production if no changes are needed at runtime:
```dart

List<Snap> getSnaps() {
    return [
       Snap(200), // Hot reload works
    ];
}
@override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: SnapScrollPhysics.builder(getSnaps),
      slivers: [
       // ....
      ],
    );
  }
```




```dart
physics: SnapScrollPhysics.cupertinoAppBar, // Default values for the Cupertino appbar
```