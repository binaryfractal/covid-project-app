import 'package:country_code_picker/country_code_picker.dart';
import 'package:covidapp/src/blocs/country_selector/country_selector_base.dart';
import 'package:covidapp/src/core/custom_localization.dart';
import 'package:covidapp/src/ui/widgets/app_raised_rounded_button/app_raised_rounded_button_widget.dart';
import 'package:covidapp/src/ui/widgets/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryPickerWidget extends StatelessWidget {
  final List<String> countriesCode;

  CountryPickerWidget({@required this.countriesCode});

  @override
  Widget build(BuildContext context) {
    final CountrySelectorBloc countrySelectorBloc = BlocProvider.of<CountrySelectorBloc>(context);
    final double widthFramePicker = MediaQuery.of(context).size.width / 10;
    final double heightContainer = (MediaQuery.of(context).size.height / 5.0) * 2.0;
    final double heightButton = ((MediaQuery.of(context).size.height / 5.0) * 2.0) / 6.0;
    final double widthSpace = MediaQuery.of(context).size.width / 6.0;
    String countryCode = 'MX';

    return Container(
      height: heightContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: HexColor('FFC3BFC7')),
              borderRadius: BorderRadius.circular(18.0),
              color: Colors.white,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width - widthFramePicker,
              child: CountryCodePicker(
                countryFilter: countriesCode,
                onChanged: (country) {
                  countryCode = country.code;
                },
                initialSelection: countryCode,
                showCountryOnly: true,
                showFlagMain: true,
                flagWidth: (MediaQuery.of(context).size.aspectRatio * 200)
                    .truncateToDouble(),
                showOnlyCountryWhenClosed: true,
                favorite: [countryCode, 'ES'],
              ),
            ),
          ),
          AppRaisedRoundedButtonWidget(
            height: heightButton,
            width: MediaQuery.of(context).size.width - widthSpace,
            text: CustomLocalization.of(context).translate('country_selector_button'),
            onPressed: () {
              countrySelectorBloc.add(CountrySelectorSelected(countryCode));
            },
          ),
        ],
      ),
    );
  }
}