import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wear/flutter_wear.dart';
import 'package:flutter_wear/shape.dart';

// Builds a child for a WatchFaceBuilder
typedef Widget WearShapeBuilder(
  BuildContext context,
  Shape shape,
);

class WearShape extends StatefulWidget {
  /// This callback should contain two parameters:
  ///
  /// * [BuildContext] context
  /// * [Shape] shape
  final WearShapeBuilder builder;

  /// Helps in retrieving the shape of the wear device.
  ///
  /// It has a required parameter [builder], which is of
  /// type [WearShapeBuilder].
  ///
  /// The builder callback should contain two parameters:
  ///
  /// * [BuildContext] context
  /// * [Shape] shape
  WearShape({
    @required this.builder,
    Key key,
  })  : assert(builder != null),
        super(key: key);

  @override
  _WearShapeState createState() => _WearShapeState();
}

class _WearShapeState extends State<WearShape> {
  Shape shape;

  @override
  initState() {
    super.initState();

    // Initialize shape of the WearOS device
    // to be round
    shape = Shape.round;
    _setShape();
  }

  _setShape() async {
    shape = await _retrieveShape();
    setState(() => shape);
  }

  // Fetches the shape of the watch device
  Future<Shape> _retrieveShape() async {
    try {
      final int result =
          await FlutterWear.channel.invokeMethod('retrieveShape');
      return result == 1 ? Shape.square : Shape.round;
    } on PlatformException catch (e) {
      debugPrint('Error detecting shape: $e');
      return Shape.round;
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, shape);
}
