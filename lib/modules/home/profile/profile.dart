import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:excursion/utils/constants/text_strings.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_auth.currentUser == null) {
      return;
    }
    String userId = _auth.currentUser!.uid;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      setState(() {
        _usernameController.text = userDoc['username'];
        _emailController.text = userDoc['email'];
        _dobController.text = userDoc['dob'];
        _profileImageUrl = userDoc['profileImageUrl'];
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadData() async {
    if (_auth.currentUser == null) {
      return;
    }
    String userId = _auth.currentUser!.uid;

    String? imageUrl;
    if (_imageFile != null) {
      Reference storageRef = FirebaseStorage.instance.ref().child('profile_images').child('$userId.jpg');
      UploadTask uploadTask = storageRef.putFile(_imageFile!);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
    } else {
      imageUrl = _profileImageUrl;
    }

    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'username': _usernameController.text,
      'email': _emailController.text,
      'dob': _dobController.text,
      'profileImageUrl': imageUrl ?? '',
    });

    setState(() {
      _profileImageUrl = imageUrl;
    });
  }

  void _logout() async {
    await _auth.signOut();
    // Navegar a la pantalla de inicio de sesión
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppText.profileTitle1}'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: (_imageFile != null
                  ? FileImage(_imageFile!) as ImageProvider<Object>?
                  : (_profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!) as ImageProvider<Object>?
                      : AssetImage('assets/images/default_avatar.png'))),
              child: _imageFile == null && _profileImageUrl == null
                  ? Icon(Icons.add_a_photo)
                  : null,
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: '${AppText.username}'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: '${AppText.email}'),
            ),
            TextField(
              controller: _dobController,
              decoration: InputDecoration(labelText: '${AppText.dob}'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadData,
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
