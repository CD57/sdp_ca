import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String uid;
  final String name;
  final String shippingAddress;
  final String paymentMethod;
  final String phoneNumber;

  UserDetails({
    required this.uid,
    required this.name,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.phoneNumber,
  });

  factory UserDetails.fromDocument(DocumentSnapshot doc) {
    return UserDetails(
      uid: doc['uid'],
      name: doc['name'],
      shippingAddress: doc['shippingAddress'],
      paymentMethod: doc['paymentMethod'],
      phoneNumber: doc['phoneNumber'],
    );
  }

  @override
  String toString() {
    return 'UserDetails(UserID: $uid name: $name, shippingAddress: $shippingAddress, paymentMethod: $paymentMethod, phoneNumber: $phoneNumber)';
  }
}
