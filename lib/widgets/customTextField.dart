import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final TextEditingController controller;
  final bool obscureText;
  final bool isObscureText;

  const CustomTextField({
    this.label,
    required this.controller,
    required this.obscureText,
    required this.isObscureText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late bool _isObscureText;
  final Color colorPrincipal = Colors.deepPurple;

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
          child: TextField(
            obscureText: _obscureText,
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: widget.label!,
              isDense: true,
              suffixIcon: Visibility(
                visible: _isObscureText,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: colorPrincipal),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[400]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: colorPrincipal,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
