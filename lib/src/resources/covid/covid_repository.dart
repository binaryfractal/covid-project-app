import 'package:covidapp/src/models/country.dart';

abstract class CovidRepository {
  Future<Country> findOne({String nameApi});
}