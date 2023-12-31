import 'package:flutter/material.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController search = TextEditingController();

  final String _hintText;
  final Function(String value) _onChanged;
  final Function(String value) _onSubmitted;

  SearchBar({onChanged, hintText, onSubmitted})
      : _onChanged = onChanged,
        _onSubmitted = onSubmitted,
        _hintText = hintText ?? 'Story Name';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 5,
            offset: Offset(-4, 2),
            spreadRadius: -2,
            color: Theme.of(context).colorScheme.primary)
      ], borderRadius: BorderRadius.circular(50)),
      child: TextField(
        decoration: _inputDecoration(context),
        controller: search,
        onChanged: _onChanged,
        onSubmitted: _onSubmitted,
      ),
    );
  }

  _inputDecoration(BuildContext context) => InputDecoration(
        border: _inputBorder(Colors.transparent, 0),
        enabledBorder: _inputBorder(Colors.transparent, 0),
        focusedBorder: _inputBorder(Theme.of(context).colorScheme.primary, 0),
        errorBorder: _inputBorder(Colors.red, 0),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        focusColor: Theme.of(context).colorScheme.secondary,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 32, right: 24),
          child: Icon(
            IReadIcons.search,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        hintText: _hintText,
      );

  _inputBorder(Color color, double width) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide:
            BorderSide(width: width ?? 0, color: color ?? Colors.transparent),
      );
}
