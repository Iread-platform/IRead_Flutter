import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final _radius;
  final _imageUrl;

  UserAvatar({radius, imageUrl})
      : _radius = radius,
        _imageUrl = imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
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

    path.moveTo(x * 0.2, y / 2.5);
    path.cubicTo(x * 0.1, y / 2.5, x * 0.8, -2, x * 0.98, y / 2);

    path.addPolygon([
      Offset(x * 0.2, y / 2.5),
      Offset(x * 0.18, y / 2.4),
      Offset(x * 0.16, y / 2.3),
      Offset(x * 0.14, y / 2.2),
      Offset(x * 0.12, y / 2.1),
      Offset(0, y),
      Offset(x, y),
      Offset(x, y / 1.8),
      Offset(x * 0.99, y / 1.9),
      Offset(x * 0.98, y / 2),
    ], false);

    /* path.addPolygon([
      Offset(0, y),
      Offset(0, y * 0.40),
      Offset(x * 0.01, y * 0.38),
      Offset(x * 0.02, y * 0.35),
      Offset(x * 0.05, y * 0.32),
      Offset(x * 0.07, y * 0.30),
      Offset(x * 0.08, y * 0.29),
      Offset(x * 0.1, y * 0.26),
      Offset(x * 0.12, y * 0.25),
      Offset(x * 0.15, y * 0.23),
      Offset(x * 0.18, y * 0.19),
      Offset(x * 0.2, y * 0.18),
      Offset(x * 0.22, y * 0.17),
      Offset(x * 0.25, y * 0.16),
      Offset(x * 0.28, y * 0.14),
      Offset(x * 0.3, y * 0.13),
      Offset(x * 0.33, y * 0.12),
      Offset(x * 0.35, y * 0.11),
      Offset(x * 0.38, y * 0.10),
      Offset(x * 0.4, y * 0.09),
      Offset(x * 0.43, y * 0.08),
      Offset(x * 0.45, y * 0.07),
      Offset(x * 0.48, y * 0.06),
      Offset(x * 0.5, y * 0.05),
      Offset(x * 0.53, y * 0.04),
      Offset(x * 0.55, y * 0.03),
      Offset(x * 0.58, y * 0.02),
      Offset(x * 0.6, y * 0.01),
      Offset(x * 0.7, y * 0.05),
      Offset(x * 0.75, y * 0.05),
      Offset(x * 0.78, y * 0.07),
      Offset(x * 0.81, y * 0.11),
      Offset(x * 0.82, y * 0.12),
      Offset(x * 0.83, y * 0.13),
      Offset(x * 0.84, y * 0.14),
      Offset(x * 0.86, y * 0.16),
      Offset(x * 0.90, y * 0.20),
      Offset(x * 0.95, y * 0.29),
      Offset(x, y * 0.35),
      Offset(x, y),
      Offset(x, y),
    ], true); */
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
