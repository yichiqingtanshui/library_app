import 'package:library_app/app/model/dao/book_dao.dart';
import 'package:library_app/app/model/dao/borrower_dao.dart';
import 'package:library_app/app/model/dao/borrowing_info_dao.dart';
import 'package:library_app/app/model/entity/book.dart';
import 'package:library_app/app/model/entity/borrower.dart';
import 'package:library_app/app/model/entity/borrowing_info.dart';

class BookManagerController {
  static BorrowingInfoDao borrowingInfoDao = BorrowingInfoDao();
  static BorrowerDao borrowerDao = BorrowerDao();
  static BookDao bookDao = BookDao();

  /// 办理借书卡
  Future<bool> transactCard(Borrower borrower) async {
    return await borrowerDao.add(borrower);
  }

  /// 借书
  borrowBookById(int bookId) async {
    // 1. 判断是否有借书资格

    // 2. 判断书籍存量是否满足借阅条件

    // 3. 结果回馈
  }

  /// 还书
  returnBookById(int bookId) async {
    // 1. 更新相应表

    // 2. 检查是否超期

    // 3. 结果回馈
  }
}

// TODO: 表示借还书的返回类型定义
