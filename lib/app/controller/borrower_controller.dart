import 'package:library_app/app/model/dao/borrower_dao.dart';
import 'package:library_app/app/model/entity/borrower.dart';

class BorrowerController {
  static BorrowerDao dao = BorrowerDao();

  /// 添加新的借阅人
  Future<bool> add(Borrower borrower) async {
    return dao.add(borrower);
  }

  /// 通过borrower_id删除相应借阅人
  Future<bool> removeById(int id) async {
    return await dao.remove(id);
  }

  /// 修改借阅人信息
  Future<bool> modifyByBorrower(Borrower borrower) async {
    return await dao.update(borrower);
  }

  /// 获取所有借阅人信息列表
  Future<List<Borrower>> fetchAll() async {
    return await dao.findAll();
  }

  /// 通过借阅人姓名搜索相应借阅人
  Future<List<Borrower>> searchByName(String name) async {
    return await dao.findByName(name, isBlurred: true);
  }
}
