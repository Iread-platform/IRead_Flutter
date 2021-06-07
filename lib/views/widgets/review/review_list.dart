import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _review(context, 'https://picsum.photos/200/300',
            'Pellentesque id eros nisi. Etiam gravida lacus a ipsum eleifend, sit amet scelerisque metus fermentum. Etiam eget turpis eget nibh finibus molestie. Quisque quam metus'),
        SizedBox(
          height: 12,
        ),
        _review(context, 'https://picsum.photos/200/300',
            'Pellentesque id eros nisi. Etiam gravida lacus a ipsum eleifend, sit amet scelerisque metus fermentum. Etiam eget turpis eget nibh finibus molestie. Quisque quam metus'),
        SizedBox(
          height: 12,
        ),
        _review(context, 'https://picsum.photos/200/300',
            'Pellentesque id eros nisi. Etiam gravida lacus a ipsum eleifend, sit amet scelerisque metus fermentum. Etiam eget turpis eget nibh finibus molestie. Quisque quam metus'),
      ],
    );
  }

  Widget _review(BuildContext context, String imageUrl, String description) =>
      Row(
        children: [
          Column(
            children: [
              UserAvatar(
                imageUrl: imageUrl,
                radius: 40.0,
              ),
              Text(
                'User',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              )
            ],
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          )
        ],
      );
}
