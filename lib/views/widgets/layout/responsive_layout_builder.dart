import 'package:flutter/cupertino.dart';

class ResponsiveLayoutBuilder extends StatelessWidget {
  Widget Function(BuildContext) _onXSm;
  Widget Function(BuildContext) _onSm;
  Widget Function(BuildContext) _onMd;
  Widget Function(BuildContext) _onLg;
  Widget Function(BuildContext) _onXLg;
  Widget Function(BuildContext) _onXXLg;

  /// A wrapper widget that helps to writes a customizable responsive design,
  /// This widget uses the bootstrap's standard web breakpoints.
  ///
  /// *** parameters ***
  /// * [onXSm] the Rendered widget when `screen size is < 576`.
  /// * [onSm] the Rendered widget when `screen size is >= 576`.
  /// * [onMd] the Rendered widget when `screen size is >= 768`.
  /// * [onLg] the Rendered widget when `screen size is >= 992`.
  /// * [onXLg] the Rendered widget when `screen size is >= 1200`.
  /// * [onXXLg] the Rendered widget when `screen size is >= 1400`.
  ///
  /// *** Example ***
  ///
  /// ```
  /// ResponsiveLayoutBuilder(
  ///        onXSm: (context) => Container(
  ///         child: Text("XSM"),
  ///        ),
  ///     onMd: (context) => Container(child: Text("MD")),
  ///     onLg: (context) => Container(child: Text("LG")),
  ///   )
  /// ```
  ResponsiveLayoutBuilder(
      {@required Widget Function(BuildContext) onXSm,
      Widget Function(BuildContext) onSm,
      Widget Function(BuildContext) onMd,
      Widget Function(BuildContext) onLg,
      Widget Function(BuildContext) onXLg,
      Widget Function(BuildContext) onXXLg}){
    _onXSm = onXSm;
    _onSm = onSm ?? _onXSm;
    _onMd = onMd ?? _onSm;
    _onLg = onLg ?? _onMd;
    _onXLg = onXLg ?? _onLg;
    _onXXLg = onXXLg ?? _onXLg;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
        builder: (context, constrains) => width < 576
            ? _onXSm(context)
            : width >= 576 && width < 768
                ? _onSm(context)
                : width >= 768 && width < 992
                    ? _onMd(context)
                    : width >= 992 && width < 1200
                        ? _onLg(context)
                        : width >= 1200 && width < 1400
                            ? _onXLg(context)
                            : _onXXLg(context));
  }
}
