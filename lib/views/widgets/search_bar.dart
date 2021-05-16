import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _search = TextEditingController();

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
        BoxShadow(blurRadius: 5, offset: Offset(0, 1), color: Colors.black12)
      ], borderRadius: BorderRadius.circular(50)),
      child: TextField(
        decoration: _inputDecoration(context),
        controller: _search,
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
          child: Icon(Icons.search),
        ),
        hintText: _hintText,
      );

  _inputBorder(Color color, double width) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide:
            BorderSide(width: width ?? 0, color: color ?? Colors.transparent),
      );
}
