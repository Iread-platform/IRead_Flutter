import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final _radius;
  final _imageUrl;
  final _showShadow;

  UserAvatar({radius, imageUrl, showShadow})
      : _radius = radius,
        _imageUrl = imageUrl,
        _showShadow = showShadow ?? false;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: AvatarClipper(),
        shadow: Shadow(
          color: Color(0XAA7A07BB),
          blurRadius: _showShadow? 5 : 0
        )
      ),
      child: ClipPath(
        clipper: AvatarClipper(),
        child: CircleAvatar(
          radius: _radius,
          backgroundImage: NetworkImage(
            _imageUrl,
          ),
        ),
      ),
    );
  }
}

class AvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final y = size.height;
    final x = size.width;

    path.addOval(
        Rect.fromCircle(center: Offset(x * 0.6, y * 0.4), radius: x * 0.3));
    path.addOval(
        Rect.fromCircle(center: Offset(x / 2, y / 2), radius: x * 0.35));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
