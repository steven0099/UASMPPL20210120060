import 'package:xtremebikeapp3/db_helper/repository.dart';
import 'package:xtremebikeapp3/model/Perlengkapan.dart';

class PerlengkapanService {
  late Repository _repository;

  PerlengkapanService() {
    _repository = Repository();
  }

  // Save Perlengkapan
  Future<int> SavePerlengkapan(Perlengkapan perlengkapan) async {
    return await _repository.insertData('perlengkapan', perlengkapan.toMap());
  }

  // Read All Perlengkapan
  ReadAllPerlengkapan() async {
    var result = await _repository.readData('perlengkapan');
    return List<Map<String, dynamic>>.from(result);
  }

  // Edit Perlengkapan
  Future<int> UpdatePerlengkapan(Perlengkapan perlengkapan) async {
    return await _repository.updateData('perlengkapan', perlengkapan.toMap());
  }

  // Delete Perlengkapan
  Future<int> DeletePerlengkapan(int perlengkapanId) async {
    return await _repository.deleteDataById('perlengkapan', perlengkapanId);
  }
}
