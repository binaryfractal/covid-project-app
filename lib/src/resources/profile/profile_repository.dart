import 'package:covidapp/src/models/filter.dart';
import 'package:covidapp/src/models/profile.dart';

abstract class ProfileRepository {
  Future save({Profile profile});

  Future<Profile> findOne({String uid});

  Future<List<Profile>> findBy({ List<Filter> filters });
}
