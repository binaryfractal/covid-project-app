abstract class LocalizationRepository {
  Future<bool> load();

  String translate(String key);
}