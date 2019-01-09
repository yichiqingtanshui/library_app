import 'package:flutter/material.dart';
import 'package:library_app/app/controller/book_controller.dart';
import 'package:library_app/app/model/entity/book.dart';
import 'package:library_app/app/view/raw_view/subpage/add_book_page.dart';

final BookController _bookController = BookController();

class BookManagerPage extends StatefulWidget {
  BookManagerPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BookManagerPageState();
}

class BookManagerPageState extends State<BookManagerPage> {
  final _BooksSearchDelegate _delegate = _BooksSearchDelegate();

  Future<ListView> _booksBuilder() async {
    // 1.获取当前所有馆藏书籍
    List<Book> books = await _bookController.fetchAll();

    // 2.把数据实体(Model或Entity)转换为Widget
    List<ListTile> booksWidget = books
        .map(
          (book) => ListTile(
                title: Text(book.title),
                subtitle: Text('${book.author} : ${book.isbn}'),
                onTap: () => print('你摁了 ${book.title} !'),
              ),
        )
        .toList();

    // 3. 返还 booksWidget
    return ListView(
      children: booksWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text('图书管理'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            // onPressed: () => print('你摁了搜索按钮!'),
            onPressed: () async {
              final int selected = await showSearch<int>(
                context: context,
                delegate: _delegate,
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _booksBuilder().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return Container(
              child: Text('┗|｀O′|┛ 嗷~~ 一本书都没有'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: '添加书籍',
        // onPressed: () => print('BookManagerPage : 你摁下了这个悬浮按钮'),
        onPressed: () {
          Navigator.of(context).pushNamed(TextFormFieldDemo.routeName);
        },
      ),
    );
  }
}

class _BooksSearchDelegate extends SearchDelegate<int> {
  /* 搜索栏左边: 退回上个页面 */
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  /* 搜索栏右边: 填写时显示清空按钮*/
  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isEmpty) {
      return null;
    } else {
      return <Widget>[
        IconButton(
          tooltip: '清空',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
      ];
    }
  }

  /* 编写建议 */
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Center(
      child: Text('请输入需要查找的书名'),
    );
  }

  /* 查找结果列表 */
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return StreamBuilder(
      stream: _resultBuilder().asStream(),
      builder: (_, snapshot) {
        if (query.isNotEmpty && snapshot.hasData) {
          return snapshot.data;
        } else {
          return Container(
            child: Text('┗|｀O′|┛ 嗷~~ 一本书都搜不到'),
          );
        }
      },
    );
  }

  Future<ListView> _resultBuilder() async {
    List<Book> searchedBooks = await _bookController.searchByTitle(query);

    List<ListTile> searchedBooksWidget = searchedBooks
        .map((book) => ListTile(
              title: Text(book.title),
            ))
        .toList();

    return ListView(
      children: searchedBooksWidget,
    );
  }
}
