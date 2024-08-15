// // {
// //         "id": "29c0dcd5-671a-4103-beea-eda873a2c875",
// //         "order_items": [
// //           {
// //             "id": "5ffeaee0-8730-4f36-87e8-558ff2cf028f",
// //             "product_id": "5849c48c-84f2-4f9b-a0a8-145605e192f1",
// //             "order_id": "29c0dcd5-671a-4103-beea-eda873a2c875",
// //             "quantity": 2,
// //             "price": 100,
// //             "tenant_id": "50b6b75a-6e5e-4586-90f2-3c3e176ecf1b"
// //           },
// //           {
// //             "id": "13030b4f-bc89-413d-a9aa-8019afe06edb",
// //             "product_id": "f2fd29f1-fa9c-422f-be9b-787d5e2943f6",
// //             "order_id": "29c0dcd5-671a-4103-beea-eda873a2c875",
// //             "quantity": 10,
// //             "price": 200,
// //             "tenant_id": "50b6b75a-6e5e-4586-90f2-3c3e176ecf1b"
// //           }
// //         ],
// //         "customer_id": "6d13f917-8fd4-443d-a03e-f1f3e7f69ec4",
// //         "order_value": 0,
// //         "amount_received": 0,
// //         "status": "Unpaid",
// //         "tenant_id": "50b6b75a-6e5e-4586-90f2-3c3e176ecf1b",
// //         "created_by": "29928374-3496-4a30-a619-fc442faf7661",
// //         "updated_by": "29928374-3496-4a30-a619-fc442faf7661",
// //         "created_at": "2024-08-14T18:54:34.757301+00:00",
// //         "customer_details": {
// //           "id": "6d13f917-8fd4-443d-a03e-f1f3e7f69ec4",
// //           "name": "aman",
// //           "phone_number": "9730206858",
// //           "tenant_id": "50b6b75a-6e5e-4586-90f2-3c3e176ecf1b",
// //           "created_by": "29928374-3496-4a30-a619-fc442faf7661",
// //           "updated_by": "29928374-3496-4a30-a619-fc442faf7661"
// //         },
// //         "order_items_count": 2
// //       },

class ModelOrder {
  final String id;
  final double orderValue;
  final String status;
  final String customerName;
  final DateTime createdAt;
  final double balance;
  final int itemCount;

  ModelOrder({
    required this.id,
    required this.orderValue,
    required this.status,
    required this.customerName,
    required this.createdAt,
    required this.balance,
    required this.itemCount,
  });

  factory ModelOrder.fromJson(Map<String, dynamic> json) {
    return ModelOrder(
      id: json['id'],
      orderValue: json['order_value'],
      status: json['status'],
      customerName: json['customer_details']['name'],
      createdAt: DateTime.parse(json['created_at']),
      balance: json['order_value'] - json['amount_received'],
      itemCount: json['order_items_count'],
    );
  }
}
