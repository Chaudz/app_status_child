import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isUserIdExists() async {FirebaseFirestore firestore = FirebaseFirestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? kidId = prefs.getString('kidId');
    print(kidId);
    if (kidId != null) {
      // Tạo một query để kiểm tra xem có bản ghi nào có id tương ứng hay không
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore
          .collection('Kids')
          .doc(kidId) // Assuming kidId is the document ID
          .get();
      // Nếu có bản ghi thì kidId đã tồn tại trong collection Kids
      return documentSnapshot.exists;
    } else {
      // Handle the case where kidId is null or empty (optional)
      return false;
    }

}