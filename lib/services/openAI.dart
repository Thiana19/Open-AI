import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _infoCollection = FirebaseFirestore.instance.collection('personal_info');

  Future<String?> fetchAnswerFromFirestore(String question) async {
    try {
      QuerySnapshot querySnapshot = await _infoCollection.where('question', isEqualTo: question).get();

      if (querySnapshot.docs.isNotEmpty) {
        var docData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        if (docData['answer'] != null) {
          return docData['answer'] as String;
        }
      }
      
      return null;
    } catch (e) {
      print('Error fetching answer from Firestore: $e');
      return null;
    }
  }
}
