import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';

class SignUpFormBloc extends FormBloc<String, String> {
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

  ///[accepted] = Accept the terms and conditions
  final accepted = BooleanFieldBloc();

  SignUpFormBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository
  {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
        accepted,
      ],
    );
  }

  @override
  void onSubmitting() async {
    emitLoading();
    try {
      if(accepted.value) {
        await _authenticationRepository.signUp(
          email: email.value,
          password: password.value,
        );
        emitSuccess();
      } else {
        emitFailure(
          failureResponse: 'sign_up_label_error_terms_and_conditions',
        );
      }
    } catch(_) {
      emitFailure(
          failureResponse: 'sign_up_snackbar_failure'
      );
    }
  }
}