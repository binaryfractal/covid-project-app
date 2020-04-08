import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';

class ForgotPasswordFormBloc extends FormBloc<String, String> {
  final AuthenticationRepository _authenticationRepository;

  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  ForgotPasswordFormBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository
  {
    addFieldBlocs(
      fieldBlocs: [
        email,
      ]
    );
  }

  @override
  void onSubmitting() async {
    emitLoading();
    try {
      await _authenticationRepository.forgotPassword(email: email.value);
      emitSuccess();
    } catch(_) {
      emitFailure(
        failureResponse: 'forgot_password_snackbar_failure',
      );
    }
  }
}