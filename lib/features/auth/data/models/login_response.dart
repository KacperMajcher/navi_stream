class LoginResponse {
  LoginResponse(
    this.token,
    this.ouid,
    this.userId,
  );
  final String token;
  final String ouid;
  final String userId;
}
