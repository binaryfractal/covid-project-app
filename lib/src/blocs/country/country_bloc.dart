import 'package:bloc/bloc.dart';
import 'package:covidapp/src/blocs/country/country_base.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/models/country.dart';
import 'package:covidapp/src/models/filter.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/resources/country/country_repository.dart';
import 'package:covidapp/src/resources/covid/covid_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:flutter/material.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  ProfileRepository _profileRepository;
  CovidRepository _covidRepository;
  CountryRepository _countryRepository;
  DbRepository _dbRepository;

  CountryBloc({
    @required ProfileRepository profileRepository,
    @required CovidRepository covidRepository,
    @required CountryRepository countryRepository,
    @required DbRepository dbRepository,
  }) :  assert(profileRepository != null),
        assert(covidRepository != null),
        assert(countryRepository != null),
        assert(dbRepository != null),
        _profileRepository = profileRepository,
        _covidRepository = covidRepository,
        _countryRepository = countryRepository,
        _dbRepository = dbRepository;

  @override
  CountryState get initialState => CountryInitial();

  @override
  Stream<CountryState> mapEventToState(CountryEvent event) async* {
    if(event is CountryInitialized) {
      yield* _mapCountryInitializedToState();
    }
  }

  Stream<CountryState> _mapCountryInitializedToState() async* {
    yield CountryLoadInProgress();
    try {
      Country currentCountry = await _findCurrentCountry();
      Country newCountry = await _covidRepository.findOne(nameApi: currentCountry.nameApi);
      newCountry = await _updateCurrentCountry(currentCountry, newCountry);

      List<Profile> profiles = await _profileRepository.findBy(filters: await _createFilters(newCountry));
      yield CountryLoadSuccess(
          country: newCountry,
          profiles: profiles
      );
    } catch(_) {
      CountryLoadFailure();
    }
  }

  Future<List<Filter>> _createFilters(Country country) async {
    final List<Filter> filters = List<Filter>();
    filters.add(Filter(
      name: 'idCountry',
      comparator: '==',
      value: country.id,
      limit: 5,
    ));
    return filters;
  }

  Future<Country> _findCurrentCountry() async {
    Country country = await _dbRepository.get(DbKeys.country);
    if(country != null)
      return country;

    return await _loadCurrentCountry();
  }

  Future<Country> _loadCurrentCountry() async {
    Profile profile = await _dbRepository.get(DbKeys.profile);
    Country country = await _countryRepository.findOne(id: profile.idCountry);
    await _dbRepository.put(DbKeys.country, country);

    return country;
  }

  Future<Country> _updateCurrentCountry(Country oldCountry, Country newCountry) async {
    newCountry = newCountry.copyWith(
      id: oldCountry.id,
      name: oldCountry.name,
      risk: oldCountry.risk,
      riskFree: oldCountry.riskFree,
      riskLow: oldCountry.riskLow,
      riskHigh: oldCountry.riskHigh,
    );

    return newCountry;
  }
}