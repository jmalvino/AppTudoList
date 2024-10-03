import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final bool isObscureText;
  final Color textFieldColor;
  final Color colorPrincipal;
  final Color? colorHint;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType; // Parâmetro para keyboardType
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.hintText,
    required this.controller,
    required this.obscureText,
    required this.isObscureText,
    required this.colorPrincipal,
    required this.textFieldColor,
    this.colorHint,
    this.focusNode,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });

  bool get isTextObscured => obscureText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late bool _isObscureText;

  @override
  void initState() {
    // TODO: implement initState
    _obscureText = widget.obscureText;
    _isObscureText = widget.isObscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: TextStyle(
              color: widget.textFieldColor,
            ),
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters ?? [],
            obscureText: _obscureText,
            controller: widget.controller,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: widget.colorHint),
              hintText: widget.hintText,
              isDense: true,
              suffixIcon: Visibility(
                visible: _isObscureText,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: widget.colorPrincipal),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: widget.colorPrincipal,
                  width: 2,
                ),
              ),
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
