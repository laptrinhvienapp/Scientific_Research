import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/utils/utils.dart';
import 'package:project/cubits/cubits.dart';

class UserNameInputField extends StatelessWidget {
  const UserNameInputField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserNameClearTextCubit, bool>(
      builder: (_, showClearIcon) {
        final clearTextCubit = context.read<UserNameClearTextCubit>();

        return TextFormField(
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: AppStrings.userNameInputHint,
            prefixIcon: const Icon(Icons.person),
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
              return AppStrings.userNameValidatorEmpty;
            }
            return null;
          },
        );
      },
    );
  }
}
