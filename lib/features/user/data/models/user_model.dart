import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.agency,
    required super.account,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json['name'] as String,
    agency: json['agency'] as String,
    account: json['account'] as String,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'agency': agency,
    'account': account,
  };
}
