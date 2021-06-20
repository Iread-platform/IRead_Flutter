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
