import 'package:meta/meta.dart';

class BorrowingInfo {
  final int id;
  final int bookId;
  final int borrowerId;
  final int deadline;
  final int borrowTime;
  bool isReturned;
  int returnTime;

  BorrowingInfo({
    this.id,
    this.returnTime,
    this.isReturned = false,
    @required this.bookId,
    @required this.borrowerId,
    @required this.deadline,
    @required this.borrowTime,
  });

  factory BorrowingInfo.fromMap(Map<String, dynamic> map) {
    return BorrowingInfo(
      id: map['id'],
      bookId: map['book_id'],
      borrowerId: map['borrower_id'],
      deadline: map['deadline'],
      returnTime: map['return_time'],
      borrowTime: map['borrow_time'],
      isReturned: (map['returned'] == 1),
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'book_id': bookId,
      'borrower_id': borrowerId,
      'deadline': deadline,
      'return_time': returnTime,
      'borrow_time': borrowTime,
      'returned': (isReturned ? 1 : 0),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BorrowingInfo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          bookId == other.bookId &&
          borrowerId == other.borrowerId &&
          deadline == other.deadline &&
          returnTime == other.returnTime &&
          borrowTime == other.borrowTime &&
          isReturned == other.isReturned;

  @override
  int get hashCode =>
      id.hashCode ^
      bookId.hashCode ^
      borrowerId.hashCode ^
      deadline.hashCode ^
      returnTime.hashCode ^
      borrowTime.hashCode ^
      isReturned.hashCode;

  @override
  String toString() {
    return 'BorrowingInfo{id: $id, bookId: $bookId, borrowerId: $borrowerId, deadline: $deadline, returnTime: $returnTime, borrowTime: $borrowTime, isReturned: $isReturned}';
  }
}
