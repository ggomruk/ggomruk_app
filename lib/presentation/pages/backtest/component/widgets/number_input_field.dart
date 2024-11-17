import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputField extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final void Function(String)? onChanged;
  final bool allowDecimal;
  final TextInputType? keyboardType;
  final Widget? suffix;

  const NumberInputField({
    Key? key,
    required this.initialValue,
    required this.hintText,
    this.onChanged,
    this.allowDecimal = true,
    this.keyboardType,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType ?? TextInputType.numberWithOptions(decimal: allowDecimal),
      inputFormatters: [
        allowDecimal
            ? FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
            : FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        suffixIcon: suffix != null ? Padding(
          padding: const EdgeInsets.only(right: 16),
          child: suffix,
        ) : null,
      ),
      onChanged: onChanged,
    );
  }
}