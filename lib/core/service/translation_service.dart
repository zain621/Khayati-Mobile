import 'package:dio/dio.dart';

/// Lightweight translation service using MyMemory API (free, no key required).
/// Used to auto-translate Arabic product names to English and Urdu.
class TranslationService {
  // ignore: unused_field
  final Dio _dio;

  TranslationService(this._dio);

  static const String _baseUrl = 'https://api.mymemory.translated.net/get';

  // Single reused Dio instance so the TCP connection is kept alive between
  // calls — avoids the latency/failure on the very first cold request.
  static final _translationDio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  /// Translate [text] from Arabic to English and Urdu simultaneously.
  /// Returns a record with [en] and [ur] fields.
  /// Never throws — returns empty strings on any failure.
  Future<({String en, String ur})> translate(String text) async {
    if (text.trim().isEmpty) return (en: '', ur: '');
    try {
      final results = await Future.wait([
        _translate(text, 'ar', 'en'),
        _translate(text, 'ar', 'ur'),
      ]);
      return (en: results[0], ur: results[1]);
    } catch (_) {
      return (en: '', ur: '');
    }
  }

  Future<String> _translate(String text, String from, String to) async {
    try {
      final response = await _translationDio.get<Map<String, dynamic>>(
        _baseUrl,
        queryParameters: {
          'q': text,
          'langpair': '$from|$to',
        },
      );
      final responseData = response.data?['responseData'] as Map<String, dynamic>?;
      final translated = responseData?['translatedText'] as String?;
      return translated ?? '';
    } catch (_) {
      return '';
    }
  }
}
