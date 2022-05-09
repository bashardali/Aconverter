import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  /// Creates a material design drawer.
  ///
  /// Typically used in the [Scaffold.drawer] property.
  ///
  /// The [elevation] must be non-negative.
  const MyDrawer({
    Key? key,
    this.elevation = 16.0,
    required this.child,
    required this.semanticLabel,
    this.isEndDrawer = false
  }) : assert(elevation != null && elevation >= 0.0),
        super(key: key);

  /// Added so the shape changes left or right depending the position of the drawer
  final bool isEndDrawer;

  /// The z-coordinate at which to place this drawer relative to its parent.
  ///
  /// This controls the size of the shadow below the drawer.
  ///
  /// Defaults to 16, the appropriate elevation for drawers. The value is
  /// always non-negative.
  final double elevation;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [SliverList].
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the drawer is opened and closed.
  ///
  /// If this label is not provided, it will default to
  /// [MaterialLocalizations.drawerLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.namesRoute], for a description of how this
  ///    value is used.
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = semanticLabel;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        label = semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
       // label = (semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel)!;
    }
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: Align(
          alignment: isEndDrawer ? Alignment.topRight : Alignment.topLeft,
          child: FractionallySizedBox(
              heightFactor: 0.95,
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(width: 304.0), //304 is the kWidth of the Drawer
                child: Material(
                  elevation: elevation,
                  child: child,
                  shape: RoundedRectangleBorder( //Add this ShapeBorder to the Material
                      borderRadius: isEndDrawer ?
                      BorderRadius.only(bottomLeft: Radius.circular(220))
                          : BorderRadius.only(bottomRight: Radius.circular(220)),
                      side: BorderSide.none
                  ),
                ),
              )
          )
      ),
    );
  }
}