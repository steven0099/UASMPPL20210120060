import 'package:xtremebikeapp3/db_helper/repository.dart';
import 'package:xtremebikeapp3/model/Sparepart.dart';

class SparepartService {
  late Repository _repository;

  SparepartService() {
    _repository = Repository();
  }

  // Save Sparepart
  Future<int> SaveSparepart(Sparepart sparepart) async {
    return await _repository.insertData('sparepart', sparepart.toMap());
  }

  // Read All Sparepart
ReadAllSparepart() async {
  var result = await _repository.readData('sparepart');
  return List<Map<String, dynamic>>.from(result);
}


  // Edit Sparepart
  Future<int> UpdateSparepart(Sparepart sparepart) async {
    return await _repository.updateData('sparepart', sparepart.toMap());
  }

  // Delete Sparepart
  Future<int> DeleteSparepart(int sparepartId) async {
    return await _repository.deleteDataById('sparepart', sparepartId);
  }
}
