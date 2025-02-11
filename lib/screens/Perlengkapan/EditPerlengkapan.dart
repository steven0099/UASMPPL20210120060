import 'package:xtremebikeapp3/model/Perlengkapan.dart';
import 'package:xtremebikeapp3/services/PerlengkapanService.dart';
import 'package:flutter/material.dart';

class EditPerlengkapan extends StatefulWidget {
  final Perlengkapan perlengkapan;

  const EditPerlengkapan({Key? key, required this.perlengkapan}) : super(key: key);

  @override
  State<EditPerlengkapan> createState() => _EditPerlengkapanState();
}

class _EditPerlengkapanState extends State<EditPerlengkapan> {
  var _PerlengkapanJenisController = TextEditingController();
  var _PerlengkapanModelController = TextEditingController();
  var _PerlengkapanBrandController = TextEditingController();
  var _PerlengkapanHargaController = TextEditingController();
  var _PerlengkapanKeteranganController = TextEditingController(); // New controller
  bool _validateJenis = false;
  bool _validateModel = false;
  bool _validateBrand = false;
  bool _validateHarga = false;
  bool _validateKeterangan = false; // New validation
  var _PerlengkapanService = PerlengkapanService();

  @override
  void initState() {
    setState(() {
      _PerlengkapanJenisController.text = widget.perlengkapan.jenis ?? '';
      _PerlengkapanModelController.text = widget.perlengkapan.model ?? '';
      _PerlengkapanBrandController.text = widget.perlengkapan.brand ?? '';
      _PerlengkapanHargaController.text = widget.perlengkapan.harga ?? '';
      _PerlengkapanKeteranganController.text = widget.perlengkapan.keterangan ?? ''; // Set initial value for the new field
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Perlengkapan"),
        backgroundColor: Color.fromARGB(255, 0, 255, 0),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Perlengkapan',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _PerlengkapanJenisController,
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
                controller: _PerlengkapanModelController,
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
                controller: _PerlengkapanBrandController,
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
                controller: _PerlengkapanHargaController,
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
                controller: _PerlengkapanKeteranganController,
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
                        _PerlengkapanJenisController.text.isEmpty
                            ? _validateJenis = true
                            : _validateJenis = false;
                        _PerlengkapanModelController.text.isEmpty
                            ? _validateModel = true
                            : _validateModel = false;
                        _PerlengkapanBrandController.text.isEmpty
                            ? _validateBrand = true
                            : _validateBrand = false;
                        _PerlengkapanHargaController.text.isEmpty
                            ? _validateHarga = true
                            : _validateHarga = false;
                        _PerlengkapanKeteranganController.text.isEmpty
                            ? _validateKeterangan = true
                            : _validateKeterangan = false;
                      });
                      if (_validateJenis == false &&
                          _validateModel == false &&
                          _validateBrand == false &&
                          _validateHarga == false &&
                          _validateKeterangan == false) {
                        var _Perlengkapan = Perlengkapan();
                        _Perlengkapan.id = widget.perlengkapan.id;
                        _Perlengkapan.jenis = _PerlengkapanJenisController.text;
                        _Perlengkapan.model = _PerlengkapanModelController.text;
                        _Perlengkapan.brand = _PerlengkapanBrandController.text;
                        _Perlengkapan.harga = _PerlengkapanHargaController.text;
                        _Perlengkapan.keterangan = _PerlengkapanKeteranganController.text;
                        var result =
                            await _PerlengkapanService.UpdatePerlengkapan(_Perlengkapan);
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
                      _PerlengkapanJenisController.text = '';
                      _PerlengkapanModelController.text = '';
                      _PerlengkapanBrandController.text = '';
                      _PerlengkapanHargaController.text = '';
                      _PerlengkapanKeteranganController.text = '';
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
