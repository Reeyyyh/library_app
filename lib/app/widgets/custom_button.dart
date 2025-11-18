import 'package:flutter/material.dart';
import 'package:library_app/app/constants/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppTheme.primaryColor,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 10,
    this.fontSize = 16.0,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 5,
        textStyle: TextStyle(fontSize: fontSize),
      ),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : Text(
              text,
              style: AppTheme.heading3.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
