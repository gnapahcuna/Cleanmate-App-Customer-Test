class Product {
  final int ProductID;
  final String ProductNameTH;
  final String ProductNameEN;
  final String ImageFile;
  final String ProductPrice;
  final String ColorCode;

  Product({this.ProductID, this.ProductNameTH, this.ProductNameEN, this.ImageFile,this.ProductPrice,this.ColorCode});

  factory Product.fromJson(Map<String, dynamic> json) {
    //print(json['ImageFile'].toString().substring(3,json['ImageFile'].toString().length));
    return Product(
      ProductID: json['ProductID'],
      ProductNameTH: json['ProductNameTH'],
      ProductNameEN: json['ProductNameEN'],
      ProductPrice: json['ProductPrice'],
      ImageFile: json['ImageFile'],
      ColorCode: json['ColorCode'],
    );
  }
}