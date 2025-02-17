import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _uploadProfileImageToStorage(Uint8List? image) async{
    Reference ref = _storage.ref().child('profilePics').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();

    return downloadURL;
  }

  pickProfileImage(ImageSource source) async{
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source);

    if(file != null){
      return await file.readAsBytes();
    }else {
      print('No Image Selected');
    }
  }

  Future<String> signUpUser(String email, String fullName, String phoneNumber,
      String password, Uint8List? image) async {
    String res = 'some error occured';

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        // ignore: unused_local_variable
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String profileImageURL = await _uploadProfileImageToStorage(image);

        await _firestore.collection("buyers").doc(cred.user!.uid).set({
          'buyerid': cred.user!.uid,
          'email': email,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'address': '',
          'profileImage': profileImageURL,
        });

        res = 'success';
      } else {
        res = 'All fields must be filled.';
      }
    } catch (e) {}

    return res;
  }

  loginUsers(String email, String password) async {
    String res = 'Something went wrong';

    try {
      if(email.isNotEmpty && password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);

        res = 'success';
      }else{
        res = ' Something wrong';
      }
    } catch (e) {
      res = 'User or Password is not valid' ;  //e.toString();
    }

    return res;
  }
}
