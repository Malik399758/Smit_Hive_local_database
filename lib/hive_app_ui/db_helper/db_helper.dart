
import 'package:hive/hive.dart';
import 'package:smit_hive_database/hive_app_ui/models/hive_model.dart';
class DbHelper{
  String boxName = 'HiveBoxName';
  Box<HiveModel>? _box;

  // Get box
  Future<Box<HiveModel>?> getData()async{
    if(_box == null){
      _box = await Hive.openBox(boxName);
    }
    return _box;
  }

  // Crud operations

  // add data

  Future<void> addData(String name,String price,String cents)async{
    final db = await getData();
    db!.add(HiveModel(name: name, price: int.parse(price), cents: int.parse(cents)));
  }

  // delete data
  Future<void> deleteData(int index)async{
    final db = await getData();
    db!.deleteAt(index);
  }

  // update data
  Future<void> updateData(int index,String name,String price,String cents)async{
    final db = await getData();
    db!.putAt(index, HiveModel(name: name, price: int.parse(price), cents: int.parse(cents)));
  }


  // fetch data

  Future<List<HiveModel>> fetchData()async{
    final db = await getData();
    return db!.values.toList();
  }


}