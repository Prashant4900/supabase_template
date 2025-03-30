import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/dimensions.dart';
import 'package:flutter_template/common/extensions.dart';
import 'package:flutter_template/views/components/body_widget.dart';
import 'package:flutter_template/views/components/buttons.dart';
import 'package:flutter_template/views/screens/auth/cubit/auth_cubit.dart';

class MyForgotScreen extends StatefulWidget {
  const MyForgotScreen({super.key});

  @override
  State<MyForgotScreen> createState() => _MyForgotScreenState();
}

class _MyForgotScreenState extends State<MyForgotScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(context.lang.forgotPasswordTitle)),
          body: SafeArea(
            child: BodyWidget(
              isLoading: state.status == AuthStatus.loading,
              formKey: _formKey,
              padding: horizontalPadding16 + topPadding24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.lang.forgotPasswordBodyText),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.lang.emailValidatorText;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: context.lang.emailHintText,
                      suffixIcon: const Icon(Icons.email),
                    ),
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().sendForgotPasswordEmail(
                          _emailController.text,
                        );
                      }
                    },
                    label: context.lang.resetPassword,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
