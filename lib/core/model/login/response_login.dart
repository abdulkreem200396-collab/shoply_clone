class ResponseLogin {
  const ResponseLogin({
    required this.uid,
    required this.email,
    required this.isEmailVerified,
  });

  final String uid;
  final String email;
  final bool isEmailVerified;
}
