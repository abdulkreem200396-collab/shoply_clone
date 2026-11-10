import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class ResponseProfile {
  const ResponseProfile({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.username,
    required this.address,
    this.photo,
    this.isAdmin = false,
  });

  final String uid;
  final String email;
  final String fullName;
  final String username;
  final String address;
  final Uint8List? photo;
  final bool isAdmin;

  factory ResponseProfile.fromMap({
    required String uid,
    required String email,
    required Map<String, dynamic> data,
    bool isAdmin = false,
  }) {
    final photo = data['photo'];
    return ResponseProfile(
      uid: uid,
      email: email,
      fullName: data['fullName'] as String? ?? '',
      username: data['username'] as String? ?? '',
      address: data['address'] as String? ?? '',
      photo: photo is Blob ? photo.bytes : null,
      isAdmin: isAdmin,
    );
  }
}
