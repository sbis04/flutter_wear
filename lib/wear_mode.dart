import 'package:flutter/material.dart';
import 'package:flutter_wear/flutter_wear.dart';
import 'package:flutter_wear/mode.dart';

/// Builds a child for AmbientModeBuilder
typedef Widget WearModeBuilder(
  BuildContext context,
  Mode mode,
);

class WearMode extends StatefulWidget {
  /// This callback should contain two parameters:
  ///
  /// * [BuildContext] context
  /// * [Mode] mode
  final WearModeBuilder builder;

  /// A function that is called every time the watch triggers an
  /// ambient update request.
  ///
  /// NOTE: If an update function is passed in, this widget will
  /// not perform an update itself.
  final Function update;

  /// Helps in determining the current mode of the wear device.
  ///
  /// It has a required parameter [builder], which is of
  /// type [WearModeBuilder].
  ///
  /// The builder callback should contain two parameters:
  ///
  /// * [BuildContext] context
  /// * [Mode] mode
  ///
  /// There is also an optional parameter [update], which takes a
  /// function that is called every time the watch triggers an
  /// ambient update request.
  ///
  /// NOTE: If an update function is passed in, this widget will
  /// not perform an update itself.
  WearMode({
    @required this.builder,
    Key key,
    this.update,
  })  : assert(builder != null),
        super(key: key);

  @override
  _WearModeState createState() => _WearModeState();
}

class _WearModeState extends State<WearMode> {
  // Initialize current mode to be active
  Mode _mode = Mode.active;

  @override
  initState() {
    super.initState();

    // Handles the rebuild of the widgets as the mode changes
    FlutterWear.channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'ambientMode':
          setState(() => _mode = Mode.ambient);
          break;
        case 'updateMode':
          if (widget.update != null)
            widget.update();
          else
            setState(() => _mode = Mode.ambient);
          break;
        case 'exitAmbientMode':
          setState(() => _mode = Mode.active);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _mode);
}
