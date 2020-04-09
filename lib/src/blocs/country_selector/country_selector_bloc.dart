import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covidapp/src/blocs/country_selector/country_selector_base.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/models/country.dart';
import 'package:covidapp/src/resources/country/country_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:meta/meta.dart';


class CountrySelectorBloc extends Bloc<CountrySelectorEvent, CountrySelectorState> {
  final CountryRepository _countryRepository;
  final DbRepository _dbRepository;
  List<Country> _countries;

  CountrySelectorBloc({
    @required CountryRepository countryRepository,
    @required DbRepository dbRepository,
  })
    : _countryRepository = countryRepository,
      _dbRepository = dbRepository;

  @override
  CountrySelectorState get initialState => CountrySelectorInitial();

  @override
  Stream<CountrySelectorState> mapEventToState(CountrySelectorEvent event) async* {
    if(event is CountrySelectorInitialized) {
      yield* _mapCountrySelectorInitializedToState();
    } else if (event is CountrySelectorSelected) {
      yield* _mapCountrySelectorSelectedToState(event.countryCode);
    }
  }

  Stream<CountrySelectorState> _mapCountrySelectorInitializedToState() async* {
    yield CountrySelectorLoadInProgress();
    try {
      _countries = await _countryRepository.findAll();
      List<String> countriesCode = _countries.map((country) => country.id).toList();
      yield CountrySelectorLoadSuccess(countries: countriesCode);
    } catch(_) {
      yield CountrySelectorLoadFailure();
    }
  }

  Stream<CountrySelectorState> _mapCountrySelectorSelectedToState(String countryCode) async* {
    yield CountrySelectorSelectInProgress();
    try {
      final Country country = _countries.firstWhere((c) => c.id == countryCode);
      await _dbRepository.put(DbKeys.country, country);
      yield CountrySelectorSelectSuccess(country: country);
    } catch(_) {
      yield CountrySelectorSelectFailure();
      yield CountrySelectorInitial();
    }
  }
}