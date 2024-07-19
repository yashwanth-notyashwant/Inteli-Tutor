class AuthUser {
  String name;
  String age;
  String language;
  String milestone;

  AuthUser({
    required this.name,
    required this.age,
    required this.language,
    required this.milestone,
  });

  // Method to create an instance from a map (deserialization)
  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      language: map['language'] ?? '',
      milestone: map['milestone'] ?? '',
    );
  }

  // Method to convert an instance to a map (serialization)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'language': language,
      'milestone': milestone,
    };
  }
}
