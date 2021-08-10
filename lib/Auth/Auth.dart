import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Auth {
  static Future<bool> login() async {
    await Firebase.initializeApp();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    UserCredential userCredential = await firebaseAuth.signInAnonymously();
    User user = userCredential.user;
    print(user.isAnonymous.toString());
    if (user.isAnonymous == true) {
      return true;
    } else {
      return false;
    }
  }
}
