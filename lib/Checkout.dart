import 'package:flutter/material.dart';

class Item {
  final String brand;
  final String model;
  final String harga;
  int quantity;

  Item({
    required this.brand,
    required this.model,
    required this.harga,
    required this.quantity,
  });

  Item.copy(Item other)
      : brand = other.brand,
        model = other.model,
        harga = other.harga,
        quantity = other.quantity;

  Item updateQuantity(int newQuantity) {
    return Item.copy(this)..quantity = newQuantity;
  }
}

class CheckoutPage extends StatefulWidget {
  final List<Item> items;

  const CheckoutPage({Key? key, required this.items}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _updateTotalPrice();
  }

  void _updateTotalPrice() {
    totalPrice = widget.items.fold<double>(0, (previousValue, item) {
      return previousValue + (double.parse(item.harga) * item.quantity);
    });
  }

  Future<void> _returnToCallingScreen(BuildContext context, List<Item> enteredItems) async {
    Navigator.pop(context, enteredItems);
  }

  void _mergeItems(List<Item> newItems) {
    for (var newItem in newItems) {
      var existingItemIndex = widget.items.indexWhere(
        (item) => item.brand == newItem.brand && item.model == newItem.model,
      );

      if (existingItemIndex != -1) {
        widget.items[existingItemIndex] = widget.items[existingItemIndex].updateQuantity(
          widget.items[existingItemIndex].quantity + newItem.quantity,
        );
      } else {
        widget.items.add(newItem);
      }
    }

    _updateTotalPrice();
  }

  Future<void> _checkout(BuildContext context) async {
    // Simulate payment process (replace with actual payment logic)
    bool paymentSuccessful = true;

    if (paymentSuccessful) {
      // Display a digital receipt
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Digital Receipt'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var item in widget.items)
                  ListTile(
                    title: Text('${item.brand} ${item.model}'),
                    subtitle: Text('Quantity: ${item.quantity} | Price: ${item.harga}'),
                  ),
                Divider(),
                Text('Total Price: $totalPrice'),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // You can perform additional actions after checkout
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            for (var item in widget.items)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item: ${item.brand} ${item.model}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Quantity: ${item.quantity}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Price per item: ${item.harga}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            Divider(),
            Text(
              'Total Price: $totalPrice',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                List<Item> enteredItems = [
                ];

                _mergeItems(enteredItems);

                await _checkout(context);
                _returnToCallingScreen(context, widget.items);
              },
              child: Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CheckoutPage(items: []), // Initialize CheckoutPage with an empty list
  ));
}