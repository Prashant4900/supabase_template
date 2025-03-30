import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/dimensions.dart';
import 'package:flutter_template/common/extensions.dart';
import 'package:flutter_template/routes/router.dart';
import 'package:flutter_template/views/components/body_widget.dart';
import 'package:flutter_template/views/components/buttons.dart';
import 'package:flutter_template/views/screens/auth/cubit/auth_cubit.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.lang.login)),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.failure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message ?? '')));
          }

          if (state.status == AuthStatus.success) {
            const HomeRoute().go(context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: BodyWidget(
              formKey: _formKey,
              padding: horizontalPadding16 + topPadding24,
              isLoading: state.status == AuthStatus.loading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.lang.email),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.lang.emailValidatorText;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: context.lang.emailHintText,
                      suffixIcon: const Icon(Icons.email),
                    ),
                  ),
                  verticalMargin16,
                  Text(context.lang.password),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.lang.passwordValidatorText;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: context.lang.passwordHintText,
                      suffixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () => const ForgotRoute().push<void>(context),
                      child: Text(context.lang.forgotPassword),
                    ),
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        context.read<AuthCubit>().login(email, password);
                      }
                    },
                    label: context.lang.login,
                  ),
                  verticalMargin20,
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: RichText(
                      text: TextSpan(
                        text: '${context.lang.dontHaveAccount} ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        children: [
                          TextSpan(
                            text: context.lang.registerHere,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap =
                                      () => const SignupRoute().push<void>(
                                        context,
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
