class ModelCustomer {
  final String id;
  final String name;
  final String phoneNumber;
  final String createdBy;
  final String updatedBy;

  ModelCustomer({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.createdBy,
    required this.updatedBy,
  });

  factory ModelCustomer.fromJson(Map<String, dynamic> json) {
    return ModelCustomer(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }
}
