class ModelProfile {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String tenantId;

  ModelProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.tenantId,
  });

  factory ModelProfile.fromJson(Map<String, dynamic> json) {
    return ModelProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      tenantId: json['tenant_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'tenant_id': tenantId,
    };
  }
}
