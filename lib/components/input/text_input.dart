import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? hint;
  final bool obscureText;
  final TextEditingController? textController;
  TextInput({super.key, this.validator, this.obscureText = false, this.hint, this.textController});

  @override
  State<StatefulWidget> createState() => _TextInputState();

}

class _TextInputState extends State<TextInput> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator ?? (value) => null,
      obscureText: widget.obscureText,
      controller: widget.textController,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: .none),
        hint: widget.hint == null
            ? null
            : Text(
                widget.hint!,
                textAlign: .center,
                style: TextStyle(color: ChiwiColors.SERENE_2, fontSize: 24),
              ),
        fillColor: ChiwiColors.SERENE_0,
        filled: true,
      ),
    );
  }
}
