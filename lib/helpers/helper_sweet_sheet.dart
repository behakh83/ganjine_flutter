import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ganjine/constants/const_strings.dart';

bool _exitApp = false;
bool _doublePop = false;

void showNoConnectionDialog(BuildContext context, VoidCallback callback,
    {bool exitApp = false}) {
  _doublePop = true;
  _exitApp = exitApp;
  SweetSheet().show(
    context: context,
    isDismissible: false,
    description: Text(kStringRequiredInternet),
    color: SweetSheetColor.DANGER,
    positive: SweetSheetAction(
      title: kStringRetry,
      onPressed: () {
        Navigator.pop(context);
        callback();
      },
    ),
    title: Text(kStringNoInternet),
    icon: Icons.signal_wifi_off,
  );
}

class SweetSheetAction extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;

  SweetSheetAction({
    @required this.title,
    @required this.onPressed,
    this.icon,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? FlatButton(
            onPressed: onPressed,
            child: Text(
              title,
              style: TextStyle(
                color: color,
              ),
            ),
          )
        : FlatButton.icon(
            onPressed: onPressed,
            label: Text(
              title,
            ),
            icon: Icon(
              icon,
              color: color,
            ),
          );
  }
}

class CustomSheetColor {
  Color main;
  Color accent;
  Color icon;

  CustomSheetColor({@required this.main, @required this.accent, this.icon});
}

class SweetSheetColor {
  // ignore: non_constant_identifier_names
  static CustomSheetColor DANGER = CustomSheetColor(
    main: Color(0xffEF5350),
    accent: Color(0xffD32F2F),
    icon: Colors.white,
  );
  // ignore: non_constant_identifier_names
  static CustomSheetColor SUCCESS = CustomSheetColor(
    main: Color(0xff009688),
    accent: Color(0xff00695C),
    icon: Colors.white,
  );
  // ignore: non_constant_identifier_names
  static CustomSheetColor WARNING = CustomSheetColor(
    main: Color(0xffFF8C00),
    accent: Color(0xffF55932),
    icon: Colors.white,
  );
  // ignore: non_constant_identifier_names
  static CustomSheetColor NICE = CustomSheetColor(
    main: Color(0xff2979FF),
    accent: Color(0xff0D47A1),
    icon: Colors.white,
  );
}

class SweetSheet {
  show({
    @required BuildContext context,
    Text title,
    @required Text description,
    @required CustomSheetColor color,
    @required SweetSheetAction positive,
    SweetSheetAction negative,
    IconData icon,
    bool isDismissible,
  }) {
    _showModalBottomSheet(
      isDismissible: isDismissible,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: double.infinity,
              color: color.main,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title == null
                      ? Container()
                      : DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                          child: title),
                  _buildContent(color, description, icon)
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: color.accent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _buildActions(positive, negative),
              ),
            )
          ],
        );
      },
    );
  }

  _buildContent(CustomSheetColor color, Text description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SingleChildScrollView(
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'circular'),
                        child: description),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Icon(
                    icon,
                    size: 52,
                    color: color.icon ?? Colors.white,
                  )
                ],
              )
            : DefaultTextStyle(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                child: description,
              ),
      ),
    );
  }

  _buildActions(SweetSheetAction positive, SweetSheetAction negative) {
    List<SweetSheetAction> actions = [];

    // This order is important
    // It helps to place the positive at the right and the negative before
    if (negative != null) {
      actions.add(negative);
    }

    if (positive != null) {
      actions.add(positive);
    }

    return actions;
  }

  Future<T> _showModalBottomSheet<T>({
    @required BuildContext context,
    @required WidgetBuilder builder,
    Color backgroundColor,
    double elevation,
    ShapeBorder shape,
    Clip clipBehavior,
    Color barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    assert(context != null);
    assert(builder != null);
    assert(isScrollControlled != null);
    assert(useRootNavigator != null);
    assert(isDismissible != null);
    assert(enableDrag != null);
    assert(debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));

    return Navigator.of(context, rootNavigator: useRootNavigator)
        .push(_ModalBottomSheetRoute<T>(
      builder: builder,
      theme: Theme.of(context, shadowThemeOnly: true),
      isScrollControlled: isScrollControlled,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      isDismissible: isDismissible,
      modalBarrierColor: barrierColor,
      enableDrag: enableDrag,
    ));
  }
}

const Duration _bottomSheetEnterDuration = Duration(milliseconds: 250);
const Duration _bottomSheetExitDuration = Duration(milliseconds: 200);
const Curve decelerateEasing = Cubic(0.0, 0.0, 0.2, 1.0);
const Curve _modalBottomSheetCurve = decelerateEasing;

class _ModalBottomSheetRoute<T> extends PopupRoute<T> {
  _ModalBottomSheetRoute({
    this.builder,
    this.theme,
    this.barrierLabel,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.modalBarrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
    @required this.isScrollControlled,
    RouteSettings settings,
  })  : assert(isScrollControlled != null),
        assert(isDismissible != null),
        assert(enableDrag != null),
        super(settings: settings);

  final WidgetBuilder builder;
  final ThemeData theme;
  final bool isScrollControlled;
  final Color backgroundColor;
  final double elevation;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final Color modalBarrierColor;
  final bool isDismissible;
  final bool enableDrag;

  @override
  Duration get transitionDuration => _bottomSheetEnterDuration;

  @override
  Duration get reverseTransitionDuration => _bottomSheetExitDuration;

  @override
  bool get barrierDismissible => isDismissible;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => modalBarrierColor ?? Colors.black54;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final BottomSheetThemeData sheetTheme =
        theme?.bottomSheetTheme ?? Theme.of(context).bottomSheetTheme;
    // By definition, the bottom sheet is aligned to the bottom of the page
    // and isn't exposed to the top padding of the MediaQuery.
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _ModalBottomSheet<T>(
        route: this,
        backgroundColor: backgroundColor ??
            sheetTheme?.modalBackgroundColor ??
            sheetTheme?.backgroundColor,
        elevation:
            elevation ?? sheetTheme?.modalElevation ?? sheetTheme?.elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        isScrollControlled: isScrollControlled,
        enableDrag: enableDrag,
      ),
    );
    if (theme != null) bottomSheet = Theme(data: theme, child: bottomSheet);
    return bottomSheet;
  }
}

class _BottomSheetSuspendedCurve extends ParametricCurve<double> {
  /// Creates a suspended curve.
  const _BottomSheetSuspendedCurve(
    this.startingPoint, {
    this.curve = Curves.easeOutCubic,
  })  : assert(startingPoint != null),
        assert(curve != null);

  /// The progress value at which [curve] should begin.
  ///
  /// This defaults to [Curves.easeOutCubic].
  final double startingPoint;

  /// The curve to use when [startingPoint] is reached.
  final Curve curve;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    assert(startingPoint >= 0.0 && startingPoint <= 1.0);

    if (t < startingPoint) {
      return t;
    }

    if (t == 1.0) {
      return t;
    }

    final double curveProgress = (t - startingPoint) / (1 - startingPoint);
    final double transformed = curve.transform(curveProgress);
    return lerpDouble(startingPoint, 1, transformed);
  }

  @override
  String toString() {
    return '${describeIdentity(this)}($startingPoint, $curve)';
  }
}

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  _ModalBottomSheetLayout(this.progress, this.isScrollControlled);

  final double progress;
  final bool isScrollControlled;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: isScrollControlled
          ? constraints.maxHeight
          : constraints.maxHeight * 9.0 / 16.0,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _ModalBottomSheet<T> extends StatefulWidget {
  const _ModalBottomSheet({
    Key key,
    this.route,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.isScrollControlled = false,
    this.enableDrag = true,
  })  : assert(isScrollControlled != null),
        assert(enableDrag != null),
        super(key: key);

  final _ModalBottomSheetRoute<T> route;
  final bool isScrollControlled;
  final Color backgroundColor;
  final double elevation;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final bool enableDrag;

  @override
  _ModalBottomSheetState<T> createState() => _ModalBottomSheetState<T>();
}

class _ModalBottomSheetState<T> extends State<_ModalBottomSheet<T>> {
  ParametricCurve<double> animationCurve = _modalBottomSheetCurve;

  String _getRouteLabel(MaterialLocalizations localizations) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return '';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return localizations.dialogLabel;
    }
    return null;
  }

  void handleDragStart(DragStartDetails details) {
    // Allow the bottom sheet to track the user's finger accurately.
    animationCurve = Curves.linear;
  }

  void handleDragEnd(DragEndDetails details, {bool isClosing}) {
    // Allow the bottom sheet to animate smoothly from its current position.
    animationCurve = _BottomSheetSuspendedCurve(
      widget.route.animation.value,
      curve: _modalBottomSheetCurve,
    );
  }

  Future<bool> _onWillPop() async {
    if (_exitApp) {
      _doublePop = false;
      SweetSheet().show(
        context: context,
        description: Text(''),
        isDismissible: false,
        color: SweetSheetColor.WARNING,
        positive: SweetSheetAction(
          title: kStringYes,
          onPressed: () {
            SystemNavigator.pop(animated: true);
          },
        ),
        negative: SweetSheetAction(
          title: kStringNo,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(kStringExit),
        icon: Icons.exit_to_app,
      );
    } else if (_doublePop) {
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final String routeLabel = _getRouteLabel(localizations);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: AnimatedBuilder(
        animation: widget.route.animation,
        builder: (BuildContext context, Widget child) {
          // Disable the initial animation when accessible navigation is on so
          // that the semantics are added to the tree at the correct time.
          final double animationValue = animationCurve.transform(
              mediaQuery.accessibleNavigation
                  ? 1.0
                  : widget.route.animation.value);
          return Semantics(
            scopesRoute: true,
            namesRoute: true,
            label: routeLabel,
            explicitChildNodes: true,
            child: ClipRect(
              child: CustomSingleChildLayout(
                delegate: _ModalBottomSheetLayout(
                    animationValue, widget.isScrollControlled),
                child: BottomSheet(
                  animationController: widget.route._animationController,
                  onClosing: () {
                    if (widget.route.isCurrent) {
                      Navigator.pop(context);
                    }
                  },
                  builder: widget.route.builder,
                  backgroundColor: widget.backgroundColor,
                  elevation: widget.elevation,
                  shape: widget.shape,
                  clipBehavior: widget.clipBehavior,
                  enableDrag: widget.enableDrag,
                  onDragStart: handleDragStart,
                  onDragEnd: handleDragEnd,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
