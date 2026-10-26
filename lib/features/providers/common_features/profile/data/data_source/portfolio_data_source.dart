import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';

abstract class PortfolioDataSource {
  Future<void> addImages(List<File> images);
  Future<void> deleteImage(String imageId);
  Future<void> addSpecialization(String name);
  Future<void> deleteSpecialization(String specializationId);
}

class PortfolioDataSourceImplement implements PortfolioDataSource {
  final AppService _appService;
  final AppSettingsPrefs _prefs;

  PortfolioDataSourceImplement(this._appService, this._prefs);

  bool get _isComprehensive => _prefs.getUserRole() == 'comprehensive_tailor';

  @override
  Future<void> addImages(List<File> images) async {
    final parts = <MultipartFile>[];
    for (final file in images) {
      parts.add(await _toCompressedMultipart(file));
    }
    if (_isComprehensive) {
      await _appService.addComprehensiveTailorPortfolioImages(parts);
    } else {
      await _appService.addIndependentTailorPortfolioImages(parts);
    }
  }

  /// Compresses an image to a web-friendly size before upload and wraps it in a
  /// [MultipartFile] with an explicit filename + content type.
  ///
  /// Raw phone photos (often several MB, sometimes HEIC) are the usual reason a
  /// portfolio upload times out or is rejected — compressing to JPEG/PNG keeps
  /// the request small and in a format the backend reliably accepts. Mirrors the
  /// product-image upload flow.
  Future<MultipartFile> _toCompressedMultipart(File file) async {
    final ext = file.path.split('.').last.toLowerCase();
    final bool isPng = ext == 'png';
    final bool isWebp = ext == 'webp';
    final String subtype = isPng ? 'png' : (isWebp ? 'webp' : 'jpeg');
    final CompressFormat format =
        isPng ? CompressFormat.png : (isWebp ? CompressFormat.webp : CompressFormat.jpeg);

    Uint8List? compressed;
    try {
      compressed = await FlutterImageCompress.compressWithFile(
        file.path,
        quality: 75,
        minWidth: 1080,
        minHeight: 1080,
        format: format,
      );
    } catch (_) {
      compressed = null;
    }

    final Uint8List bytes = compressed ?? await file.readAsBytes();
    final String baseName = file.uri.pathSegments.isNotEmpty
        ? file.uri.pathSegments.last
        : 'portfolio.$subtype';

    return MultipartFile.fromBytes(
      bytes,
      filename: baseName,
      contentType: DioMediaType('image', subtype),
    );
  }

  @override
  Future<void> deleteImage(String imageId) async {
    if (_isComprehensive) {
      await _appService.deleteComprehensiveTailorPortfolioImage(imageId);
    } else {
      await _appService.deleteIndependentTailorPortfolioImage(imageId);
    }
  }

  @override
  Future<void> addSpecialization(String name) async {
    if (_isComprehensive) {
      await _appService.addComprehensiveTailorSpecialization(name);
    } else {
      await _appService.addIndependentTailorSpecialization(name);
    }
  }

  @override
  Future<void> deleteSpecialization(String specializationId) async {
    if (_isComprehensive) {
      await _appService.deleteComprehensiveTailorSpecialization(specializationId);
    } else {
      await _appService.deleteIndependentTailorSpecialization(specializationId);
    }
  }
}
