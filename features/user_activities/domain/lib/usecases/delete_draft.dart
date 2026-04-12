import 'package:core/core.dart';
import 'package:user_activities_domain/repositories/user_activities_repository.dart';

class DeleteDraft extends UseCase<int, Result<void>> {
  final UserActivitiesRepository _userActivitiesRepository;

  DeleteDraft(this._userActivitiesRepository);

  @override
  Future<Result<void>> call([int? params]) async =>
      _userActivitiesRepository.deleteDraft(movieId: params ?? 0);
}
