import 'package:meta/meta.dart';

class Book {
  final int id;
  final int isbn;
  final String title;
  final String publish_time;
  final String author;
  final String brief;
  final int amount;
  final String press;

  Book(
      {@required this.id,
      this.isbn,
      this.title,
      this.publish_time,
      this.author,
      this.brief,
      this.amount,
      this.press});

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
        id: map['id'],
        isbn: map['isbn'],
        title: map['title'],
        publish_time: map['publish_time'],
        amount: map['amount'],
        author: map['author'],
        brief: map['brief'],
        press: map['press']);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'isbn': isbn,
      'title': title,
      'publish_time': publish_time,
      'amount': amount,
      'author': author,
      'brief': brief,
      'press': press
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          isbn == other.isbn &&
          title == other.title &&
          publish_time == other.publish_time &&
          author == other.author &&
          brief == other.brief &&
          amount == other.amount &&
          press == other.press;

  @override
  int get hashCode =>
      id.hashCode ^
      isbn.hashCode ^
      title.hashCode ^
      publish_time.hashCode ^
      author.hashCode ^
      brief.hashCode ^
      amount.hashCode ^
      press.hashCode;

  @override
  String toString() {
    return 'Book{id: $id, isbn: $isbn, title: $title, publish_time: $publish_time, author: $author, brief: $brief, amount: $amount, press: $press}';
  }
}
