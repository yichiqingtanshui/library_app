import 'package:meta/meta.dart';

/// 表示多种情况的结果类型
class Result {
  /// 结果值
  bool value;

  /// 相应信息
  String message;

  Result({
    @required this.value,
    @required this.message,
  });

  @override
  String toString() {
    return '{state: $value, message: $message}';
  }
}
