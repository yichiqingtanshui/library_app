import 'package:meta/meta.dart';

class Result {
  bool state;
  String message;

  Result({
    @required this.state,
    @required this.message,
  });

  @override
  String toString() {
    return '{state: $state, message: $message}';
  }
}
