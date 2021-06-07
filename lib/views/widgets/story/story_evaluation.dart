import 'package:flutter/material.dart';

class StoryEvaluation extends StatelessWidget {
  final String _evaluationHeader = 'Evaluation';

  const StoryEvaluation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            _evaluationHeader,
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }
}
