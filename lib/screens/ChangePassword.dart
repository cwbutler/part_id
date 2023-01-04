import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:part_id/components/Button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:part_id/components/Dialog.dart';
import 'package:part_id/components/FormInput.dart';
import 'package:part_id/models/app.dart';
import 'package:part_id/screens/Home.dart';

class PartIDChangePassword extends HookConsumerWidget {
  const PartIDChangePassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final oldPassword = useTextEditingController();
    final newPassword = useTextEditingController();
    final isDirty = useState(true);

    void navigateToHome() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PartIDHome()),
        (route) => false,
      );
      return;
    }

    void onPress() async {
      final result = await AppUtils.confirmNewPassword(newPassword.text);
      if (result != null && result.isSignedIn) {
        navigateToHome();
      }
    }

    bool validate() {
      if (formKey.currentState != null) {
        isDirty.value = !formKey.currentState!.validate();
      }
      safePrint(isDirty.value);
      return true;
    }

    oldPassword.addListener(() => validate());
    newPassword.addListener(() => validate());

    return PartIDDialog(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 77, top: 40),
              child: const Text(
                "Change Password",
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
                label: "Password",
                controller: oldPassword,
                obscureText: true,
                validator: (value) {
                  if (value != null && value.length <= 7) {
                    return "New password must be 8+ characters";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: PartIDFormInput(
                label: "Confirm Password",
                controller: newPassword,
                obscureText: true,
                validator: (value) {
                  if (value != null && value != oldPassword.text) {
                    return "Password must match.";
                  }
                  return null;
                },
              ),
            ),
            const Spacer(),
            PartIDButton(
              onPressed: (!isDirty.value) ? onPress : null,
              child: const Text("Change Password"),
            )
          ],
        ),
      ),
    );
  }
}
