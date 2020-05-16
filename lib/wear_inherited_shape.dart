import 'package:flutter/material.dart';
import 'package:flutter_wear/shape.dart';

/// An inherited widget that holds the shape of the Watch
class WearInheritedShape extends InheritedWidget {
  const WearInheritedShape({
    Key key,
    @required this.shape,
    @required Widget child,
  })  : assert(shape != null),
        assert(child != null),
        super(key: key, child: child);

  final Shape shape;

  static WearInheritedShape of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WearInheritedShape>();
  }

  @override
  bool updateShouldNotify(WearInheritedShape old) => shape != old.shape;
}
