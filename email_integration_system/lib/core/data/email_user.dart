class UserEmailData {
  final String name;
  final String email;
  final List<String> recipientList;

  UserEmailData ({
    required this.email,
    required this.name,
    required this.recipientList
  });
  factory UserEmailData.fromMap(Map<String, dynamic> data){
    return UserEmailData(
      email: data['email'], 
      name: data['name'], 
      recipientList: List<String>.from(data['recipientList'])
      );
  }
}