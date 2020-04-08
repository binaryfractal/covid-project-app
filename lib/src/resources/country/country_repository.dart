import 'package:covidapp/src/models/country.dart';

abstract class CountryRepository {
  Future<Country> findOne({String id});

  Future<List<Country>> findAll();
}