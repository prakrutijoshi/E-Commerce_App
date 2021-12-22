import '../../entities/seller_entity.dart';
import '../../repositories/firebase_auth_repository.dart';

class SignUpUseCase {
  final FirebaseAuthRepository repository;

  SignUpUseCase(this.repository);

  Future<void> call(SellerEntity newSeller, String password) async {
    await repository.signUp(newSeller, password);
  }
}
