enum UserRole { user, counselor, admin, unknown }

enum AccountStatus { approved, pending, rejected}

class UserModel {
  final String uid;
  final String name;
  final String email;
  final UserRole role;
  final DateTime createdAt;
  final AccountStatus accountStatus;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.accountStatus
  });

  static UserRole _firebaseToRole(String role) {
    switch (role) {
      case 'user':
        return UserRole.user;
      case 'counselor':
        return UserRole.counselor;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.unknown;
    }
  }

  static AccountStatus _firebaseToStatus(String status){
    switch (status) {
      case 'approved':
        return AccountStatus.approved;
      case 'pending':
        return AccountStatus.pending;
      default:
        return AccountStatus.rejected;
    }
  }

  // Create Model from Firebase
  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    final parsedRole = _firebaseToRole(data['role'] ?? '');

    // Used when null in Firebase
    String fallbackStatus = 'pending';

    // Approved to User and Admin by Default
    if(parsedRole == UserRole.user || parsedRole == UserRole.admin){
      fallbackStatus = 'approved';
    }

    return UserModel(
      uid: uid,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: parsedRole,
      createdAt: (data['createdAt'] as dynamic).toDate() ?? DateTime.now(),
      accountStatus: _firebaseToStatus(data['accountStatus'] ?? fallbackStatus)
    );
  }

  // Converts User Model into a Map for Writing to Firestore
  Map<String,dynamic> toMap(){
    return{
      'uid' : uid,
      'name' : name,
      'email': email,
      'role': role.name,
      'createdAt' : createdAt,
      'accountStatus' : accountStatus.name
    };
  }
}
