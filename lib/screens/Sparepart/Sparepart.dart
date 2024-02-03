// ignore_for_file: unnecessary_null_comparison

import 'package:xtremebikeapp3/model/Sparepart.dart';
import 'EditSparepart.dart';
import 'AddSparepart.dart';
import 'ViewSparepart.dart';
import 'package:xtremebikeapp3/services/SparepartService.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MaterialApp(
    title: 'CRUD P9 SQLite',
    debugShowCheckedModeBanner: false,
    home: SparepartPage(),
  ));
}


class SparepartPage extends StatefulWidget {
  const SparepartPage({Key? key}) : super(key: key);

  @override
  _SparepartPageState createState() => _SparepartPageState();
}

class _SparepartPageState extends State<SparepartPage> {
  late List<Sparepart> _SparepartList = <Sparepart>[];
  final _SparepartService = SparepartService();

getAllSparepartDetails() async {
  var Spareparts = await _SparepartService.ReadAllSparepart();
  setState(() {
    _SparepartList = <Sparepart>[];
    Spareparts.forEach((Map<String, dynamic> sparepart) {
      var SparepartModel = Sparepart(
        id: sparepart['id'],
        jenis: sparepart['jenis'],
        brand: sparepart['brand'],
        model: sparepart['model'],
        harga: sparepart['harga'],
        keterangan: sparepart['keterangan'],
      );
      _SparepartList.add(SparepartModel);
    });
  });
}

  @override
  void initState() {
    getAllSparepartDetails();
    super.initState();
  }

  _viewSparepartDetails(Sparepart sparepart) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewSparepart(sparepart: sparepart),
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

  _deleteFormDialog(BuildContext context, SparepartId) {
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
                var result = await _SparepartService.DeleteSparepart(SparepartId);
                if (result != null) {
                  Navigator.pop(context);
                  getAllSparepartDetails(); // Update the list after deletion
                  _showSuccessSnackBar('Sparepart Detail Deleted Successfully');
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

  Widget buildSparepartItem(Sparepart sparepart) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.build),
          title: Text(sparepart.brand ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sparepart.model ?? ''),
              Text(sparepart.harga ?? ''),
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
                      builder: (context) => EditSparepart(sparepart: sparepart),
                    ),
                  ).then((data) {
                    if (data != null) {
                      getAllSparepartDetails();
                      _showSuccessSnackBar('Sparepart Detail Updated Successfully');
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
                  _deleteFormDialog(context, sparepart.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {
                  _viewSparepartDetails(sparepart);
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
        title: const Text("List Sparepart"),
        backgroundColor: Color.fromARGB(255, 0, 255, 0),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: _SparepartList.length,
          itemBuilder: (context, index) {
            return buildSparepartItem(_SparepartList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddSparepart()),
          ).then((data) {
            if (data != null) {
              getAllSparepartDetails();
              _showSuccessSnackBar('Sparepart Detail Added Successfully');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

