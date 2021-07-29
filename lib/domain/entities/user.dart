class User {
  User({
    this.sessionId,
    this.guestSessionId,
    this.expiresAt,
    this.requestToken,
  });

  String? sessionId;
  String? guestSessionId;
  String? expiresAt;
  String? requestToken;
}
