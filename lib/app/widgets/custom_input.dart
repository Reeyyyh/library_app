import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/app/modules/config/custom_app_theme.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatefulWidget {
  final bool isPassword;
  final String labelText;
  final String? hintText;
  final TextEditingController controller;
  final String? errorMessage;
  final int? maxLines;
  final TextInputType keyboardType;
  final bool isNumber;
  final bool readonly;

  const CustomInput({
    super.key,
    this.isPassword = false,
    required this.labelText,
    required this.controller,
    this.hintText,
    this.errorMessage,
    this.maxLines,
    this.keyboardType = TextInputType.text,
    this.isNumber = false,
    this.readonly = false,
  });

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {}); // rebuild saat fokus berubah
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = widget.errorMessage ?? '';

    List<TextInputFormatter> inputFormatters = [];
    if (widget.isNumber) {
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LABEL
        Text(
          widget.labelText,
          style: TextStyle(
            color: errorMessage.isNotEmpty ? Colors.red : Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),

        // TEXT FIELD
        TextField(
  focusNode: _focusNode,
  controller: widget.controller,
  obscureText: widget.isPassword && _obscureText,
  maxLines: widget.isPassword ? 1 : widget.maxLines,
  enabled: !widget.readonly,
  keyboardType:
      widget.isNumber ? TextInputType.number : widget.keyboardType,
  inputFormatters: inputFormatters,
  decoration: InputDecoration(
    hintText: widget.hintText,
    fillColor: _focusNode.hasFocus
        ? Colors.white
        : Colors.grey.shade200, // background gelap saat blur
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: _focusNode.hasFocus
            ? CustomAppTheme.primaryColor
            : Colors.transparent, // hilangkan outline saat blur
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: _focusNode.hasFocus
            ? CustomAppTheme.primaryColor
            : Colors.transparent, // hilangkan outline saat blur
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: CustomAppTheme.primaryColor, // tampilkan warna fokus
        width: 2,
      ),
    ),
    suffixIcon: widget.isPassword
        ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            color: Colors.grey[700],
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
        : null,
  ),
),

        // ERROR MESSAGE
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
