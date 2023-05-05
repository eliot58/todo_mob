
class GetRegisterBody {
  final String fullName;
  final String email;
  final String phone;
  final String spec;

  GetRegisterBody({
    required this.email,
    required this.fullName,
    required this.phone,
    required this.spec,
  });

  Map<String, String> toApi() {
    return {
      'email': email,
      'fullName': fullName,
      'phoneNumber': phone,
      'spec': spec,
    };
  }
}