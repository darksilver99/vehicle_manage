import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCNKVL1h7JGEagEtGOaPfW2PJtwpqxhhcE",
            authDomain: "vehicle-manage-pbquak.firebaseapp.com",
            projectId: "vehicle-manage-pbquak",
            storageBucket: "vehicle-manage-pbquak.appspot.com",
            messagingSenderId: "1016114810673",
            appId: "1:1016114810673:web:bece05855e90ba970a6a10"));
  } else {
    await Firebase.initializeApp();
  }
}
