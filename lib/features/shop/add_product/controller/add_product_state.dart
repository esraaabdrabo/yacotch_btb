part of 'add_product_cubit.dart';

@immutable
abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductLoading extends AddProductState {}

class AddProductLoaded extends AddProductState {}

class AddProductError extends AddProductState {}

class GetCategoryLoading extends AddProductState {}

class GetCategoryLoaded extends AddProductState {}

class UploadSignUpFileState extends AddProductState {}

class ProductImageSelected extends AddProductState {}

class UploadImageLoading extends AddProductState {}

class UploadImageLoaded extends AddProductState {}
