import 'package:meta/meta.dart';

class Borrower {
  final int id;
  final String name;
  final String sex;
  final int cardNumber;
  final String department;
  final String grade;
  bool canBorrow;

  Borrower({
    this.id,
    this.name,
    this.sex,
    this.department,
    this.grade,
    this.canBorrow = true,
    @required this.cardNumber,
  });

  factory Borrower.fromMap(Map<String, dynamic> map) {
    return Borrower(
      id: map['id'],
      name: map['name'],
      sex: map['sex'],
      department: map['department'],
      grade: map['grade'],
      cardNumber: map['card_number'],
      canBorrow: map['can_borrow'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'sex': sex,
      'department': department,
      'grade': grade,
      'can_borrow': (canBorrow ? 1 : 0),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Borrower &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          sex == other.sex &&
          cardNumber == other.cardNumber &&
          department == other.department &&
          grade == other.grade &&
          canBorrow == other.canBorrow;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      sex.hashCode ^
      cardNumber.hashCode ^
      department.hashCode ^
      grade.hashCode ^
      canBorrow.hashCode;

  @override
  String toString() {
    return 'Borrower{id: $id, name: $name, sex: $sex, cardNumber: $cardNumber, department: $department, grade: $grade, canBorrow: $canBorrow}';
  }
}
