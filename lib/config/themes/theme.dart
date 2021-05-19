import 'package:flutter/material.dart';

import 'package:iread_flutter/config/themes/colors.dart';
import 'package:iread_flutter/config/themes/textTheme.dart';

ThemeData mainTheme = ThemeData(
    primaryColor: colorScheme.primary,
    accentColor: colorScheme.secondary,
    primarySwatch: Colors.indigo,
    colorScheme: colorScheme,
    textTheme: textTheme);
