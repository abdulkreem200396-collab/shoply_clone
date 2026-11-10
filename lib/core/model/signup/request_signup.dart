import 'dart:typed_data';

class RequestSignup {
  const RequestSignup({
    required this.fullName,
    required this.username,
    required this.email,
    required this.address,
    required this.password,
    this.photo,
  });

  final String fullName;
  final String username;
  final String email;
  final String address;
  final String password;
  final Uint8List? photo;
}
