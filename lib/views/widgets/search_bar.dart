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
      child: TextField(
        decoration: _inputDecoration(context),
        controller: _search,
        onChanged: _onChanged,
        onSubmitted: _onSubmitted,
      ),
    );
  }

  _inputDecoration(BuildContext context) => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        focusColor: Theme.of(context).colorScheme.secondary,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 32, right: 24),
          child: Icon(Icons.search),
        ),
        hintText: _hintText,
      );
}
