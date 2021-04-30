# snap_scroll_physics



1. Snap your scroll view to a given extent.

In Progress

2. Set zones where the scroll offset should avoid.

```dart
physics: SnapScrollPhysics.preventStopBetween(0, 200),
```

```dart
physics: SnapScrollPhysics.preventStopInAreas(
    areas: [
        PreventSnapArea(0, 100),
        PreventSnapArea(100, 200),
    ]
),
```

```dart
physics: SnapScrollPhysics.cupertinoAppBar, // Default values for the Cupertino appbar
```