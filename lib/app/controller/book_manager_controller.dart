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
    // 0. 判断是否有借书资格
    Borrower borrower = await borrowerDao.find(borrowerId);
    if (!borrower.canBorrow) {
      return Result(
        value: false,
        message: '该借阅者没有借书资格',
      );
    }

    // 1. 多次借同一本书情况
    List<BorrowingInfo> borrowingInfos =
        await borrowingInfoDao.findByInfo(borrowerId, bookId);
    if (borrowingInfos == null || borrowingInfos?.length == 0) {
      return Result(
        value: false,
        message: '不能同时借阅同一本书多次',
      );
    }

    // 2. 判断书籍存量是否满足借阅条件
    Book book = await bookDao.find(bookId);
    List<BorrowingInfo> all = await borrowingInfoDao.findByBook(book);
    int remain = book.amount - all.length;
    if (remain > 0) {
      var now = DateTime.now();
      var borrowTime = DateTime(now.year, now.month, now.day + 30);

      BorrowingInfo borrowingInfo = BorrowingInfo(
        borrowerId: borrower.id,
        bookId: book.id,
        borrowTime: now.millisecondsSinceEpoch,
        deadline: borrowTime.millisecondsSinceEpoch,
      );
      bool state = await borrowingInfoDao.add(borrowingInfo);

      return Result(
        value: state,
        message: state ? '借阅成功' : '数据库错误,请联系技术顾问',
      );
    } else {
      return Result(
        value: false,
        message: '抱歉,该书馆藏不足',
      );
    }
  }

  /// 还书
  Future<Result> returnBookById(int borrowerId, int bookId) async {
    // 1. 更新相应表
    Borrower borrower = await borrowerDao.find(borrowerId);
    BorrowingInfo borrowingInfo =
        (await borrowingInfoDao.findByInfo(borrowerId, bookId))[0];

    // 2. 检查是否超期
    var returnTime = DateTime.now();
    if (returnTime.millisecondsSinceEpoch > borrowingInfo.deadline) {
      // 超期
      Duration difference = returnTime.difference(
          DateTime.fromMillisecondsSinceEpoch(borrowingInfo.deadline));
      int overdueDay = difference.inDays;
      borrower.canBorrow = false;
      bool resultOfUpdatingBorrower = await borrowerDao.update(borrower);

      borrowingInfo.returnTime = returnTime.millisecondsSinceEpoch;
      borrowingInfo.isReturned = true;
      bool resultOfUpdatingBorrowingInfo =
          await borrowingInfoDao.update(borrowingInfo);
      bool result = resultOfUpdatingBorrower && resultOfUpdatingBorrowingInfo;
      return Result(
        value: result,
        message: (result ? '超期 $overdueDay 天,需要递交罚款' : '数据库错误,请联系技术顾问'),
      );
    } else {
      borrowingInfo.returnTime = returnTime.millisecondsSinceEpoch;
      borrowingInfo.isReturned = true;
      bool resultOfUpdatingBorrowingInfo =
          await borrowingInfoDao.update(borrowingInfo);
      return Result(
        value: resultOfUpdatingBorrowingInfo,
        message: (resultOfUpdatingBorrowingInfo ? '还书成功' : '数据库错误,请联系技术顾问'),
      );
    }
  }

  /// 交罚款
  Future<Result> payFine(int borrowerId) async {
    Borrower borrower = await borrowerDao.find(borrowerId);
    if (borrower.canBorrow) {
      return Result(
        value: false,
        message: '该用户不需要交罚款',
      );
    }
    bool result = await borrowerDao.update(borrower);
    // FIXME:思考其他表需不需要更新
    return Result(
      value: result,
      message: (result ? '该用户交费成功' : '数据库错误,请联系技术顾问'),
    );
  }
}
