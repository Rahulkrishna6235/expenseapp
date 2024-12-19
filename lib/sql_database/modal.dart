class Company {
  int? id;
  int companyId;
  String companyName;
  String address;
  String mobile;
  String userName;
  String password;
  String error;

  Company({
    this.id,
    required this.companyId,
    required this.companyName,
    required this.address,
    required this.mobile,
    required this.userName,
    required this.password,
    this.error = '',
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'companyId': companyId,
      'companyName': companyName,
      'address': address,
      'mobile': mobile,
      'userName': userName,
      'password': password,
      'error': error,
    };
    return map;
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'],
      companyId: map['companyId'],
      companyName: map['companyName'],
      address: map['address'],
      mobile: map['mobile'],
      userName: map['userName'],
      password: map['password'],
      error: map['error'] ?? '',
    );
  }
}
