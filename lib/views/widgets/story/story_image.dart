import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/config/themes/shadows.dart';

/// [imageUrl] refer to the network url og the image, 'do not use asset path',
/// It is 'required'.
/// [color] refer to the image background color, It is 'required'.
class StoryImage extends StatelessWidget {
  final String _imageUrl;
  final Color _color;
  final double _minHeight;

  StoryImage({@required imageUrl, @required color})
      : _imageUrl = imageUrl,
        _color = color,
        _minHeight = 150;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.only(left: 12, top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(storyBorderRadius),
            color: _color,
            boxShadow: [mediumBottomRightShadow]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(storyBorderRadius)),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: _minHeight),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [mediumBottomRightShadow]),
              child: AnimatedNetworkImage(
                imageUrl: _imageUrl,
              ),
            ),
          ),
        ),
      );
}

class AnimatedNetworkImage extends StatefulWidget {
  final String _imageUrl;

  const AnimatedNetworkImage({@required String imageUrl, Key key})
      : _imageUrl = imageUrl,
        super(key: key);

  @override
  _AnimatedNetworkImageState createState() => _AnimatedNetworkImageState();
}

class _AnimatedNetworkImageState extends State<AnimatedNetworkImage>
    with TickerProviderStateMixin {
  bool imageLoaded;
  AnimationController _controller;

  @override
  void initState() {
    imageLoaded = false;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget._imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        if (!imageLoaded) {
          imageLoaded = true;
        }

        final double loadingValue = (loadingProgress.expectedTotalBytes != null)
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes
            : 0;

        return Container(
            child:
                Center(child: CircularProgressIndicator(value: loadingValue)));
      },
      errorBuilder: (BuildContext context, exception, stackTrace) {
        print(stackTrace);
        _controller.forward();
        return AnimatedBuilder(
            animation: _controller,
            builder: (context, snapshot) {
              return Opacity(
                child: SvgPicture.asset('assets/images/shared/error.svg'),
                opacity: _controller.value,
              );
            });
      },
      frameBuilder:
          (BuildContext context, child, frame, bool wasSynchronoslyLoaded) {
        if (frame != null) {
          _controller.forward();
          return AnimatedBuilder(
              animation: _controller,
              child: child,
              builder: (context, child) => Opacity(
                    opacity: _controller.value,
                    child: child,
                  ));
        }

        return imageLoaded
            ? child
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
