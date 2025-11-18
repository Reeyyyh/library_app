import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/app/constants/theme.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatefulWidget {
  final bool isPassword;
  final String labelText;
  final TextEditingController controller;
  final String? errorMessage;
  final int? maxLines;
  final TextInputType keyboardType;
  final bool isNumber;
  final bool readonly;

  const CustomInput({
    Key? key,
    this.isPassword = false,
    required this.labelText,
    required this.controller,
    this.errorMessage,
    this.maxLines,
    this.keyboardType = TextInputType.text,
    this.isNumber = false,
    this.readonly = false,
  }) : super(key: key);

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = widget.errorMessage ?? '';

    List<TextInputFormatter> inputFormatters = [];
    if (widget.isNumber) {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(
            color: errorMessage.isNotEmpty ? Colors.red : Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscureText,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          enabled: !widget.readonly,
          keyboardType:
              widget.isNumber ? TextInputType.number : widget.keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: errorMessage.isNotEmpty ? Colors.red : Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: errorMessage.isNotEmpty ? Colors.red : Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: errorMessage.isNotEmpty
                    ? Colors.red
                    : AppTheme.primaryColor,
              ),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    color:
                        errorMessage.isNotEmpty ? Colors.red : Colors.grey[700],
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
        if (errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              '*$errorMessage',
              style: GoogleFonts.montserrat(
                color: Colors.red,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
