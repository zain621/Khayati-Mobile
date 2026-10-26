import 'dart:io';
import 'dart:typed_data';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

abstract class UpdateProviderProfileDataSource {
  Future<void> updateTailorProfile({
    required String fullName,
    String? bio,
    File? image,
  });

  Future<void> updateShopProfile({
    required String nameAr,
    required String nameEn,
    String? bio,
    File? image,
    File? coverImage,
  });
}

class UpdateProviderProfileDataSourceImplement
    implements UpdateProviderProfileDataSource {
  final AppService _appService;
  final AppSettingsPrefs _prefs;

  UpdateProviderProfileDataSourceImplement(this._appService, this._prefs);

  bool get _isComprehensive => _prefs.getUserRole() == 'comprehensive_tailor';

  @override
  Future<void> updateTailorProfile({
    required String fullName,
    String? bio,
    File? image,
  }) async {
    final imagePart = await _toProfileImagePart(
      image,
      fallbackName: 'tailor-profile.jpg',
    );

    final imageParts = imagePart == null ? null : [imagePart];

    if (_isComprehensive) {
      await _appService.updateComprehensiveTailorProfile(
        fullName,
        bio,
        imageParts,
      );
    } else {
      await _appService.updateIndependentTailorProfile(
        fullName,
        bio,
        imageParts,
      );
    }
  }

  @override
  Future<void> updateShopProfile({
    required String nameAr,
    required String nameEn,
    String? bio,
    File? image,
    File? coverImage,
  }) async {
    final imagePart = await _toProfileImagePart(
      image,
      fallbackName: 'shop-profile.jpg',
    );
    final coverImagePart = await _toProfileImagePart(
      coverImage,
      fallbackName: 'shop-cover.jpg',
      minWidth: 1920,
      minHeight: 640,
    );

    await _appService.updateShopOwnerShop(
      nameAr,
      nameEn,
      bio,
      imagePart == null ? null : [imagePart],
      coverImagePart == null ? null : [coverImagePart],
    );
  }

  Future<MultipartFile?> _toProfileImagePart(
    File? file, {
    required String fallbackName,
    int minWidth = 1024,
    int minHeight = 1024,
  }) async {
    if (file == null) return null;

    Uint8List? compressed;
    try {
      compressed = await FlutterImageCompress.compressWithFile(
        file.path,
        quality: 82,
        minWidth: minWidth,
        minHeight: minHeight,
        format: CompressFormat.jpeg,
      );
    } catch (_) {
      compressed = null;
    }

    if (compressed != null && compressed.isNotEmpty) {
      return MultipartFile.fromBytes(
        compressed,
        filename: fallbackName,
        contentType: DioMediaType('image', 'jpeg'),
      );
    }

    final extension = file.path.split('.').last.toLowerCase();
    final subtype = switch (extension) {
      'jpg' || 'jpeg' => 'jpeg',
      'png' => 'png',
      'webp' => 'webp',
      'gif' => 'gif',
      _ => null,
    };

    if (subtype == null) {
      return null;
    }

    final filename = file.path.split(Platform.pathSeparator).last;
    return MultipartFile.fromFile(
      file.path,
      filename: filename,
      contentType: DioMediaType('image', subtype),
    );
  }
}
