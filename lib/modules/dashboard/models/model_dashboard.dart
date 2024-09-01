import 'package:wareflow/modules/customers/model.dart';

import '../../../utils/helper_functions.dart';
import '../../orders/models/model_order.dart';

class ModelDashboard {
  final int totalOrders;
  final int totalCustomers;
  final int totalProducts;
  final int unpaidOrders;
  final double monthlyRevenue;
  final double receivedMoney;
  final double remainingMoney;
  final List<ModelOrder> recentOrders;

  const ModelDashboard(
      {required this.totalCustomers,
      required this.totalOrders,
      required this.totalProducts,
      required this.unpaidOrders,
      required this.monthlyRevenue,
      required this.receivedMoney,
      required this.remainingMoney,
      required this.recentOrders});

  factory ModelDashboard.fromJSON({required Map<String, dynamic> json}) {
    return ModelDashboard(
      totalCustomers: json['total_customers'] ?? 0,
      totalOrders: json['total_orders'] ?? 0,
      totalProducts: json['total_products'] ?? 0,
      unpaidOrders: json['unpaid_orders'] ?? 0,
      monthlyRevenue: (json['monthly_revenue'] ?? 0).toDouble(),
      receivedMoney: (json['received_money'] ?? 0).toDouble(),
      remainingMoney: (json['remaining_money'] ?? 0).toDouble(),
      recentOrders: (json['recent_orders'] as List<dynamic>?)
              ?.map((e) => ModelOrder(
                  id: e['id'],
                  orderValue: e['order_value'],
                  status: HFunctions.getPaymentStatus(e['status']),
                  createdAt: DateTime.parse(e['created_at']),
                  balance: e['order_value'] - e['amount_received'],
                  customer: ModelCustomer(
                    id: e['customer_id'],
                    name: e['customer_name'] ?? e['customer_id'],
                    phoneNumber: "NA",
                    tenantId: '',
                    createdBy: '',
                    updatedBy: '',
                  ),
                  itemCount: 0))
              .toList() ??
          [],
    );
  }
}
