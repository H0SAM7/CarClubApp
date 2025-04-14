import 'package:flutter/material.dart';

class CustomTextFrom extends StatefulWidget {
  const CustomTextFrom({
    super.key,
    this.onChanged,
    required this.label,
    required this.hint,
    this.hide = false,
    this.validator,
    this.isPasswordField = false,
    this.controller,
  });
  final void Function(String)? onChanged;
  final String label, hint;
  final bool hide;
  final String? Function(String?)? validator;
  final bool isPasswordField;
  final TextEditingController? controller;
  @override
  State<CustomTextFrom> createState() => _CustomTextFromState();
}

class _CustomTextFromState extends State<CustomTextFrom> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'complete_fields';
              }
              return null;
            },
        onChanged: widget.onChanged,
        obscureText: widget.isPasswordField ? _isObscure : false,
        decoration: InputDecoration(
          label: Text(
            widget.label,
            // style: TextStyle(color: newColoR2),
          ),
          hintText: widget.hint,
          border: OutlineInputBorder(
            //   borderSide: BorderSide(color: newColoR2),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
          hintStyle: const TextStyle(
            //   color: Color.fromARGB(255, 154, 193, 193),
          ),
        ),
      ),
    );
  }
}

final outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(    color: Colors.blueAccent,),
  borderRadius: const BorderRadius.all(Radius.circular(8)),
);