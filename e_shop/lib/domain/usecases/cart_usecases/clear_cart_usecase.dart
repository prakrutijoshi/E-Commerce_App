import '../../repositories/firebase_cart_repository.dart';

class ClearCartUseCase {
  final FirebaseCartRepository repository;

  ClearCartUseCase({required this.repository});

  Future<void> call(String uid) async {
    return await repository.clearCart(uid);
  }
}
