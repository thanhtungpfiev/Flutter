abstract class UseCase<UseCaseType, UseCaseParams> {
  Future<UseCaseType> call({UseCaseParams params});
}
