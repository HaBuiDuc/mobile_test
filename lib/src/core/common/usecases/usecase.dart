import 'package:fpdart/fpdart.dart';
import 'package:mobile_test/src/core/errors/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}