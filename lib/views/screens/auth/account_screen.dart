import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/dimensions.dart';
import 'package:flutter_template/common/extensions.dart';
import 'package:flutter_template/routes/router.dart';
import 'package:flutter_template/views/components/body_widget.dart';
import 'package:flutter_template/views/screens/auth/cubit/auth_cubit.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.initial) {
          const LgoinRoute().go(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.lang.accountDetails),
            actions: [
              IconButton(
                onPressed: () => context.read<AuthCubit>().logout(),
                icon: const Icon(Icons.logout_outlined, color: Colors.red),
              ),
            ],
          ),
          body: SafeArea(
            child: BodyWidget(
              isLoading: state.status == AuthStatus.loading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalMargin24,
                  Text(context.lang.email),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: context.lang.emailHintText,
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed:
                          () => context.read<AuthCubit>().deleteAccount(),
                      child: Text(
                        context.lang.deleteAccount,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
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
