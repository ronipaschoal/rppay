class UserEntity {
  final String name;
  final String agency;
  final String account;

  const UserEntity({
    required this.name,
    required this.agency,
    required this.account,
  });

  String get firstName => name.trim().split(RegExp(r'\s+')).first;
}
