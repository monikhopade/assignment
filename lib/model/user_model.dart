class User {
  final int? id;
  final String firstName;
  final String lastName;
  final DateTime dob;
  final String mobileNumber;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.mobileNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': mobileNumber,
      'dob': dob.toString(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      mobileNumber: map['mobile_number'],
      dob: DateTime.parse(map['dob']),
    );
  }
}


