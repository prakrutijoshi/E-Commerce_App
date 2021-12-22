import 'package:bloc/bloc.dart';
import 'package:e_shop/data/model/shipping_address_model.dart';
import 'package:e_shop/data/model/user_model.dart';
import 'package:e_shop/domain/usecases/user_usecases/add_user_data_usecase.dart';
import 'package:e_shop/domain/usecases/user_usecases/get_user_by_id_usecase.dart';
import 'package:e_shop/domain/usecases/user_usecases/update_user_data_usecase.dart';
import 'package:equatable/equatable.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final GetUserByIdUseCase getUserByIdUseCase;
  final AddUserDataUseCase addUserDataUseCase;
  final UpdateUserDataUseCase updateUserDataUseCase;

  AddressCubit({
    required this.getUserByIdUseCase,
    required this.addUserDataUseCase,
    required this.updateUserDataUseCase,
  }) : super(AddressInitial());

  Future<void> addNewAddress(
      String uid, ShippingAddressModel newAddress) async {
    emit(AddressLoading());
    try {
      var userInfo = await getUserByIdUseCase.call(uid);
      var addresses = userInfo.addresses;
      addresses.add(newAddress);
      var newAddresses = addresses as List<ShippingAddressModel>;
      var user = userInfo as UserModel;
      var updatedUser = user.cloneWith(addresses: newAddresses);
      await updateUserDataUseCase.call(updatedUser);
      emit(AddressUpdated());
    } catch (e) {
      emit(AddressError('error'));
    }
  }

  Future<void> getAddresses(String uid) async {
    emit(AddressLoading());
    try {
      var userInfo = await getUserByIdUseCase.call(uid);
      var addresses = userInfo.addresses;
      emit(AddressLoaded(addresses as List<ShippingAddressModel>));
    } catch (e) {
      emit(AddressError('failed to load the addreses'));
    }
  }
}
