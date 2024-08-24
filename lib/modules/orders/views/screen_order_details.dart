import 'package:flutter/material.dart';
import 'package:wareflow/modules/orders/api/payment_api.dart';
import 'package:wareflow/modules/orders/models/model_order.dart';
import 'package:wareflow/modules/orders/models/model_payment.dart';
import 'package:wareflow/modules/orders/views/widgets/widget_key_value.dart';
import 'package:wareflow/modules/orders/views/widgets/widget_payment_card.dart';
import 'package:wareflow/modules/orders/views/widgets/widget_payment_chip.dart';
import 'package:wareflow/widgets/common_textfield.dart';

import '../../../common/widget_not_found.dart';

class ScreenOrderDetails extends StatefulWidget {
  final ModelOrder order;
  const ScreenOrderDetails({super.key, required this.order});

  @override
  State<ScreenOrderDetails> createState() => _ScreenOrderDetailsState();
}

class _ScreenOrderDetailsState extends State<ScreenOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Screen Order Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    WidgetKeyValue(
                        keyString: "Customer Name",
                        value: widget.order.customer.name),
                    const SizedBox(height: 5),
                    WidgetKeyValue(
                        keyString: "Customer Contact Info",
                        value: widget.order.customer.phoneNumber),
                    const SizedBox(height: 5),
                    WidgetKeyValue(
                        keyString: "Total order value",
                        value: widget.order.orderValue.toString()),
                    const SizedBox(height: 5),
                    WidgetKeyValue(
                        keyString: "Balance",
                        value: widget.order.balance.toString()),
                    const SizedBox(height: 5),
                    WidgetKeyValue(
                        keyString: "Total Products",
                        value: widget.order.itemCount.toString()),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          "Payment Status: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        getPaymentChip(widget.order.status)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Payments ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<ModelPayment>>(
                future:
                    PaymentAPI.getPaymentsForOrder(orderId: widget.order.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: WidgetNotFound(text: "No Payments Made"));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: WidgetPaymentCard(payment: item),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showPaymentDialog();
          }),
    );
  }

  void showPaymentDialog() {
    TextEditingController amountController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController paymentTypeController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Payment"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonTextfield(
                    compulsory: true,
                    keyboardType: TextInputType.number,
                    label: "Amount",
                    hintText: "Enter amount",
                    onChangeValue: (value) {
                      if (double.parse(amountController.text) >
                          widget.order.balance) {
                        amountController.text = widget.order.balance.toString();
                      }
                    },
                    controller: amountController),
                const SizedBox(height: 10),
                CommonTextfield(
                    hintText: "Enter description",
                    label: "Description",
                    controller: descriptionController),
                const SizedBox(height: 10),
                CommonTextfield(
                  compulsory: true,
                  controller: paymentTypeController,
                  label: "Payment Type",
                  hintText: "Select Payment Type",
                  type: FieldType.dropdown,
                  dropdownList: [
                    ModelDropdown(id: "0", name: "UPI"),
                    ModelDropdown(id: "1", name: "Cash"),
                    ModelDropdown(id: "2", name: "Card"),
                  ],
                  onSelectDropdown: (value) {
                    paymentTypeController.text = value.name;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          PaymentAPI.addPayment(
                            orderId: widget.order.id,
                            amount: amountController.text,
                            description: descriptionController.text,
                            paymentType: paymentTypeController.text,
                          ).then((value) {
                            if (value) {
                              Navigator.of(context).pop();
                              setState(() {
                                widget.order.balance -=
                                    double.parse(amountController.text);
                              });
                            }
                          });
                        }
                      },
                      child: const Text("Add"),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
