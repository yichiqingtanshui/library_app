import '../model/dao/book_dao.dart';
import '../model/entity/book.dart';

class BookController {
  BookDao dao = BookDao();

  Future<List<Book>> fetchAll() async {
    return await dao.findAll();
  }

  Future<bool> modifyInfoById(Book book) async {
    return await dao.update(book);
  }

  Future<bool> removeById(int id) async {
    return await dao.remove(id);
  }
}
