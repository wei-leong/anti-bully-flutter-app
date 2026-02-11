enum UserRole { student, counselor, admin, unknown }

class UserModel {
  final String uid;
  final String name;
  final String email;
  final UserRole role;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  static UserRole _firebaseToRole(String role) {
    switch (role) {
      case 'student':
        return UserRole.student;
      case 'counselor':
        return UserRole.counselor;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.unknown;
    }
  }

  // Create Model from Firebase
  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data['name'] ?? '',
      email: data['name'] ?? '',
      role: _firebaseToRole(data['role'] ?? ''),
      createdAt: (data['createdAt'] as dynamic).toDate() ?? DateTime.now(),
    );
  }

  // Converts User Model into a Map for Writing to Firestore
  Map<String,dynamic> toMap(){
    return{
      'uid' : uid,
      'name' : name,
      'email': email,
      'role': role.name,
      'createdAt' : createdAt
    };
  }
}
