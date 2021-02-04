import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextField extends StatelessWidget {
  final String title;
  final bool bold;
  final String hint;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final int maxLenght;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;

  const CardTextField(
      {this.title,
      this.bold = false,
      this.hint,
      this.textInputType,
      this.inputFormatters,
      this.validator,
      this.maxLenght,
      this.textAlign = TextAlign.start,
      this.focusNode,
      this.onSubmitted,}) : textInputAction = onSubmitted == null ? TextInputAction.done : TextInputAction.next;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        initialValue: "",
        validator: validator,
        builder: (state) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      if (state.hasError)
                        Text(
                          "   Invalido",
                          style: TextStyle(color: Colors.red, fontSize: 9),
                        )
                    ],
                  ),
                TextFormField(
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: bold ? FontWeight.bold : FontWeight.w500),
                  decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(color: Colors.white.withAlpha(100)),
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 2),
                      counterText: ""),
                  keyboardType: textInputType,
                  inputFormatters: inputFormatters,
                  onChanged: (text) {
                    state.didChange(text);
                  },
                  maxLength: maxLenght,
                  textAlign: textAlign,
                  cursorColor: Colors.white,
                  focusNode: focusNode,
                  onFieldSubmitted: onSubmitted,
                  textInputAction: textInputAction,
                ),
              ],
            ),
          );
        });
  }
}
