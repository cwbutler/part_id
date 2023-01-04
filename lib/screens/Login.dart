import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:part_id/components/Button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:email_validator/email_validator.dart';
import 'package:part_id/components/Dialog.dart';
import 'package:part_id/components/FormInput.dart';
import 'package:part_id/models/app.dart';
import 'package:part_id/screens/ChangePassword.dart';
import 'package:part_id/screens/Home.dart';

class PartIDLogin extends HookConsumerWidget {
  const PartIDLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isDirty = useState(true);
    final showPassword = useState(false);

    void navigateToConfirm() {
      showDialog(
        context: context,
        builder: (context) => const PartIDChangePassword(),
      );
      return;
    }

    void navigateToHome() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PartIDHome()),
        (route) => false,
      );
      return;
    }

    bool validate() {
      if (formKey.currentState != null) {
        isDirty.value = !formKey.currentState!.validate();
      }
      return true;
    }

    void login() async {
      if (validate()) {
        final result = await AppUtils.signInUser(
          emailController.text,
          passwordController.text,
        );
        if (result?.nextStep?.signInStep ==
            "CONFIRM_SIGN_IN_WITH_NEW_PASSWORD") {
          return navigateToConfirm();
        }
        navigateToHome();
      }
    }

    return PartIDDialog(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 77, top: 40),
              child: const Text(
                "Log in to your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: PartIDFormInput(
                label: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null &&
                      (value.isEmpty || !EmailValidator.validate(value))) {
                    return "Please enter valid email";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: PartIDFormInput(
                label: "Password",
                controller: passwordController,
                obscureText: !showPassword.value,
                validator: (value) {
                  if (value != null && value.length < 8) {
                    return "Password must be greater than 8 characters";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const Spacer(),
            PartIDButton(
              onPressed: login,
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    );
  }
}
