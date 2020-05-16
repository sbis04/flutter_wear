import 'package:flutter/material.dart';
import 'package:flutter_wear/flutter_wear.dart';
import 'package:flutter_wear/mode.dart';

/// Builds a child for AmbientModeBuilder
typedef Widget WearModeBuilder(
  BuildContext context,
  Mode mode,
);

class WearMode extends StatefulWidget {
  final WearModeBuilder builder;
  final Function update;

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
  /// Initialize ambient mode to be active
  Mode _mode = Mode.active;

  @override
  initState() {
    super.initState();

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
