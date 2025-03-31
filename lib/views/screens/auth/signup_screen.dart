import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/dimensions.dart';
import 'package:flutter_template/common/extensions.dart';
import 'package:flutter_template/routes/router.dart';
import 'package:flutter_template/views/components/body_widget.dart';
import 'package:flutter_template/views/components/buttons.dart';
import 'package:flutter_template/views/screens/auth/cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class MySignupScreen extends StatefulWidget {
  const MySignupScreen({super.key});

  @override
  State<MySignupScreen> createState() => _MySignupScreenState();
}

class _MySignupScreenState extends State<MySignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
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
        return Scaffold(
          appBar: AppBar(title: Text(context.lang.signup)),
          body: BodyWidget(
            formKey: _formKey,
            isLoading: state.status == AuthStatus.loading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name'),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.lang.emailValidatorText;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                    suffixIcon: Icon(Icons.person),
                  ),
                ),
                verticalMargin16,
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
                const Spacer(),
                CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final name = _nameController.text;
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      context.read<AuthCubit>().signup(
                        name: name,
                        email: email,
                        password: password,
                      );
                    }
                  },
                  label: context.lang.signup,
                ),
                verticalMargin20,
                Align(
                  alignment: AlignmentDirectional.center,
                  child: RichText(
                    text: TextSpan(
                      text: '${context.lang.alreadyHaveAccount} ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      children: [
                        TextSpan(
                          text: context.lang.loginHere,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () => context.pop(),
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
    );
  }
}
