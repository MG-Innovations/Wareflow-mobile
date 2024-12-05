import 'package:flutter/material.dart';
import 'package:wareflow/modules/products/models/model_product.dart';
import '../../../utils/helper_functions.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_textfield.dart';
import '../api/product_api.dart';

class ScreenAddProduct extends StatefulWidget {
  final ModelProduct? product;
  const ScreenAddProduct({super.key, this.product});

  @override
  State<ScreenAddProduct> createState() => _ScreenAddProductState();
}

class _ScreenAddProductState extends State<ScreenAddProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController productTypeController = TextEditingController();
  final TextEditingController productCompanyController =
      TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController buyingPriceController = TextEditingController();
  final TextEditingController initialStockController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  ModelDropdown? productType, company;

  void initialize() {
    if (widget.product != null) {
      nameController.text = widget.product?.name ?? "";
      descriptionController.text = widget.product?.description ?? "";
      productTypeController.text = widget.product?.productType?.name ?? "";
      productCompanyController.text = widget.product?.company?.name ?? "";
      sellingPriceController.text =
          widget.product?.sellingPrice.toString() ?? "";
      buyingPriceController.text = widget.product?.buyingPrice.toString() ?? "";
      initialStockController.text = widget.product?.stock.toString() ?? "";
      productType = ModelDropdown(
          id: widget.product!.productType!.id!,
          name: widget.product!.productType!.name!);

      company = ModelDropdown(
          id: widget.product!.company!.id!,
          name: widget.product!.company!.name!);
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const WidgetCommonAppbar(
          title: "Add Product",
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CommonTextfield(
                        controller: nameController,
                        label: 'Product Name',
                        hintText: "Enter product name",
                        compulsory: true,
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: descriptionController,
                        hintText: "Enter product description",
                        label: 'Product Description',
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: productTypeController,
                        label: 'Product Type',
                        hintText: "Select product type",
                        type: FieldType.dropdown,
                        fetchDropdown: InventoryAPI.getAllProductType(),
                        compulsory: true,
                        onSelectDropdown: (item) {
                          productTypeController.text = item.name;
                          productType = item;
                        },
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: productCompanyController,
                        label: 'Product Company',
                        hintText: "Select product company",
                        type: FieldType.dropdown,
                        fetchDropdown: InventoryAPI.getAllCompany(),
                        compulsory: true,
                        onSelectDropdown: (item) {
                          productCompanyController.text = item.name;
                          company = item;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextfield(
                              controller: sellingPriceController,
                              label: 'Selling Price',
                              hintText: "Enter selling price",
                              compulsory: true,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CommonTextfield(
                              controller: buyingPriceController,
                              label: 'Buying Price',
                              hintText: "Enter buying price",
                              compulsory: true,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: initialStockController,
                        label:
                            widget.product != null ? 'Stock' : 'Initial stock',
                        hintText: widget.product != null
                            ? "Enter Stock"
                            : "Enter initial stock",
                        compulsory: true,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (widget.product == null) {
                        InventoryAPI.submitProduct(
                                producName: nameController.text,
                                productDescription: descriptionController.text,
                                productTypeId: productType!.id,
                                productCompanyNameId: company!.id,
                                sellingPrice: sellingPriceController.text,
                                buyingPrice: buyingPriceController.text,
                                initialStock: initialStockController.text)
                            .then((value) {
                          if (value) {
                            Navigator.of(context).pop();
                          } else {
                            HFunctions.showSnackbar(
                              content: "Failed to add product",
                              context: context,
                            );
                          }
                        });
                      } else {
                        InventoryAPI.updateProduct(
                          productId: widget.product!.id!,
                          producName: nameController.text,
                          productDescription: descriptionController.text,
                          productTypeId: productType!.id,
                          productCompanyNameId: company!.id,
                          sellingPrice: sellingPriceController.text,
                          buyingPrice: buyingPriceController.text,
                          initialStock: initialStockController.text,
                        ).then((value) {
                          if (value) {
                            Navigator.of(context).pop();
                          } else {
                            HFunctions.showSnackbar(
                                context: context,
                                success: false,
                                content: "Error in updating product");
                          }
                        });
                      }
                    }
                  },
                  child: Text(widget.product != null
                      ? "Update Product"
                      : "Add Product"),
                )
              ],
            ),
          ),
        ));
  }
}
