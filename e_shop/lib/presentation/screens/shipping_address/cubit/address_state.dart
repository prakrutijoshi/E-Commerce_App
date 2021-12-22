part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState{}

class AddressLoaded extends AddressState{
  final List<ShippingAddressModel> addresses;

  const AddressLoaded(this.addresses);

  List<Object> get props => [addresses];
}

class AddressUpdated extends AddressState{}

class AddressError extends AddressState{
  final String message;

  AddressError(this.message);

  List<Object> get props => [message];

}
