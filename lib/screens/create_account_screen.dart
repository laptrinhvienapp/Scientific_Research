import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project/config/config.dart';
import 'package:project/cubits/cubits.dart';
import 'package:project/services/firebase_services.dart';
import 'package:project/utils/utils.dart';
import 'package:project/widgets/widgets.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKeyCreateAccount = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.createAccountButtonText,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: const WelcomeBackButton(),
      ),
      body: SafeArea(
        child: BlocBuilder<LoadingAnimationCubit, bool>(
          builder: (_, isLoading) {
            final loadingCubit = context.read<LoadingAnimationCubit>();

            return LoadingAnimation(
              isLoading: isLoading,
              child: Padding(
                padding: AppSpacings.allMedium,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Logo(),
                            AppSpacings.heightSmall,
                            LogoText(
                              firstText: AppStrings.chatText,
                              secondText: AppStrings.naemText,
                            ),
                            AppSpacings.heightExtraLarge,
                            Form(
                              key: _formKeyCreateAccount,
                              child: Column(
                                children: [
                                  BlocProvider(
                                    create: (_) => UserNameClearTextCubit(),
                                    child: UserNameInputField(
                                      controller: _userNameController,
                                    ),
                                  ),
                                  AppSpacings.heightMedium,
                                  BlocProvider(
                                    create: (_) => EmailClearTextCubit(),
                                    child: EmailInputField(
                                      controller: _emailController,
                                    ),
                                  ),
                                  AppSpacings.heightMedium,
                                  BlocProvider(
                                    create: (_) => PasswordCubit(),
                                    child: PasswordInputField(
                                      controller: _passwordController,
                                    ),
                                  ),
                                  AppSpacings.heightMedium,
                                  BlocProvider(
                                    create: (_) => ConfirmPasswordCubit(),
                                    child: ConfirmPasswordInputField(
                                      controller: _confirmPasswordController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.validatorConfirmPasswordEmpty;
                                        } else if (value != _passwordController.text) {
                                          return AppStrings.validatorConfirmPasswordMismatch;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppSpacings.heightExtraLarge,
                            CreateAccountButton(
                              text: AppStrings.createAccountButtonText,
                              onPressed: () async {
                                // Lưu context trước khi thực hiện bất kỳ thao tác async nào
                                final localContext = context;

                                final isValid = _formKeyCreateAccount.currentState?.validate();
                                if (isValid != true) return;
                                loadingCubit.showLoading();

                                final bool result = await FirebaseServices.createAccount(
                                  userName: _userNameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );

                                if (result) {
                                  if (localContext.mounted) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      title: AppStrings.registrationCompleted,
                                      text: AppStrings.logInNow,
                                      onConfirmBtnTap: () => context.push(RoutesLocation.loginScreen),
                                    );
                                  }
                                } else {
                                  if (localContext.mounted) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: AppStrings.error,
                                      text: AppStrings.somethingWentWrong,
                                    );
                                  }
                                }
                                loadingCubit.hideLoading();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    TermsAndConditions(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}