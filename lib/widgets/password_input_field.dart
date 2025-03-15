import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubits/cubits.dart';
import 'package:project/utils/utils.dart';

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordCubit, bool>(
      builder: (_, isPasswordHidden) {
        final passwordCubit = context.read<PasswordCubit>();

        return TextFormField(
          controller: controller,
          obscureText: isPasswordHidden,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: AppStrings.passwordInputHint,
            prefixIcon: const Icon(Icons.lock),
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
              onPressed: () => passwordCubit.togglePasswordVisibility(),
              icon: Icon(
                isPasswordHidden ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.validatorPasswordEmpty;
            } else if (value.length < 6) {
              return AppStrings.validatorPasswordShort;
            }
            return null;
          },
        );
      },
    );
  }
}