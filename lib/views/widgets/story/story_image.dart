import 'package:flutter/material.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';

/// [imageUrl] refer to the network url og the image, 'do not use asset path',
/// It is 'required'.
/// [color] refer to the image background color, It is 'required'.
class StoryImage extends StatelessWidget {
  final String _imageUrl;
  final Color _color;
  StoryImage({@required imageUrl, @required color})
      : _imageUrl = imageUrl,
        _color = color;

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.only(left: 24, top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(storyBorderRadius),
            color: _color,
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(1, 0))
            ]),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(storyBorderRadius),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 5, offset: Offset(-1, 0))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(storyBorderRadius)),
            child: Row(
              children: [
                Expanded(
                  child: Image.network(
                    _imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return SizedBox(
                        width: 100,
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
