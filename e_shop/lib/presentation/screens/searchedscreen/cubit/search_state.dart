part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductModel> results;

  const SearchLoaded(this.results);

  List<Object> get props => [results];
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});

  @override
  List<Object> get props => [message];
}
