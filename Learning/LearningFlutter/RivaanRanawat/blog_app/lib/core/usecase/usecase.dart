abstract class UseCase<UsecaseType, UsecaseParams> {
  Future<UsecaseType> call({UsecaseParams params});
}
