import 'package:flutter/material.dart';
import 'package:library_app/app/constants/theme.dart'; 

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTheme.heading2.copyWith(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); 
}
