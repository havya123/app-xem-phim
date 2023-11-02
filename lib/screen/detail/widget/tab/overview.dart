import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';

class OverViewTab extends StatelessWidget {
  OverViewTab({required this.overView, super.key});
  String overView;
  @override
  Widget build(BuildContext context) {
    return Text(
      overView,
      style: ThemeApp.themeApp.textTheme.titleMedium,
    );
  }
}
