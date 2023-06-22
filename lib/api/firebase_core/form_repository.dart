import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/personality_form.dart';

///  The [PersonalityFormRepository] class provides methods for managing personality form documents in Firestore.
class PersonalityFormRepository {
  final CollectionReference personalityFormCollection =
      FirebaseFirestore.instance.collection('personalityForm');

  /// Uploads a personality form to Firestore.
  ///
  /// The [form] parameter represents the personality form object to be uploaded.
  ///
  /// Throws an error if the upload fails.
  Future<void> uploadForm(PersonalityForm form) async {
    try {
      final formCollection =
          FirebaseFirestore.instance.collection('personalityForm');
      final newPersonalityFormDocRef = formCollection.doc(form.id);
      await newPersonalityFormDocRef.set({
        'id': form.id,
        'name': form.name,
        'hasPets': form.hasPets,
        'coexistingPersonality': form.coexistingPersonality,
        'budget': form.budget,
        'houseType': form.houseType,
        'changeFrequency': form.changeFrequency,
        'timeAvailability': form.timeAvailability,
        'activityLevel': form.activityLevel,
      });
    } catch (e) {
      print('Error creating personality form in Firestore: $e');
    }
  }
}
