import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/portfolio_repository.dart';

class AddPortfolioImagesUseCase {
  final PortfolioRepository _repository;

  AddPortfolioImagesUseCase(this._repository);

  Future<Either<Failure, void>> execute(List<File> images) async {
    return await _repository.addImages(images);
  }
}
