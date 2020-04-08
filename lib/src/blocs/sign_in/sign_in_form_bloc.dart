import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';

class SignInFormBloc extends FormBloc<String, String> {
  final AuthenticationRepository _authenticationRepository;

  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.passwordMin6Chars,
    ]
  );

  SignInFormBloc({
    @required AuthenticationRepository authenticationRepository
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository
  {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
      ],
    );
  }

  @override
  void onSubmitting() async {
    emitLoading();
    try {
      await _authenticationRepository.signIn(
        email: email.value,
        password: password.value,
      );
      emitSuccess();
    } catch(_) {
      emitFailure(
        failureResponse: 'sign_in_snackbar_failure',
      );
    }
  }
}