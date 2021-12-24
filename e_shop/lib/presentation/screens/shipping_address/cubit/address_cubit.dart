import 'package:bloc/bloc.dart';
import '../../../../data/model/shipping_address_model.dart';
import '../../../../data/model/user_model.dart';
import '../../../../domain/usecases/auth_usecases/logged_firebase_user_usecase.dart';
import '../../../../domain/usecases/user_usecases/add_user_data_usecase.dart';
import '../../../../domain/usecases/user_usecases/get_user_by_id_usecase.dart';
import '../../../../domain/usecases/user_usecases/update_user_data_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final GetUserByIdUseCase getUserByIdUseCase;
  final AddUserDataUseCase addUserDataUseCase;
  final UpdateUserDataUseCase updateUserDataUseCase;
  final LoggedFirebaseUserUseCase loggedFirebaseUserUseCase;

  AddressCubit({
    required this.getUserByIdUseCase,
    required this.addUserDataUseCase,
    required this.updateUserDataUseCase,
    required this.loggedFirebaseUserUseCase,
  }) : super(AddressInitial());

  Future<void> addUpdateDeleteAddress({
    required ShippingAddressModel shippingAddress,
    required ListMethod method,
  }) async {
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;
      var userInfo = await getUserByIdUseCase.call(uid);
      var addresses = userInfo.addresses as List<ShippingAddressModel>;
      if (shippingAddress.isDefault) {
        addresses =
            addresses.map((item) => item.cloneWith(isDefault: false)).toList();
      }

      // check method
      switch (method) {
        case ListMethod.ADD:
          // If current addresses is empty, so the first shipping address is always default
          if (addresses.isEmpty) {
            shippingAddress = shippingAddress.cloneWith(isDefault: true);
          }
          addresses.add(shippingAddress);
          break;

        case ListMethod.DELETE:
          addresses.remove(shippingAddress);
          break;

        case ListMethod.UPDATE:
          addresses = addresses
              .map((item) =>
                  item.aid == shippingAddress.aid ? shippingAddress : item)
              .toList();
          break;
        default:
      }

      // clone user with updated addresses
      var user = userInfo as UserModel;
      var updatedUser = user.cloneWith(addresses: addresses);

      // update user addresses
      await updateUserDataUseCase.call(updatedUser);

      emit(AddressUpdated());
    } catch (e) {
      emit(AddressError('error'));
    }
  }

  Future<void> getAddresses() async {
    emit(AddressLoading());
    try {
      User loggedUser = await loggedFirebaseUserUseCase.call();
      String uid = loggedUser.uid;
      var userInfo = await getUserByIdUseCase.call(uid);
      var addresses = userInfo.addresses;
      emit(AddressLoaded(addresses as List<ShippingAddressModel>));
    } catch (e) {
      emit(AddressError('failed to load the addreses'));
    }
  }
}

enum ListMethod { ADD, DELETE, UPDATE }
