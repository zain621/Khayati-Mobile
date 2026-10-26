import 'package:app_mobile/core/extensions/extensions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Class defined for env service to fetch values
class EnvService {
  static String getString({
    required String key,
  }) {
    var value = dotenv.env[key].onNull().trim();
    if (value.length >= 2 &&
        ((value.startsWith('"') && value.endsWith('"')) ||
            (value.startsWith("'") && value.endsWith("'")))) {
      value = value.substring(1, value.length - 1);
    }
    return value;
  }

  static Future<bool> getBool({
    required String key,
  }) async =>
      dotenv.env[key].onNullBool();
}
