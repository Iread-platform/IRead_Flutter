import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double _progress;
  final Color _color;
  final double _height;
  final double _borderWidth;
  final double _padding;
  final double _borderRadius;

  ProgressBar({progress, color, height, borderWidth, padding, borderRadius})
      : _color = color,
        _progress = progress ?? 0,
        _height = height ?? 10,
        _borderWidth = borderWidth ?? 1,
        _padding = padding ?? 1,
        _borderRadius = borderRadius ?? 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: EdgeInsets.all(_padding),
      decoration: BoxDecoration(
          border: Border.all(
            color: _color ?? Theme.of(context).colorScheme.primary,
            width: _borderWidth,
          ),
          borderRadius: BorderRadius.circular(_borderRadius)),
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
