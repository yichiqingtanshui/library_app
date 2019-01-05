# library_app MVC

# View
1. 能展现所有的书籍
2. 能修改指定书籍相关信息
3. 能删除书籍
6. 能展现所有借阅人
7. 能修改借阅人信息
8. 能删除借阅人
9. 能办理借书卡(创建新借阅人)

# Controller
1. 返还书籍列表
`.fetchAllBooks() -> List<Book>`  
2. 更改书籍的相应信息,返还是否成功
`.modifyBookInfo(bookId: int, updatingInfo: Map<String,dynamic> ) -> bool`
3. 删除指定书籍,返还是否成功
`.removeBookById(bookId: int) -> bool`
6. 返还用户(借阅人)列表
`.fetchAllBorrowers() -> List<Borrower>`
7. 更改用户(借阅人)的相应信息,返还是否成功
`.modifyBorrowerInfo(borrowerId: int, updatingInfo: Map<String,dynamic> ) -> bool`
8. 删除指定用户,返还是否成功
`.removeBorrowerById(BorrowerId: int) -> bool`
9. 插入借阅人信息,返还是否成功
`.transactCard(borrower: Borrower) -> bool`

# Model


# DB 禁用词语
```
"add","all","alter","and","as","autoincrement",
"between",
"case","check","collate","commit","constraint","create",
"default","deferrable","delete","distinct","drop",
"else","escape","except","exists",
"foreign","from",
"group",
"having",
"if","in","index","insert","intersect","into","is","isnull",
"join",
"limit",
"not","notnull","null",
"on","or","order",
"primary",
"references",
"select","set",
"table","then","to","transaction",
"union","unique","update","using",
"values",
"when","where"
```

# 项目结构

```bash
lib
├──   app
│   ├──   controller
│   │   └──   not_implemented.todo
│   ├──   model
│   │   ├──   dao
│   │   │   ├──   book_dao.dart
│   │   │   └──   dao.dart
│   │   └──   entity
│   │       ├──   book.dart
│   │       └──   borrower.dart
│   └──   view
│       └──   not_implemented.todo
├──   config
│   └──   app_database.dart
├──   util
│   ├──   helper_db_functions.dart
│   └──   helper_log.dart
└──main.dart

8 directories, 10 files
```