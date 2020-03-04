import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final String email;
  final String imageUrl;
  final String subscription;
  final String userId;
  final String userName;

  const UserDetails({
    this.email,
    this.imageUrl,
    this.subscription,
    this.userId,
    this.userName,
  });

  @override
  List<Object> get props => [email, imageUrl, subscription, userId, userName];

  Map<String, dynamic> toJson() => {
        'email': email,
        'imageUrl': imageUrl,
        'subscription': subscription,
        'userId': userId,
        'userName': userName
      };

  static UserDetails fromJson(dynamic json) {
    return UserDetails(
      email: json['email'],
      imageUrl: json['imageUrl'],
      subscription: json['subscription'],
      userId: json['userId'],
      userName: json['userName'],
    );
  }
}
