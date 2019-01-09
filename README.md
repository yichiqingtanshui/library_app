# library_app MVC


# UI-TODOs:
- [ ] 添加书籍页面 `add_book_page`
    - [x] UI
    - [ ] 逻辑

# View
1. 能展现所有的书籍
2. 能修改指定书籍相关信息
3. 能删除书籍
4. 能展现所有借阅人
5. 能修改借阅人信息
6. 能删除借阅人
7. 能办理借书卡(创建新借阅人)
8. 能借书/还书
9. 能对超期还书做额外处理
10. 提供迁移和备份界面

# Controller

# Model


# 项目结构

```bash
lib
├── main.dart
├── app
│   ├── controller
│   │   ├── book_controller.dart
│   │   ├── book_manager_controller.dart
│   │   └── borrower_controller.dart
│   ├── model
│   │   ├── dao
│   │   │   ├── book_dao.dart
│   │   │   ├── borrower_dao.dart
│   │   │   ├── borrowing_info_dao.dart
│   │   │   └── interface
│   │   │       └── common_dao.dart
│   │   ├── entity
│   │   │   ├── book.dart
│   │   │   ├── borrower.dart
│   │   │   └── borrowing_info.dart
│   │   └── service
│   │       └── app_database.dart
│   └── view
│       └── not_implemented.todo
└── util
    ├── helper_db_functions.dart
    └── helper_log.dart

9 directories, 15 files
```


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
