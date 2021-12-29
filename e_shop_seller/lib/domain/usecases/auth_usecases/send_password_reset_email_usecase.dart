import '../../repositories/firebase_auth_repository.dart';

class SendPasswordResetEmailUseCase {
  final FirebaseAuthRepository repository;

  SendPasswordResetEmailUseCase({required this.repository});

  Future<void> call({required String email}) async {
    return await repository.sendPasswordResetEmail(email: email);
  }
}
