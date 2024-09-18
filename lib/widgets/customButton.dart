import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onpress;
  final String nameButton;
  final Color colorTextButton;
  final Color colorButton;
  final String? imagePath;

  const CustomButton({
    Key? key,
    required this.colorTextButton,
    required this.colorButton,
    required this.onpress,
    required this.nameButton,
    this.imagePath,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  void initState() {
    // TODO: implement initState
    widget.nameButton ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.colorButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: widget.onpress,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.imagePath != null) ...[
                  SizedBox(
                    height: 25,
                    child: Image.asset(widget.imagePath!),
                  ),
                  const SizedBox(width: 10),
                ],
                Text(
                  widget.nameButton,
                  style: TextStyle(
                    color: widget.colorTextButton,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
