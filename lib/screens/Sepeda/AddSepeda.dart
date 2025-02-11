import 'package:xtremebikeapp3/model/Sepeda.dart';
import 'package:xtremebikeapp3/services/SepedaService.dart';
import 'package:flutter/material.dart';

class AddSepeda extends StatefulWidget {
  const AddSepeda({Key? key}) : super(key: key);

  @override
  State<AddSepeda> createState() => _AddSepedaState();
}

class _AddSepedaState extends State<AddSepeda> {
  var _SepedaJenisController = TextEditingController();
  var _SepedaBrandController = TextEditingController();
  var _SepedaModelController = TextEditingController();
  var _SepedaHargaController = TextEditingController();
  var _SepedaKeteranganController = TextEditingController(); // New controller
  bool _validateJenis = false;
  bool _validateBrand = false;
  bool _validateModel = false;
  bool _validateHarga = false;
  bool _validateKeterangan = false; // New validation
  var _SepedaService = SepedaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Sepeda"),
        backgroundColor: Color.fromARGB(255, 0, 255, 0),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Sepeda',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _SepedaJenisController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Jenis',
                  labelText: 'Jenis',
                  errorText:
                      _validateJenis ? 'Jenis Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _SepedaBrandController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Brand',
                  labelText: 'Brand',
                  errorText:
                      _validateBrand ? 'Brand Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _SepedaModelController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Model',
                  labelText: 'Model',
                  errorText:
                      _validateModel ? 'Model Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _SepedaHargaController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Harga',
                  labelText: 'Harga',
                  errorText:
                      _validateHarga ? 'Harga Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _SepedaKeteranganController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Keterangan',
                  labelText: 'Keterangan',
                  errorText:
                      _validateKeterangan ? 'Keterangan Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.teal,
                        textStyle: const TextStyle(fontSize: 15)),
                    onPressed: () async {
                      setState(() {
                        _SepedaJenisController.text.isEmpty
                            ? _validateJenis = true
                            : _validateJenis = false;
                        _SepedaBrandController.text.isEmpty
                            ? _validateBrand = true
                            : _validateBrand = false;
                        _SepedaModelController.text.isEmpty
                            ? _validateModel = true
                            : _validateModel = false;
                        _SepedaHargaController.text.isEmpty
                            ? _validateHarga = true
                            : _validateHarga = false;
                        _SepedaKeteranganController.text.isEmpty
                            ? _validateKeterangan = true
                            : _validateKeterangan = false;
                      });
                      if (_validateJenis == false &&
                          _validateBrand == false &&
                          _validateModel == false &&
                          _validateHarga == false &&
                          _validateKeterangan == false) {
                        var _Sepeda = Sepeda();
                        _Sepeda.jenis = _SepedaJenisController.text;
                        _Sepeda.brand = _SepedaBrandController.text;
                        _Sepeda.model = _SepedaModelController.text;
                        _Sepeda.harga = _SepedaHargaController.text;
                        _Sepeda.keterangan = _SepedaKeteranganController.text; // Include the new field
                        var result = await _SepedaService.SaveSepeda(_Sepeda);
                        Navigator.pop(context, result);
                      }
                    },
                    child: const Text('Save Details'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontSize: 15)),
                    onPressed: () {
                      _SepedaJenisController.text = '';
                      _SepedaBrandController.text = '';
                      _SepedaModelController.text = '';
                      _SepedaHargaController.text = '';
                      _SepedaKeteranganController.text = ''; // Clear the new field
                    },
                    child: const Text('Clear Details'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
