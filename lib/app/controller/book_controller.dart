import '../model/dao/book_dao.dart';
import '../model/entity/book.dart';

class BookController {
  BookDao dao = BookDao();

  Future<List<Book>> fetchAll() async {
    var res = dao.findAll();
    return res;
  }

  Future<bool> modifyInfoById(int id, Map<String, dynamic> updatingInfo) async {
    return null;
  }

  Future<bool> removeById(int uniqueId) async {
    return null;
  }
}
