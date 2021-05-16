import 'package:flutter/cupertino.dart';
import 'responsive_layout_builder.dart';
import 'package:iread_flutter/utils/extensions.dart';

class ResponsiveFlex extends StatelessWidget {
  final List<int> _onXSm;
  final List<int> _onSm;
  final List<int> _onMd;
  final List<int> _onLg;
  final List<int> _onXLg;
  final List<int> _onXXLg;
  final List<Widget> _children;
  final List<Axis> _axisOnBreakPoint;
  final Axis _direction;
  final bool _convertToColumnOnXSm;
  final CrossAxisAlignment _crossAxisAlignment;

  /// A wrapper widget that helps to write a customizable responsive design,
  /// This widget benefits from the `flex` widget to create a responsive design
  /// in both directions `horizontal` and `vertical`, and uses the bootstrap's
  /// standard web breakpoints to reorder widgets.
  ///
  /// By default this widget wraps its children by an `expanded` widget with
  /// a default `flex` value = 1.
  ///
  /// *** parameters ***
  /// * [onXSm] the felx values to Render widget when `screen size is < 576`.
  /// * [onSm] the felx values to Render widget when `screen size is >= 576`.
  /// * [onMd] the felx values to Render widget when `screen size is >= 768`.
  /// * [onLg] the felx values to Render widget when `screen size is >= 992`.
  /// * [onXLg] the felx values to Render widget when `screen size is >= 1200`.
  /// * [onXXLg] the felx values to Render widget when `screen size is >= 1400`.
  /// * [direction] the direction to arrange widgets.
  /// * [crossAxisAlignment] Align children in the cross axis.
  /// * [onReverseDirection] The condition to revrse children direction.
  ///
  /// *** Example ***
  ///
  /// ```
  /// ResponsiveFlex(
  ///       children: [
  ///         Container(
  ///           color: Colors.red,
  ///         ),
  ///         Container(
  ///           color: Colors.blue,
  ///         ),
  ///         Container(
  ///           color: Colors.green,
  ///         ),
  ///         Container(
  ///           color: Colors.black,
  ///         ),
  ///         Container(
  ///           color: Colors.amber,
  ///         ),
  ///       ],
  ///       direction: Axis.horizontal,
  ///     )
  /// ```
  ResponsiveFlex(
      {@required List<Widget> children,
      List<int> onXSm,
      @required Axis direction,
      CrossAxisAlignment crossAxisAlignment,
      bool convertToColumnOnXSm = true,
      List<Axis> axisOnBreakPoint,
      List<int> onSm,
      List<int> onMd,
      List<int> onLg,
      List<int> onXLg,
      List<int> onXXLg})
      : _children = children,
        _direction = direction,
        _axisOnBreakPoint = axisOnBreakPoint,
        _convertToColumnOnXSm = convertToColumnOnXSm,
        _crossAxisAlignment = crossAxisAlignment ?? direction == Axis.horizontal
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        _onXSm = onXSm,
        _onSm = onSm ?? onXSm,
        _onMd = onMd ?? onSm ?? onXSm,
        _onLg = onLg ?? onMd ?? onSm ?? onXSm,
        _onXLg = onXLg ?? onLg ?? onMd ?? onSm ?? onXSm,
        _onXXLg = onXXLg ?? onXLg ?? onLg ?? onMd ?? onSm ?? onXSm;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      onXSm: (context) => _generateFlex(
          context,
          _onXSm,
          _axisOnBreakPoint.containsIndex(0)
              ? _axisOnBreakPoint?.elementAt(0)
              : _convertToColumnOnXSm
                  ? Axis.vertical
                  : _direction,
          mobileVersion: _convertToColumnOnXSm),
      onSm: (context) => _generateFlex(
          context,
          _onSm,
          _axisOnBreakPoint.containsIndex(1)
              ? _axisOnBreakPoint?.elementAt(1)
              : _direction),
      onMd: (context) => _generateFlex(
          context,
          _onMd,
          _axisOnBreakPoint.containsIndex(2)
              ? _axisOnBreakPoint?.elementAt(2)
              : _direction),
      onLg: (context) => _generateFlex(
          context,
          _onLg,
          _axisOnBreakPoint.containsIndex(3)
              ? _axisOnBreakPoint?.elementAt(3)
              : _direction),
      onXLg: (context) => _generateFlex(
          context,
          _onXLg,
          _axisOnBreakPoint.containsIndex(4)
              ? _axisOnBreakPoint?.elementAt(4)
              : _direction),
      onXXLg: (context) => _generateFlex(
          context,
          _onXXLg,
          _axisOnBreakPoint.containsIndex(5)
              ? _axisOnBreakPoint.elementAt(5)
              : _direction),
    );
  }

  Widget _generateFlex(BuildContext context, List<int> flex, Axis direction,
      {bool mobileVersion = false}) {
    return Flex(
      crossAxisAlignment: _crossAxisAlignment,
      direction: direction,
      children: _children
          .mapIndexed((e, i) => flex?.elementAt(i) == 0
              ? Container()
              : mobileVersion
                  ? Container(
                      child: e,
                    )
                  : Expanded(
                      child: e,
                      flex: flex.containsIndex(i) ? flex[i] : 1,
                    ))
          .toList(),
    );
  }
}
