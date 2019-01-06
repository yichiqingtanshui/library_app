import 'package:library_app/app/model/dao/book_dao.dart';
import 'package:library_app/app/model/entity/book.dart';

class BookController {
  static BookDao dao = BookDao();

  /// 添加新的书籍
  Future<bool> add(Book book) async {
    return dao.add(book);
  }

  /// 通过book_id删除相应书籍
  Future<bool> removeById(int id) async {
    return await dao.remove(id);
  }

  /// 修改书籍信息
  Future<bool> modifyByBook(Book book) async {
    return await dao.update(book);
  }

  /// 获取所有书籍信息列表
  Future<List<Book>> fetchAll() async {
    return await dao.findAll();
  }
}
