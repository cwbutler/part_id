import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:part_id/models/app.dart';

class PartIDSettingsDropdown extends HookConsumerWidget {
  const PartIDSettingsDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useState("");

    useEffect(() {
      AppUtils.fetchCurrentUserAttributes().then((value) {
        if (value != null) {
          email.value = value
              .firstWhere(
                  (element) => element.userAttributeKey.toString() == "email")
              .value;
          debugPrint(email.value);
        }
      });
      return null;
    }, []);

    return SizedBox(
      width: 207,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const CircleAvatar(radius: 16),
            ),
            Expanded(
              child: Text(email.value, overflow: TextOverflow.ellipsis),
            )
          ],
        ),
      ),
    );
  }
}
