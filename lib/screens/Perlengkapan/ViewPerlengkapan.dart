import 'package:xtremebikeapp3/model/Perlengkapan.dart';
import 'package:flutter/material.dart';
import 'package:xtremebikeapp3/Checkout.dart';

class ViewPerlengkapan extends StatefulWidget {
  final Perlengkapan perlengkapan;

  const ViewPerlengkapan({Key? key, required this.perlengkapan}) : super(key: key);

  @override
  State<ViewPerlengkapan> createState() => _ViewPerlengkapanState();
}

class _ViewPerlengkapanState extends State<ViewPerlengkapan> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Perlengkapan"),
        backgroundColor: Color.fromARGB(255, 0, 255, 0),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Full Details",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Jenis',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    widget.perlengkapan.jenis ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Model',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    widget.perlengkapan.model ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Harga',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    widget.perlengkapan.harga ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Keterangan',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    widget.perlengkapan.keterangan ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Quantity',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
ElevatedButton(
  onPressed: () async {
    // Navigate to CheckoutPage with sepeda information
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          items: [
            Item(
              brand: widget.perlengkapan.brand ?? '',
              model: widget.perlengkapan.model ?? '',
              harga: widget.perlengkapan.harga ?? '',
              quantity: quantity,
            ),
          ],
        ),
      ),
    );

    // Handle the result (entered items) from the CheckoutPage
    if (result != null) {
      // Add the result to your existing list of items or handle it accordingly
      // For example, update the state or perform any necessary operations
    }
  },
  child: Text('Checkout'),
),

          ],
        ),
      ),
    );
  }
}
