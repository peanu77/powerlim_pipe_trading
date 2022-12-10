class Product {
  String id;
  final String name;
  final int stocks;
  final String price;

  Product({
    this.id = '',
    required this.name,
    required this.stocks,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'stocks': stocks,
        'price': price,
      };

  static Product fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        stocks: json['stocks'],
        price: json['price'],
      );
}
