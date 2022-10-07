import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../services/local_storage_user.dart';
import '../services/firestore_user.dart';
import '../../model/user_model.dart';
import '../../config/control_view.dart';

class AuthViewModel extends GetxController {
  String? email, password, name;

  final Rxn<User> _user = Rxn<User>();

  String? get user => _user.value?.email;

  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  void signUpWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((user) {
        saveUser(user);
      });
      Get.offAll(const ControlView());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Login falhou.',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signInWithEmailAndPassword() async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((user) {
        FirestoreUser().getUserFromFirestore(user.user!.uid).then((doc) {
          saveUserLocal(
              UserModel.fromJson(doc.data() as Map<dynamic, dynamic>));
        });
      });
      Get.offAll(const ControlView());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Login falhou.',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signInWithGoogleAccount() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      await _auth.signInWithCredential(googleAuthCredential).then((user) {
        saveUser(user);
      });
      Get.offAll(const ControlView());
    } catch (error) {
      String errorMessage =
          error.toString().substring(error.toString().indexOf(' ') + 1);
      Get.snackbar(
        'Login falhou.',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signInWithFacebookAccount() async {
    try {
      final facebookSignIn = await FacebookAuth.instance.login();

      final facebookAuthCredential =
          FacebookAuthProvider.credential(facebookSignIn.accessToken!.token);

      await _auth.signInWithCredential(facebookAuthCredential).then((user) {
        saveUser(user);
      });
      Get.offAll(const ControlView());
    } catch (error) {
      Get.snackbar(
        'Login falhou.',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      LocalStorageUser.clearUserData();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  void saveUser(UserCredential userCredential) async {
    UserModel userModel = UserModel(
      userId: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: name == null ? userCredential.user!.displayName! : name!,
      pic: userCredential.user!.photoURL == null
          ? 'default'
          : "${userCredential.user!.photoURL!}?width=400",
    );
    FirestoreUser().addUserToFirestore(userModel);
    saveUserLocal(userModel);
  }

  void saveUserLocal(UserModel userModel) async {
    LocalStorageUser.setUserData(userModel);
  }
}
