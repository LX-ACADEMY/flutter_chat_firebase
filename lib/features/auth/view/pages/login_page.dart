import 'package:chat_app/features/auth/view/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  static const routePath = '/login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// callback to execute when the signup link clicked
    void onSignupLinkClicked() {
      context.go(SignupPage.routePath);
    }

    /// Callback to execute when the login button clicked
    void onLoginButtonClicked() {}

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login'),
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
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: onLoginButtonClicked,
                child: const Text('Login'),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: onSignupLinkClicked,
                    child: const Text('Sign up'),
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
