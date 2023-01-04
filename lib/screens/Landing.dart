import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:part_id/models/app.dart';
import 'package:part_id/screens/Home.dart';
import 'package:part_id/screens/Welcome.dart';

class PartIDAppLanding extends HookConsumerWidget {
  const PartIDAppLanding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigateAway(Route route) {
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    }

    Future<StreamSubscription<HubEvent>> init() async {
      await AppUtils.configureAmplify();

      final isUserSignedIn = await AppUtils.isUserSignedIn();
      if (!isUserSignedIn) {
        navigateAway(
          MaterialPageRoute(builder: (context) => const PartIDWelcome()),
        );
      } else {
        navigateAway(
          MaterialPageRoute(builder: (context) => const PartIDHome()),
        );
      }

      StreamSubscription<HubEvent> hubSubscription =
          Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
        switch (hubEvent.eventName) {
          case 'SIGNED_IN':
            MaterialPageRoute(builder: (context) => const PartIDHome());
            break;
          case 'SIGNED_OUT':
            debugPrint('USER IS SIGNED OUT');
            navigateAway(
              MaterialPageRoute(builder: (context) => const PartIDWelcome()),
            );
            break;
          case 'SESSION_EXPIRED':
            debugPrint('SESSION HAS EXPIRED');
            AppUtils.signOutCurrentUser();
            break;
          case 'USER_DELETED':
            safePrint('USER HAS BEEN DELETED');
            break;
        }
      });

      return hubSubscription;
    }

    useEffect(() {
      init();
      return null;
    }, []);

    return const Center(child: CircularProgressIndicator());
  }
}
