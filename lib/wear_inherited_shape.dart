import 'package:flutter/material.dart';
import 'package:flutter_wear/shape.dart';

/// An inherited widget that holds the shape of the Watch
///
/// It has two required parameters:
///
/// * [shape] is the shape of the wear device
/// * [child] is to which the shape should be inherited
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
