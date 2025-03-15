import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/cubits/cubits.dart';
import 'package:project/utils/utils.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailClearTextCubit, bool>(
      builder: (_, showClearIcon) {
        final clearTextCubit = context.read<EmailClearTextCubit>();

        return TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: AppStrings.emailInputHint,
            prefixIcon: const Icon(Icons.email),
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide.none,
            ),
            hintStyle: const TextStyle(color: Colors.black),
            contentPadding: AppSpacings.allSmall,
            suffixIcon: showClearIcon
                ? IconButton(
                    onPressed: () => clearTextCubit.clearText(controller),
                    icon: SvgPicture.asset(AppIcons.clearText),
                  )
                : null,
          ),
          onChanged: (text) => clearTextCubit.updateClearText(text),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.emailValidatorEmpty;
            } else if (!EmailValidator.validate(value)) {
              return AppStrings.emailValidatorInvalid;
            }
            return null;
          },
        );
      },
    );
  }
}
