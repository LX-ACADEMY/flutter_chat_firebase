import 'package:chat_app/features/auth/view/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  static const routePath = '/signup';

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// callback to execute when the login link clicked
    void onLoginLinkClicked() {
      context.go(LoginPage.routePath);
    }

    /// Callback to execute when the signup button clicked
    void onSignupButtonClicked() {}

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Signup'),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
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
    );
  }
}
