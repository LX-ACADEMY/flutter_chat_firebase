import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:chat_app/features/auth/view/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupPage extends HookConsumerWidget {
  static const routePath = '/signup';

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final formKey = useMemoized(() => GlobalKey<FormState>());

    /// callback to execute when the login link clicked
    void onLoginLinkClicked() {
      context.go(LoginPage.routePath);
    }

    /// Callback to execute when the signup button clicked
    void onSignupButtonClicked() {
      if (formKey.currentState!.validate()) {
        ref.read(authControllerProvider.notifier).signup(
              emailController.text,
              passwordController.text,
            );
      }
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Signup'),
                const SizedBox(height: 20),
                TextFormField(
                  validator:
                      ref.read(authControllerProvider.notifier).validateEmail,
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextFormField(
                  validator: ref
                      .read(authControllerProvider.notifier)
                      .validatePassword,
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                TextFormField(
                  validator: (value) => ref
                      .read(authControllerProvider.notifier)
                      .validateConfirmPassword(
                        passwordController.text,
                        value,
                      ),
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onSignupButtonClicked,
                  child: const Text('Signup'),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: onLoginLinkClicked,
                      child: const Text('Login'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
