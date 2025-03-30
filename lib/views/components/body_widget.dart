import 'package:flutter/material.dart';
import 'package:flutter_template/common/dimensions.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    required this.child,
    super.key,
    this.padding,
    this.formKey,
    this.isLoading = false,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final GlobalKey<FormState>? formKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: Padding(
          padding: padding ?? horizontalPadding16 + topPadding24,
          child: Stack(
            children: [
              if (isLoading)
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
              IgnorePointer(ignoring: isLoading, child: child),
            ],
          ),
        ),
      ),
    );
  }
}
