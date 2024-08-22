class Company {
  String? id;
  String? name;
  String? description;
  Company({this.id, this.name, this.description});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class CompanyType {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  CompanyType({this.id, this.name, this.email, this.phoneNumber});

  factory CompanyType.fromJson(Map<String, dynamic> json) {
    return CompanyType(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }
}

class ProductType {
  String? id;
  String? name;
  String? description;
  ProductType({this.id, this.name, this.description});

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class ModelProduct {
  String? id;
  String? name;
  String? description;
  double? buyingPrice;
  double? sellingPrice;
  int? stock;
  Company? company;
  ProductType? productType;

  ModelProduct(
      {this.id,
      this.name,
      this.description,
      this.buyingPrice,
      this.sellingPrice,
      this.stock,
      this.company,
      this.productType});

  factory ModelProduct.fromJson(Map<String, dynamic> json) {
    return ModelProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      buyingPrice: json['buying_price'],
      sellingPrice: json['selling_price'],
      stock: json['stock'],
      company: Company.fromJson({
        'id': json['company_id'],
        'name': json['company'],
      }),
      productType: ProductType.fromJson({
        'id': json['product_type_id'],
        'name': json['product_type'],
      }),
    );
  }
}
