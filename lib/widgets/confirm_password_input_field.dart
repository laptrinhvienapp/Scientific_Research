import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:project/cubits/cubits.dart';

class ConfirmPasswordInputField extends StatelessWidget {
  const ConfirmPasswordInputField({
    super.key,
    required this.controller,
    required this.validator,
  });

  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmPasswordCubit, bool>(
      builder: (_, isConfirmPasswordHidden) {
        final confirmPasswordCubit = context.read<ConfirmPasswordCubit>();

        return TextFormField(
          controller: controller,
          obscureText: isConfirmPasswordHidden,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: AppStrings.confirmPasswordHint,
            prefixIcon: const Icon(Icons.password),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide.none,
            ),
            hintStyle: TextStyle(
              color: Colors.black,
            ),
            contentPadding: AppSpacings.allSmall,
            suffixIcon: IconButton(
              onPressed: () => confirmPasswordCubit.toggleConfirmPasswordVisibility(),
              icon: Icon(
                isConfirmPasswordHidden
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
          ),
          validator: validator,
        );
      },
    );
  }
}