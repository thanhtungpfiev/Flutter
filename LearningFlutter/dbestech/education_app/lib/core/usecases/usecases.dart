import 'package:education_app/core/utils/typedefs.dart';

abstract class UseCase<Type, Params> {
  const UseCase();

  ResultFuture<Type> call({Params params});
}
