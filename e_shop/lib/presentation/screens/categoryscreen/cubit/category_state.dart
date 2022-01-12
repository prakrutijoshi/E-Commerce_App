part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<ProductModel> products;
  final bool isLoading;

  const CategoryLoaded(this.products, this.isLoading);

  List<Object> get props => [products];
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError({required this.message});

  @override
  List<Object> get props => [message];
}
