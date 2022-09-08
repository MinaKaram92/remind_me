class Failure {}

class CacheFailure extends Failure {
  String? msg;
  CacheFailure({this.msg});
}
