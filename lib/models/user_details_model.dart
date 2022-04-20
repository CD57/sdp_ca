import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp_ca/models/user_model.dart';

class UserDetails extends UserModel {
  UserDetails(
      this.shippingAddress, this.paymentMethod, this.phoneNumber, this.isAdmin,
      {required String id,
      required String name,
      required String email,
      required Timestamp timeCreated})
      : super(id: id, name: name, email: email, timeCreated: timeCreated);

  final String shippingAddress;
  final String paymentMethod;
  final String phoneNumber;
  final bool isAdmin;
}
