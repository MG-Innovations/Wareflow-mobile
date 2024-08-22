// class ModelCustomer {
//   String id;
//   String name;
//   String phoneNumber;
//   String tenantId;
//   String createdBy;
//   String updatedBy;

//   ModelCustomer({
//     required this.id,
//     required this.name,
//     required this.phoneNumber,
//     required this.tenantId,
//     required this.createdBy,
//     required this.updatedBy,
//   });

//   factory ModelCustomer.fromJson(Map<String, dynamic> json) {
//     return ModelCustomer(
//       id: json['id'] as String,
//       name: json['name'] as String,
//       phoneNumber: json['phone_number'] as String,
//       tenantId: json['tenant_id'] as String,
//       createdBy: json['created_by'] as String,
//       updatedBy: json['updated_by'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'phone_number': phoneNumber,
//       'tenant_id': tenantId,
//       'created_by': createdBy,
//       'updated_by': updatedBy,
//     };
//   }
// }

class ModelCustomer {
  String id;
  String name;
  String phoneNumber;
  String tenantId;
  String createdBy;
  String updatedBy;

  ModelCustomer({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.tenantId,
    required this.createdBy,
    required this.updatedBy,
  });

  factory ModelCustomer.fromJson(Map<String, dynamic> json) {
    return ModelCustomer(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      tenantId: json['tenant_id'] as String,
      createdBy: json['created_by'] as String,
      updatedBy: json['updated_by'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'tenant_id': tenantId,
      'created_by': createdBy,
      'updated_by': updatedBy,
    };
  }
}
