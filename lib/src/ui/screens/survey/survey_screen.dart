import 'package:covidapp/src/blocs/survey/survey_form_bloc.dart';
import 'package:covidapp/src/core/service_locator.dart';
import 'package:covidapp/src/models/question.dart';
import 'package:covidapp/src/models/risk.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/resources/profile/profile_repository.dart';
import 'package:covidapp/src/resources/survey/survey_repository.dart';
import 'package:covidapp/src/ui/screens/survey/widgets/survey_succes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SurveyScreen extends StatelessWidget {
  SurveyScreen({Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SurveyFormBloc(
              surveyRepository: repositoryLocator.get<SurveyRepository>(),
              profileRepository: repositoryLocator.get<ProfileRepository>(),
              dbRepository: repositoryLocator.get<DbRepository>()),
      child: Builder(
        builder: (context) {
          // ignore: close_sinks
          final surveyFormBloc = context.bloc<SurveyFormBloc>();
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            child: Scaffold(
              appBar: AppBar(title: Text('Check up')),
              body: FormBlocListener<SurveyFormBloc, Risk, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);
                  if(state.stepCompleted == state.lastStep){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return SurveySuccessWidget(
                            risk: state.successResponse,
                            dbRepository: repositoryLocator.get<DbRepository>(),
                          );
                        })
                    );
                  }
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                  child: BlocBuilder<SurveyFormBloc, FormBlocState>(
                    condition: (previous, current) =>
                    previous.runtimeType != current.runtimeType ||
                        previous is FormBlocLoading && current is FormBlocLoading,
                    builder: (context, state) {
                      if (state is FormBlocLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is FormBlocLoadFailed) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.sentiment_dissatisfied, size: 70),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  alignment: Alignment.center,
                                  child: Text(
                                    state.failureResponse ??
                                        'An error has occurred please try again later',
                                    style: TextStyle(fontSize: 25),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 20),
                                RaisedButton(
                                  onPressed: surveyFormBloc.reload,
                                  child: Text('RETRY'),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              BlocBuilder<SurveyFormBloc, FormBlocState>(
                                builder: (context, state) {
                                  return StepperFormBlocBuilder<SurveyFormBloc>(
                                    type: StepperType.vertical,
                                    physics: ClampingScrollPhysics(),
                                    stepsBuilder: (state) {
                                      final stepList = List<FormBlocStep>();
                                      for (int i = 0; i < state.state.numberOfSteps; i++) {
                                        final values = state.state.fieldBlocs(i);
                                        stepList.add(
                                          FormBlocStep(
                                            title: getContainerTitle(values.keys.first, context),
                                            content: Column(
                                              children: values.map((k2,v2) => MapEntry(k2, getFieldBloc(k2, v2, values.keys.first))
                                              ).values.toList(),
                                            ),
                                          ),
                                        );
                                      }
                                      return stepList;
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getFieldBloc(String key, fieldBloc, String first) {
    if (fieldBloc
    is TextFieldBloc<Question>) {
      return TextFieldBlocBuilder(
        textFieldBloc: fieldBloc,
        decoration: InputDecoration(
            labelText: key.compareTo(first) == 0 ? null : key
        ),
      );
    } else if (fieldBloc
    is MultiSelectFieldBloc<String,
        Question>) {
      return CheckboxGroupFieldBlocBuilder(
        enableOnlyWhenFormBlocCanSubmit: false,
        multiSelectFieldBloc: fieldBloc,
        itemBuilder: (context, value) =>
        value,
        decoration: InputDecoration(
          labelText: key.compareTo(first) == 0 ? null : key,
        ),
      );
    } else if (fieldBloc is SelectFieldBloc<
        String,
        Question>) {
      if(key.compareTo(first) == 0){
        return RadioButtonGroupFieldBlocBuilder(
          selectFieldBloc: fieldBloc,
          itemBuilder: (context, value) =>
          value,
        );
      } else {
        return Column(
          children: <Widget>[
            Divider(),
            Builder(
              builder: (context) => getContainerTitle(key, context, Colors.black),),
            RadioButtonGroupFieldBlocBuilder(
              selectFieldBloc: fieldBloc,
              itemBuilder: (context, value) =>
              value,
            )
          ],
        );
      }
    }
    return SizedBox();
  }

  Widget getContainerTitle(String text, BuildContext context, [Color color]) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * .7,
      child: Text(text,
        overflow: TextOverflow.ellipsis,
        maxLines: 3, style: TextStyle(fontSize: MediaQuery
            .of(context)
            .size
            .aspectRatio * 33, color: color),
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (_) => LoadingDialog(key: key),
  ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

