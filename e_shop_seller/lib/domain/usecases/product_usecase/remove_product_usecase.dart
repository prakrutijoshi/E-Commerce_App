import '../../repositories/firebase_product_repository.dart';

class RemoveProductUseCase {
  final FirebaseProductRepository repository;

  RemoveProductUseCase({required this.repository});

  Future<void> call(String pid) async {
    return await repository.removeProduct(pid);
  }
}
