class AuthUser {
  final String fname;
  final String lname;
  final String email;

  const AuthUser({
    required this.fname,
    required this.lname,
    required this.email,
  });

  static AuthUser fromJson(Map<String, dynamic> user) {
    return AuthUser(
      fname: user["fname"],
      lname: user["lname"],
      email: user["email"],
    );
  }
}
