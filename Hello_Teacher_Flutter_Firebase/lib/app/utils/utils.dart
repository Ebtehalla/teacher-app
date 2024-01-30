import 'package:firebase_database/firebase_database.dart';

class Utils {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  String generateRandomId() {
    // Use the `push()` method to generate a unique key
    return databaseReference.push().key!;
  }
}
