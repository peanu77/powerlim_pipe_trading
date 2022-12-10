import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:powerlim_pipe_trading/models/product_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final nameController = TextEditingController();
  final stocksController = TextEditingController();
  final priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<List<Product>>(
          stream: readProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else if (snapshot.hasData) {
              final product = snapshot.data!;
              return ListView(
                children: product.map(buildProduct).toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Product',
        child: const Icon(Icons.add),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Center(child: Text('Add Product')),
            content: SingleChildScrollView(
              child: SizedBox(
                height: size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Diverter Tee',
                        labelText: 'Product Name',
                        border: const OutlineInputBorder(),
                        suffixIcon: stocksController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => nameController.clear(),
                              ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: nameController,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '999',
                        labelText: 'Number of Stocks',
                        border: const OutlineInputBorder(),
                        suffixIcon: stocksController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => stocksController.clear(),
                              ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: stocksController,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '99.99',
                        labelText: 'Price',
                        border: const OutlineInputBorder(),
                        suffixIcon: stocksController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => priceController.clear(),
                              ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: priceController,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final products = Product(
                    name: nameController.text,
                    stocks: int.parse(stocksController.text),
                    price: priceController.text,
                  );

                  createProduct(products);

                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stream<List<Product>> readProducts() => FirebaseFirestore.instance
      .collection('products')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => Product.fromJson(doc.data())).toList());

  Future createProduct(Product product) async {
    final docProduct = FirebaseFirestore.instance.collection('products').doc();
    product.id = docProduct.id;

    final json = product.toJson();
    await docProduct.set(json);
  }

  Widget buildProduct(Product product) => ListTile(
        leading: CircleAvatar(
          child: Text('${product.stocks}'),
        ),
        title: Text('Name : ${product.name}'),
        subtitle: Text('Price : ${product.price}'),
        trailing: IconButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('products')
                .doc(product.id)
                .delete();
          },
          icon: const Icon(Icons.delete),
        ),
      );
}
