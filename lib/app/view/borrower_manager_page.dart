import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:library_app/app/controller/borrower_controller.dart';
import 'package:library_app/app/model/entity/borrower.dart';
import 'package:library_app/app/view/subpage/borrower_details_page.dart';

final BorrowerController _borrowerController = BorrowerController();

class BorrowerManagerPage extends StatefulWidget {
  BorrowerManagerPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BorrowerManagerPageState();
}

class BorrowerManagerPageState extends State<BorrowerManagerPage> {
  final _BorrowersSearchDelegate _delegate = _BorrowersSearchDelegate();
  List<Slidable> _borrowersWidget = null;

  void _showSnackBar(String value) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  Future<ListView> _borrowersBuilder() async {
    List<Borrower> borrowers = await _borrowerController.fetchAll();

    _borrowersWidget = borrowers.map(
      (borrower) {
        return Slidable(
          key: Key('book${borrower.id}'),
          delegate: SlidableDrawerDelegate(),
          actionExtentRatio: 0.25,
          child: ListTile(
            key: Key(borrower.id.toString()),
            title: Text(borrower.name),
            subtitle: Text('${borrower.department} : ${borrower.cardNumber}'),
            onTap: () => print('你摁了 ${borrower.name} !'),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: '修改',
              color: Colors.indigo,
              icon: Icons.info,
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddBorrowerPage(borrower)),
                );
                setState(() {
                  _showSnackBar('修改此项 ${borrower.id}');
                });
              },
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: '删除',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () async {
                await _borrowerController.removeById(borrower.id);
                setState(() {
                  _showSnackBar('删除此项 ${borrower.id}');
                });
              },
            ),
          ],
        );
      },
    ).toList();

    // 3. 返还 booksWidget
    return ListView(
      children: _borrowersWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text('借阅人管理'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            // onPressed: () => print('你摁了搜索按钮!'),
            onPressed: () async {
              await showSearch<int>(
                context: context,
                delegate: _delegate,
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _borrowersBuilder().asStream(),
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
        tooltip: '添加借阅人',
        // onPressed: () => print('BookManagerPage : 你摁下了这个悬浮按钮'),
        onPressed: () {
          Navigator.of(context).pushNamed(AddBorrowerPage.routeName);
        },
      ),
    );
  }
}

class _BorrowersSearchDelegate extends SearchDelegate<int> {
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
    return Center(
      child: Text('请输入需要查找的书名'),
    );
  }

  /* 查找结果列表 */
  @override
  Widget buildResults(BuildContext context) {
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
    List<Borrower> searchedBooks =
        await _borrowerController.searchByName(query);

    List<ListTile> searchedBooksWidget = searchedBooks
        .map((book) => ListTile(
              title: Text(book.name),
            ))
        .toList();

    return ListView(
      children: searchedBooksWidget,
    );
  }
}
