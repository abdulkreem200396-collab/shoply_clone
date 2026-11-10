import 'dart:typed_data';

class RequestUpdateProfile {
  const RequestUpdateProfile({
    required this.fullName,
    required this.username,
    required this.address,
    this.photo,
  });

  final String fullName;
  final String username;
  final String address;
  final Uint8List? photo; // null = الصورة ما تغيّرت
}
