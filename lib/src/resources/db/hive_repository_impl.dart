import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

class HiveRepositoryImpl implements DbRepository {
  Box _box;

  HiveRepositoryImpl({@required String db})
    : _box = Hive.box(db);

  @override
  Future<int> add(value) {
    return _box.add(value);
  }

  @override
  Future<void> delete(key) {
    return _box.delete(key);
  }

  @override
  Future<void> deleteAt(int index) {
    return _box.deleteAt(index);
  }

  @override
  get(key, {defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  }

  @override
  getAt(int index) {
    return _box.getAt(index);
  }

  @override
  Future<void> put(key, value) {
    return _box.put(key, value);
  }

  @override
  Future<void> putAt(int index, value) {
    return _box.putAt(index, value);
  }
}
