import 'package:qalbu/domain/repositories/doa_repository.dart';

class GetFavoriteStatusDoa {
  final DoaRepository doaRepository;

  GetFavoriteStatusDoa(this.doaRepository);

  Future<bool> execute(String id) async {
    return doaRepository.isAddedToFavorite(id);
  }
}
