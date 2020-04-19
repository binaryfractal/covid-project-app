import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covidapp/src/core/db_keys.dart';
import 'package:covidapp/src/models/profile.dart';
import 'package:covidapp/src/models/user.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:covidapp/src/ui/screens/version/version.dart';
import 'package:meta/meta.dart';

import 'authentication_base.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final ProfileRepository _profileRepository;
  final DbRepository _dbRepository;

  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
    @required ProfileRepository profileRepository,
    @required DbRepository dbRepository,
  })
    : assert(authenticationRepository != null),
      assert(profileRepository != null),
      assert(dbRepository != null),
      _authenticationRepository = authenticationRepository,
      _profileRepository = profileRepository,
      _dbRepository = dbRepository;

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    yield AuthenticationLoadInProgress();
    if (event == AuthenticationEvent.AuthenticationAppStarted) {
      yield* _mapAuthenticationAppStartedToState();
    } else if (event == AuthenticationEvent.AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event == AuthenticationEvent.AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationAppStartedToState() async* {
    try {
      bool isValidVersion = await Version.isValidVersion();
      if(!isValidVersion){
        yield AuthenticationVersionFailure();
        return;
      }
      final bool isSignedIn = await _authenticationRepository.isSignedIn();
      if(isSignedIn) {
        final Profile profile = await _dbRepository.get(DbKeys.profile);
        yield AuthenticationSuccess(profile);
      } else {
        yield AuthenticationFailure();
      }
    } catch(_) {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    User user = await _authenticationRepository.getCurrentUser();
    Profile profile = await _profileRepository.findOne(uid: user.id);
    await _dbRepository.put(DbKeys.profile, profile);

    yield AuthenticationSuccess(profile);
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    await _dbRepository.delete(DbKeys.profile);
    await _dbRepository.delete(DbKeys.country);
    await _dbRepository.delete(DbKeys.profiles);
    await _dbRepository.delete(DbKeys.last_update);
    await _authenticationRepository.signOut();
    yield AuthenticationFailure();
  }
}
