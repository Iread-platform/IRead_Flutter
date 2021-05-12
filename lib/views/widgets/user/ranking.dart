import 'package:flutter/material.dart';

class Ranking extends StatelessWidget {
  final String _name;
  final double _progress;
  final int _rank;

  Ranking({@required name, @required progress, @required rank})
      : _name = name,
        _progress = progress,
        _rank = rank;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
