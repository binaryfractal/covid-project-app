class Url {
  static const url_covid_base = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series';
  static const url_base = 'https://{url_project}.cloudfunctions.net/api';
  static const url_confirmed = 'time_series_covid19_confirmed_global.csv';
  static const url_recovered = 'time_series_covid19_recovered_global.csv';
  static const url_deaths = 'time_series_covid19_deaths_global.csv';

  static const countries = 'countries';
  static const profiles = 'profiles';
  static const searches = 'searches';
  static const surveys = 'surveys';
  static const versions = 'versions';

  static Future<String> get(ApiUrl apiUrl) async {
    if(apiUrl == ApiUrl.countries) {
      return '$url_base/$countries';
    }

    if(apiUrl == ApiUrl.profiles) {
      return '$url_base/$profiles';
    }

    if(apiUrl == ApiUrl.searches) {
      return '$url_base/$searches';
    }

    if(apiUrl == ApiUrl.surveys) {
      return '$url_base/$surveys';
    }

    if(apiUrl == ApiUrl.versions) {
      return '$url_base/$versions';
    }

    if(apiUrl == ApiUrl.confirmed) {
      return '$url_covid_base/$url_confirmed';
    }

    if(apiUrl == ApiUrl.recovered) {
      return '$url_covid_base/$url_recovered';
    }

    if(apiUrl == ApiUrl.deaths) {
      return '$url_covid_base/$url_deaths';
    }

    throw ApiUrlException();
  }
}

enum ApiUrl {
  countries,
  profiles,
  searches,
  surveys,
  confirmed,
  recovered,
  deaths,
  versions
}

class ApiUrlException implements Exception {
  String errMsg() => 'ApiUrl not found.';
}