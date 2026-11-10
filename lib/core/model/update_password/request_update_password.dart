class RequestUpdatePassword {
  const RequestUpdatePassword({
    required this.currentPassword,
    required this.newPassword,
  });

  final String currentPassword;
  final String newPassword;
}
