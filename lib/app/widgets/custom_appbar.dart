import 'package:flutter/material.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});
//widgets build(BuildContext context) {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomAppTheme.backgroundColor,
      title: Text(
        title,
        style: CustomAppTheme.heading2.copyWith(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
// merge