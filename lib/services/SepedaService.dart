import 'package:xtremebikeapp3/db_helper/repository.dart';
import 'package:xtremebikeapp3/model/Sepeda.dart';

class SepedaService {
  late Repository _repository;

  SepedaService() {
    _repository = Repository();
  }

  // Save Sepeda
  Future<int> SaveSepeda(Sepeda sepeda) async {
    return await _repository.insertData('sepeda', sepeda.toMap());
  }

  // Read All Sepeda
ReadAllSepeda() async {
  var result = await _repository.readData('sepeda');
  return List<Map<String, dynamic>>.from(result);
}


  // Edit Sepeda
  Future<int> UpdateSepeda(Sepeda sepeda) async {
    return await _repository.updateData('sepeda', sepeda.toMap());
  }

  // Delete Sepeda
  Future<int> DeleteSepeda(int sepedaId) async {
    return await _repository.deleteDataById('sepeda', sepedaId);
  }
}
