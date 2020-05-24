import 'package:covidapp/src/core/api_url.dart';
import 'package:covidapp/src/models/country.dart';
import 'package:covidapp/src/resources/covid/covid_repository.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

class CovidRepositoryImpl implements CovidRepository {

  Future<Country> findOne({String nameApi}) async {
    final int confirmed = await _get(nameApi, await Url.get(ApiUrl.confirmed));
    final int recovered = await _get(nameApi, await Url.get(ApiUrl.recovered));
    final int deaths = await _get(nameApi, await Url.get(ApiUrl.deaths));

    final activeCases = confirmed - (recovered + deaths);

    final Country country = Country(
        id: nameApi,
        nameApi: nameApi,
        confirmed: activeCases, // confirmed = Active cases
        recovered: recovered, // recovered = People recovered
        deaths: deaths, // deaths = Deaths
        total: confirmed // Total cases
    );

    return country;
  }

  Future<int> _get(String nameCountry, String url) async {
    final int indexCountry = 1;
    final response = await http.get(url);

    List<List<dynamic>> result = const CsvToListConverter(eol: '\n').convert(response.body);
    List<List<dynamic>> query = result.where((res) => res[indexCountry] == nameCountry).toList();

    final int total = query[0][query[0].length - 1];
    return total;
  }
}