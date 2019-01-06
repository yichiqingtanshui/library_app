import 'package:library_app/app/model/dao/book_dao.dart';
import 'package:library_app/app/model/dao/borrower_dao.dart';
import 'package:library_app/app/model/dao/borrowing_info_dao.dart';
import 'package:library_app/app/model/entity/book.dart';
import 'package:library_app/app/model/entity/borrower.dart';
import 'package:library_app/app/model/entity/borrowing_info.dart';
import 'package:library_app/util/result.dart';

class BookManagerController {
  static BorrowingInfoDao borrowingInfoDao = BorrowingInfoDao();
  static BorrowerDao borrowerDao = BorrowerDao();
  static BookDao bookDao = BookDao();

  /// 办理借书卡
  Future<bool> transactCard(Borrower borrower) async {
    return await borrowerDao.add(borrower);
  }

  /// 获取所有借阅书籍
  Future<List<Map<Book, BorrowingInfo>>> retrieveAllBorrowedBooks(
      Borrower borrower) async {
    List<BorrowingInfo> all = await bookDao.findByBorrower(borrower);
    List<Map<Book, BorrowingInfo>> books = [];
    all.forEach((info) async {
      Map<Book, BorrowingInfo> relation = {
        (await bookDao.find(info.bookId)): info
      };
      books.add(relation);
    });
    return books;
  }

  /// 借书
  Future<Result> borrowBookById(int borrowerId, int bookId) async {
    // 1. 判断是否有借书资格
    Borrower borrower = await borrowerDao.find(borrowerId);
    if (!borrower.canBorrow) {
      return Result(
        state: false,
        message: '该借阅者没有借书资格',
      );
    }

    // 2. 判断书籍存量是否满足借阅条件
    Book book = await bookDao.find(bookId);
    List<BorrowingInfo> all = await borrowingInfoDao.findByBook(book);
    int remain = book.amount - all.length;
    if (remain > 0) {
      var now = DateTime.now();
      var borrowTime = DateTime(now.year, now.month, now.day);
      BorrowingInfo borrowingInfo = BorrowingInfo(
        id: all.length + 1,
        bookId: book.id,
        borrowerId: borrower.id,
        borrowTime: now.millisecondsSinceEpoch,
        deadline: borrowTime.millisecondsSinceEpoch,
      );
      bool state = await borrowingInfoDao.add(borrowingInfo);

      return Result(
        state: state,
        message: state ? '借阅成功' : '数据库操作失败,请联系管理员',
      );
    } else {
      return Result(
        state: false,
        message: '抱歉,该书馆藏不足',
      );
    }
  }

  /// 还书
  returnBookById(int borrowerId, int bookId) async {
    // 1. 更新相应表

    // 2. 检查是否超期

    // 3. 结果回馈
  }
}
