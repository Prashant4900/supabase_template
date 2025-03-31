import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/dimensions.dart';
import 'package:flutter_template/common/extensions.dart';
import 'package:flutter_template/routes/router.dart';
import 'package:flutter_template/views/components/body_widget.dart';
import 'package:flutter_template/views/screens/auth/cubit/auth_cubit.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                  const Text('Name'),
                  TextFormField(
                    controller: _controller..text = state.userModel?.name ?? '',
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (_controller.text.isEmpty) return;

                          final model = state.userModel?.copyWith(
                            name: _controller.text.trim(),
                          );
                          context.read<AuthCubit>().updateUser(model);
                        },
                        icon: const Icon(Icons.check),
                      ),
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
