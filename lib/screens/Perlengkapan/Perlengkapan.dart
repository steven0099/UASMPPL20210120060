// ignore_for_file: unnecessary_null_comparison

import 'package:xtremebikeapp3/model/Perlengkapan.dart';
import 'EditPerlengkapan.dart';
import 'AddPerlengkapan.dart';
import 'ViewPerlengkapan.dart';
import 'package:xtremebikeapp3/services/PerlengkapanService.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MaterialApp(
    title: 'CRUD P9 SQLite',
    debugShowCheckedModeBanner: false,
    home: PerlengkapanPage(),
  ));
}

class PerlengkapanPage extends StatefulWidget {
  const PerlengkapanPage({Key? key}) : super(key: key);

  @override
  _PerlengkapanPageState createState() => _PerlengkapanPageState();
}

class _PerlengkapanPageState extends State<PerlengkapanPage> {
  late List<Perlengkapan> _PerlengkapanList = <Perlengkapan>[];
  final _PerlengkapanService = PerlengkapanService();

  getAllPerlengkapanDetails() async {
    var Perlengkapans = await _PerlengkapanService.ReadAllPerlengkapan();
    setState(() {
      _PerlengkapanList = <Perlengkapan>[];
      Perlengkapans.forEach((Map<String, dynamic> perlengkapan) {
        var PerlengkapanModel = Perlengkapan(
          id: perlengkapan['id'],
          jenis: perlengkapan['jenis'],
          brand: perlengkapan['brand'],
          model: perlengkapan['model'],
          harga: perlengkapan['harga'],
          keterangan: perlengkapan['keterangan'],
        );
        _PerlengkapanList.add(PerlengkapanModel);
      });
    });
  }

  @override
  void initState() {
    getAllPerlengkapanDetails();
    super.initState();
  }

  _viewPerlengkapanDetails(Perlengkapan perlengkapan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewPerlengkapan(perlengkapan: perlengkapan),
      ),
    );
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, PerlengkapanId) {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: const Text(
            'Are You Sure to Delete',
            style: TextStyle(color: Colors.teal, fontSize: 20),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                var result = await _PerlengkapanService.DeletePerlengkapan(PerlengkapanId);
                if (result != null) {
                  Navigator.pop(context);
                  getAllPerlengkapanDetails(); // Update the list after deletion
                  _showSuccessSnackBar('Perlengkapan Detail Deleted Successfully');
                }
              },
              child: const Text('Delete'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget buildPerlengkapanItem(Perlengkapan perlengkapan) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.shopping_bag),
          title: Text(perlengkapan.brand ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(perlengkapan.model ?? ''),
              Text(perlengkapan.harga ?? ''),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPerlengkapan(perlengkapan: perlengkapan),
                    ),
                  ).then((data) {
                    if (data != null) {
                      getAllPerlengkapanDetails();
                      _showSuccessSnackBar('Perlengkapan Detail Updated Successfully');
                    }
                  });
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.yellow,
                ),
              ),
              IconButton(
                onPressed: () {
                  _deleteFormDialog(context, perlengkapan.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {
                  _viewPerlengkapanDetails(perlengkapan);
                },
                icon: Icon(
                  Icons.visibility,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
        Divider(), // Optional: Add a divider between items
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Perlengkapan"),
        backgroundColor: Color.fromARGB(255, 0, 255, 0),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: _PerlengkapanList.length,
          itemBuilder: (context, index) {
            return buildPerlengkapanItem(_PerlengkapanList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPerlengkapan()),
          ).then((data) {
            if (data != null) {
              getAllPerlengkapanDetails();
              _showSuccessSnackBar('Perlengkapan Detail Added Successfully');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
