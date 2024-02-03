// ignore_for_file: unnecessary_null_comparison

import 'package:xtremebikeapp3/model/Sepeda.dart';
import 'EditSepeda.dart';
import 'AddSepeda.dart';
import 'ViewSepeda.dart';
import 'package:xtremebikeapp3/services/SepedaService.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MaterialApp(
    title: 'CRUD P9 SQLite',
    debugShowCheckedModeBanner: false,
    home: SepedaPage(),
  ));
}


class SepedaPage extends StatefulWidget {
  const SepedaPage({Key? key}) : super(key: key);

  @override
  _SepedaPageState createState() => _SepedaPageState();
}

class _SepedaPageState extends State<SepedaPage> {
  late List<Sepeda> _SepedaList = <Sepeda>[];
  final _SepedaService = SepedaService();

getAllSepedaDetails() async {
  var Sepedas = await _SepedaService.ReadAllSepeda();
  setState(() {
    _SepedaList = <Sepeda>[];
    Sepedas.forEach((Map<String, dynamic> sepeda) {
      var SepedaModel = Sepeda(
        id: sepeda['id'],
        jenis: sepeda['jenis'],
        brand: sepeda['brand'],
        model: sepeda['model'],
        harga: sepeda['harga'],
        keterangan: sepeda['keterangan'],
      );
      _SepedaList.add(SepedaModel);
    });
  });
}

  @override
  void initState() {
    getAllSepedaDetails();
    super.initState();
  }

  _viewSepedaDetails(Sepeda sepeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewSepeda(sepeda: sepeda),
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

  _deleteFormDialog(BuildContext context, SepedaId) {
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
                var result = await _SepedaService.DeleteSepeda(SepedaId);
                if (result != null) {
                  Navigator.pop(context);
                  getAllSepedaDetails(); // Update the list after deletion
                  _showSuccessSnackBar('Sepeda Detail Deleted Successfully');
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

  Widget buildSepedaItem(Sepeda sepeda) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.directions_bike),
          title: Text(sepeda.brand ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sepeda.model ?? ''),
              Text(sepeda.harga ?? ''),
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
                      builder: (context) => EditSepeda(sepeda: sepeda),
                    ),
                  ).then((data) {
                    if (data != null) {
                      getAllSepedaDetails();
                      _showSuccessSnackBar('Sepeda Detail Updated Successfully');
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
                  _deleteFormDialog(context, sepeda.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {
                  _viewSepedaDetails(sepeda);
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
        title: const Text("List Sepeda"),
        backgroundColor: Color.fromARGB(255, 0, 255, 0),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: _SepedaList.length,
          itemBuilder: (context, index) {
            return buildSepedaItem(_SepedaList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddSepeda()),
          ).then((data) {
            if (data != null) {
              getAllSepedaDetails();
              _showSuccessSnackBar('Sepeda Detail Added Successfully');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

