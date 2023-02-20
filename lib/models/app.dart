import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:part_id/models/AirtableProduct.dart';
import '../amplifyconfiguration.dart';

class AppUtils {
  static Future<XFile?> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
      );
      return image;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<void> configureAmplify() async {
    if (Amplify.isConfigured) return;
    // Add Amplify plugins
    final authPlugin = AmplifyAuthCognito();
    final storagePlugin = AmplifyStorageS3();
    final api = AmplifyAPI();
    await Amplify.addPlugins([authPlugin, storagePlugin, api]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      debugPrint(
        "Tried to reconfigure Amplify; this can occur when your app restarts on Android.",
      );
    }
  }

  static Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  static Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }

  static Future<SignInResult?> signInUser(
    String username,
    String password,
  ) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      return result;
    } on AuthException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }

  static Future<SignInResult?> confirmNewPassword(String password) async {
    try {
      return await Amplify.Auth.confirmSignIn(confirmationValue: password);
    } on AmplifyException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }

  static Future<void> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      debugPrint(e.message);
    }
  }

  static StreamSubscription<HubEvent> subscribeToAuthEvents() {
    StreamSubscription<HubEvent> hubSubscription =
        Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      switch (hubEvent.eventName) {
        case 'SIGNED_IN':
          debugPrint('USER IS SIGNED IN');
          break;
        case 'SIGNED_OUT':
          debugPrint('USER IS SIGNED OUT');
          break;
        case 'SESSION_EXPIRED':
          debugPrint('SESSION HAS EXPIRED');
          break;
        case 'USER_DELETED':
          debugPrint('USER HAS BEEN DELETED');
          break;
      }
    });
    return hubSubscription;
  }

  static Future<List<AuthUserAttribute>?> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      return result;
    } on AuthException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }

  static Future<String?> uploadFileToS3({
    required File file,
    required String key,
    S3UploadFileOptions? options,
  }) async {
    // Upload the file to S3
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: file,
          key: key,
          options: options,
          onProgress: (progress) {
            debugPrint(
              'Fraction of file upload completed: ${progress.getFractionCompleted()}',
            );
          });
      debugPrint('Successfully uploaded file: ${result.key}');
      return "public/${result.key}";
    } on StorageException catch (e) {
      debugPrint('Error uploading file: $e');
    }
    return null;
  }

  static Future<PartIDAirtableProduct?> analyzeImage(String imageKey) async {
    try {
      final options = RestOptions(
        path: '/analyzeImage',
        queryParameters: {"image": imageKey},
        apiName: "PartIDAPI",
      );
      final restOperation = Amplify.API.get(restOptions: options);
      final response = await restOperation.response;
      debugPrint('GET call succeeded: ${response.body}');
      if (response.body != "null") {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return PartIDAirtableProduct.fromMap(data);
      } else {
        return null;
      }
    } on ApiException catch (e) {
      debugPrint('GET call failed: $e');
    }
    return null;
  }
}
