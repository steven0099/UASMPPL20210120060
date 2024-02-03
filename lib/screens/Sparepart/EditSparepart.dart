import 'package:xtremebikeapp3/model/Sparepart.dart';
import 'package:xtremebikeapp3/services/SparepartService.dart';
import 'package:flutter/material.dart';

class EditSparepart extends StatefulWidget {
  final Sparepart sparepart;

  const EditSparepart({Key? key, required this.sparepart}) : super(key: key);

  @override
  State<EditSparepart> createState() => _EditSparepartState();
}

class _EditSparepartState extends State<EditSparepart> {
  var _SparepartJenisController = TextEditingController();
  var _SparepartModelController = TextEditingController();
  var _SparepartBrandController = TextEditingController();
  var _SparepartHargaController = TextEditingController();
  var _SparepartKeteranganController = TextEditingController(); // New controller
  bool _validateJenis = false;
  bool _validateModel = false;
  bool _validateBrand = false;
  bool _validateHarga = false;
  bool _validateKeterangan = false; // New validation
  var _SparepartService = SparepartService();

  @override
  void initState() {
    setState(() {
      _SparepartJenisController.text = widget.sparepart.jenis ?? '';
      _SparepartModelController.text = widget.sparepart.model ?? '';
      _SparepartBrandController.text = widget.sparepart.brand ?? '';
      _SparepartHargaController.text = widget.sparepart.harga ?? '';
      _SparepartKeteranganController.text = widget.sparepart.keterangan ?? ''; // Set initial value for the new field
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Sparepart"),
        backgroundColor: Color.fromARGB(255, 0, 255, 0),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Sparepart',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _SparepartJenisController,
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
                controller: _SparepartModelController,
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
                controller: _SparepartBrandController,
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
                controller: _SparepartHargaController,
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
                controller: _SparepartKeteranganController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Keterangan',
                  labelText: 'Keterangan',
                  errorText: _validateKeterangan
                      ? 'Keterangan Value Can\'t Be Empty'
                      : null,
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
                        _SparepartJenisController.text.isEmpty
                            ? _validateJenis = true
                            : _validateJenis = false;
                        _SparepartModelController.text.isEmpty
                            ? _validateModel = true
                            : _validateModel = false;
                        _SparepartBrandController.text.isEmpty
                            ? _validateBrand = true
                            : _validateBrand = false;
                        _SparepartHargaController.text.isEmpty
                            ? _validateHarga = true
                            : _validateHarga = false;
                        _SparepartKeteranganController.text.isEmpty
                            ? _validateKeterangan = true
                            : _validateKeterangan = false;
                      });
                      if (_validateJenis == false &&
                          _validateModel == false &&
                          _validateBrand == false &&
                          _validateHarga == false &&
                          _validateKeterangan == false) {
                        var _Sparepart = Sparepart();
                        _Sparepart.id = widget.sparepart.id;
                        _Sparepart.jenis = _SparepartJenisController.text;
                        _Sparepart.model = _SparepartModelController.text;
                        _Sparepart.brand = _SparepartBrandController.text;
                        _Sparepart.harga = _SparepartHargaController.text;
                        _Sparepart.keterangan = _SparepartKeteranganController.text;
                        var result =
                            await _SparepartService.UpdateSparepart(_Sparepart);
                        Navigator.pop(context, result);
                      }
                    },
                    child: const Text('Update Details'),
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
                      _SparepartJenisController.text = '';
                      _SparepartModelController.text = '';
                      _SparepartBrandController.text = '';
                      _SparepartHargaController.text = '';
                      _SparepartKeteranganController.text = '';
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
