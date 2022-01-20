import 'package:firebase_auth/firebase_auth.dart';

class authforState
{
    final FirebaseAuth fbAuthforstatecheck; 
    authforState(this.fbAuthforstatecheck);

 Stream<User?> get authstatechanges => fbAuthforstatecheck.authStateChanges();
 
} 