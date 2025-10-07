class User {
  final String id;
  final String name;
  final String email;
  final String passwordHash;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'passwordHash': passwordHash,
      };

  factory User.fromMap(Map data) => User(
        id: data['id'] as String,
        name: data['name'] as String,
        email: data['email'] as String,
        passwordHash: data['passwordHash'] as String,
      );
}