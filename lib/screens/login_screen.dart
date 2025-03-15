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
import 'package:text_divider/text_divider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyLogin = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.loginButtonText,
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
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Logo(),
                          AppSpacings.heightSmall,
                          LogoText(
                            firstText: AppStrings.naemText,
                            secondText: AppStrings.chatText,
                          ),
                          AppSpacings.heightExtraLarge,
                          Form(
                            key: _formKeyLogin,
                            child: Column(
                              children: [
                                BlocProvider(
                                  create: (_) => UserNameClearTextCubit(),
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
                              ],
                            ),
                          ),
                          AppSpacings.heightExtraLarge,
                          LoginButton(
                            text: AppStrings.loginButtonText,
                            onPressed: () async {
                              // Lưu context trước khi thực hiện bất kỳ thao tác async nào
                              final localContext = context;

                              final isValid = _formKeyLogin.currentState?.validate();
                              if (isValid != true) return;
                              loadingCubit.showLoading();

                              final bool result = await FirebaseServices.login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              if (result) {
                                if (localContext.mounted) {
                                  context.go(RoutesLocation.contactsScreen);
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
                          AppSpacings.heightExtraLarge,
                          TextDivider.horizontal(
                            text: Text(
                              AppStrings.orText,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          AppSpacings.heightExtraLarge,
                          LoginMethods(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}