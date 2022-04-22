import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final bool isAdmin;
  final Timestamp timeCreated;

  UserModel({
    required this.id,
    required this.email,
    required this.isAdmin,
    required this.timeCreated,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      email: doc['email'],
      isAdmin: doc['isAdmin'],
      timeCreated: doc['timeCreated'],
    );
  }

  @override
  String toString() {
    return 'User(UserID: $id, email: $email, isAdmin: $isAdmin, Time Created: $timeCreated)';
  }
}
