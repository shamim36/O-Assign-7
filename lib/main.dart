import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Product {
  final String name;
  final double price;
  int quantity = 0;
  int totalProductCount = 0;

  Product(this.name, this.price);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
      ),
      home: const ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product("Product 1", 20.00),
    Product("Product 2", 20.00),
    Product("Product 3", 20.00),
    Product("Product 4", 20.00),
    Product("Product 5", 20.00),
    Product("Product 6", 20.00),
    Product("Product 7", 20.00),
    Product("Product 8", 20.00),
    Product("Product 9", 20.00),
    Product("Product 10", 20.00),
    Product("Product 11", 20.00),
    Product("Product 12", 20.00),
    Product("Product 13", 20.00),
    Product("Product 14", 20.00),
    Product("Product 15", 20.00),
    Product("Product 16", 20.00),
    Product("Product 17", 20.00),
    Product("Product 18", 20.00),
    Product("Product 19", 20.00),
    Product("Product 20", 20.00),
  ];

  void _addToCart(Product product) {
    setState(() {
      product.quantity++;
      if (product.quantity == 1) {
        product.totalProductCount++;
      }
      if (product.quantity == 5) {
        _showCongratulationsDialog(product);
      }
    });
  }

  Future<void> _showCongratulationsDialog(Product product) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('You\'ve bought 5 ${product.name}!'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"))
          ],
        );
      },
    );
  }

  void _goToCart() {
    int totalItemsBought = products
        .map((product) => product.totalProductCount)
        .reduce((a, b) => a + b);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(totalItemsBought),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Counting : ${product.quantity}',
                    style: const TextStyle(fontSize: 17),
                  ),
                  ElevatedButton(
                      onPressed: () => _addToCart(product),
                      child: const Text("Buy Now"))
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          _goToCart();
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final int totalItemsBought;

  const CartPage(this.totalItemsBought, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Total Product Bought: $totalItemsBought',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
