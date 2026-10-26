import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../../core/network/app_api.dart';
import '../request/create_order_request.dart';
import '../response/create_order_response.dart';

abstract class CreateOrderDataSource {
  Future<CreateOrderResponse> createOrder(CreateOrderRequest request);
}

class CreateOrderDataSourceImplement implements CreateOrderDataSource {
  final AppService _appService;

  CreateOrderDataSourceImplement(this._appService);

  @override
  Future<CreateOrderResponse> createOrder(CreateOrderRequest request) {
    return _appService.createOrder(
      request.productName,
      request.description,
      request.specialRequests,
      request.fabricType,
      request.deliveryDate,
      request.minExpectedBudget,
      request.maxExpectedBudget,
      request.similarImages == null ? null : _toMultipartFiles(request.similarImages!),
    );
  }

  List<MultipartFile> _toMultipartFiles(List<File> files) {
    return files.map((file) {
      final ext = file.path.split('.').last.toLowerCase();
      final subtype = ext == 'png'
          ? 'png'
          : ext == 'webp'
              ? 'webp'
              : 'jpeg';
      return MultipartFile.fromFileSync(
        file.path,
        filename: file.path.split(RegExp(r'[\/]')).last,
        contentType: MediaType('image', subtype),
      );
    }).toList();
  }
}
