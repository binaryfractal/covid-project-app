import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/core/service_locator.dart';
import 'package:covidapp/src/models/country.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/models/user.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_country_state/state-list.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ProfileFormBloc extends FormBloc<Profile, String> {
  final AuthenticationRepository _authenticationRepository;
  final ProfileRepository _profileRepository;
  final DbRepository _dbRepository;

  final Profile _profile;

  final name = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final age = TextFieldBloc();

  Validator<String> _age(
      TextFieldBloc age
      ){
    return (String message) {
      String message = 'La edad no es valida.';
      if(age.value == null)
        return message;

      if(double.parse(age.value) == null) {
        return message;
      }

      return null;
    };
  }

  final gender = TextFieldBloc();

  final zip = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final ztate = SelectFieldBloc(
    items: _getStates()..sort((a,b) => a.compareTo(b)),
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final town = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  ProfileFormBloc({
    @required AuthenticationRepository authenticationRepository,
    @required ProfileRepository profileRepository,
    @required DbRepository dbRepository,
    Profile profile,
  }) :  _authenticationRepository = authenticationRepository,
        _profileRepository = profileRepository,
        _dbRepository = dbRepository,
        _profile = profile
  {
    addFieldBlocs(fieldBlocs: [
      name,
      age,
      gender,
      zip,
      ztate,
      town,
    ]);

    age..addValidators([_age(age)]);
    _fillFields();
  }

  @override
  void onSubmitting() async {
    await Future<void>.delayed(Duration(seconds: 1));
    emitLoading();
    try {
      if(gender.value == null || gender.value.isEmpty){
        emitFailure(failureResponse: "profile_snackbar_failure_gender");
        return;
      }
      Profile profile = await _buildProfile();
      await _profileRepository.save(profile: profile);
      await _dbRepository.put(DbKeys.profile, profile);
      emitSuccess(successResponse: profile);
    } catch(e) {
      emitFailure(failureResponse: 'profile_snackbar_failure');
    }
  }

  Future<Profile> _buildProfile() async {
    Country country = await _dbRepository.get(DbKeys.country);
    User user = await _authenticationRepository.getCurrentUser();
    return Profile(
        uid: user.id,
        name: name.value,
        age: double.parse(age.value),
        idCountry:  country.id,
        country: country.name,
        email: user.email,
        gender: gender.value,
        state: ztate.value,
        town: town.value,
        zip: zip.value,
        surveys: []
    );
  }

  _fillFields() {
    if(_profile != null) {
      if(_profile.name != null)
        if(_profile.name.isNotEmpty)
          name.updateInitialValue(_profile.name);

      if(_profile.age != null)
        if(!_profile.age.isNaN)
          age.updateInitialValue(_profile.age.toString());

      if(_profile.gender != null)
        if(_profile.gender.isNotEmpty)
          gender.updateInitialValue(_profile.gender);

      if(_profile.state != null)
        if(_profile.state.isNotEmpty)
          ztate.updateInitialValue(_profile.state);

      if(_profile.town != null)
        if(_profile.town.isNotEmpty)
          town.updateInitialValue(_profile.town);

      if(_profile.zip != null)
        if(_profile.zip.isNotEmpty)
          zip.updateInitialValue(_profile.zip);
    }
  }

  static List<String> _getStates() {
    DbRepository dbRepository = repositoryLocator.get<DbRepository>();
    Country _country = dbRepository.get(DbKeys.country);
    var x = null;
    if (_country == null) {
      return [];
    }
    if (_country.nameApi == 'Mexico') {
      return Mexico.States;
    }
    if (_country.nameApi == 'Spain') {
      return Spain.States;
    }
    if (_country.nameApi == 'Argentina') {
      return Argentina.States;
    }
    if (_country.nameApi == 'Bolivia') {
      return Bolivia.States;
    }
    if (_country.nameApi == 'Chile') {
      return Chile.States;
    }
    if (_country.nameApi == 'Colombia') {
      return Colombia.States;
    }
    if (_country.nameApi == 'Costa Rica') {
      return CostaRica.States;
    }
    if (_country.nameApi == 'Cuba') {
      return Cuba.States;
    }
    if (_country.nameApi == 'Dominican Republic') {
      return DominicanRepublic.States;
    }
    if (_country.nameApi == 'Ecuador') {
      return Ecuador.States;
    }
    if (_country.nameApi == 'El Salvador') {
      return ElSalvador.States;
    }
    if (_country.nameApi == 'Equatorial Guinea') {
      return EquatorialGuinea.States;
    }
    if (_country.nameApi == 'Guatemala') {
      return Guatemala.States;
    }
    if (_country.nameApi == 'Honduras') {
      return Honduras.States;
    }
    if (_country.nameApi == 'Nicaragua') {
      return Nicaragua.States;
    }
    if (_country.nameApi == 'Panama') {
      return Panama.States;
    }
    if (_country.nameApi == 'Paraguay') {
      return Paraguay.States;
    }
    if (_country.nameApi == 'Peru') {
      return Peru.States;
    }
    if (_country.nameApi == 'Uruguay') {
      return Uruguay.States;
    }
    if (_country.nameApi == 'Venezuela') {
      return Venezuela.States;
    }
    return [];
  }
}