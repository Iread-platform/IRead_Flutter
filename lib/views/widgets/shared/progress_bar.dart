import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double _progress;
  final Color _color;
  final double _height;
  final double _borderWidth;
  final double _padding;
  final double _borderRadius;
  final bool _dropShadow;
  final Offset _shadowOffset;
  final double _shadowBlurRadius;

  ProgressBar(
      {progress,
      color,
      height,
      borderWidth,
      padding,
      borderRadius,
      dropShadow,
      shadowOffset,
      shadowBlurRadius})
      : _color = color,
        _progress = progress ?? 0,
        _height = height ?? 10.0,
        _borderWidth = borderWidth ?? 1.0,
        _padding = padding ?? 1.0,
        _borderRadius = borderRadius ?? 50.0,
        _dropShadow = dropShadow ?? false,
        _shadowOffset = shadowOffset ?? Offset(0, 0),
        _shadowBlurRadius = shadowBlurRadius ?? 2.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: EdgeInsets.all(_padding),
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.surface,
            width: _borderWidth,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
          boxShadow: _dropShadow
              ? [
                  BoxShadow(
                    blurRadius: _shadowBlurRadius,
                    color: Colors.black12,
                    offset: _shadowOffset,
                  )
                ]
              : []),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: LinearProgressIndicator(
          backgroundColor: Theme.of(context).colorScheme.surface,
          valueColor: AlwaysStoppedAnimation<Color>(
              _color ?? Theme.of(context).colorScheme.primary),
          value: _progress,
          minHeight: 8,
        ),
      ),
    );
  }
}
