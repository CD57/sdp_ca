import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final Timestamp timeCreated;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.timeCreated,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      email: doc['email'],
      name: doc['name'],
      timeCreated: doc['timeCreated'],
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, timeCreated: $timeCreated)';
  }
}
