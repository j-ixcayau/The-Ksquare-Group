class User {
  const User({
    required this.name,
    required this.userName,
    required this.email,
  });

  final String name;
  final String userName;
  final String email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      userName: json['username'],
      email: json['email'],
    );
  }
}
