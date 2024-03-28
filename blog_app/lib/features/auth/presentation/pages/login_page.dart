import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgest/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgest/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  static route() {
    return MaterialPageRoute(builder: (_) => const SignUpPage());
  }

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Log In.',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            AuthField(hintText: 'Email', controller: emailController),
            const SizedBox(height: 15),
            AuthField(
              hintText: 'Password',
              controller: passwordController,
              isObscureText: true,
            ),
            const SizedBox(height: 20),
            AuthGradientButton(
              title: 'Sign In',
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(context, LogInPage.route());
              },
              child: RichText(
                text: TextSpan(
                    text: 'Don\'t have an acccount? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                          text: 'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold))
                    ]),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
