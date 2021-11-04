import 'package:converssor_moedas/commons/erros.dart';

class ValueIsNullFailure extends Failure {
  @override
  final String? message;

  ValueIsNullFailure({
    this.message,
  });
}

class NegativeValueFailure extends Failure {
  @override
  final String? message;

  NegativeValueFailure({
    this.message,
  });
}

class InvalidNumberFailure extends Failure {
  @override
  final String? message;

  InvalidNumberFailure({
    this.message,
  });
}
