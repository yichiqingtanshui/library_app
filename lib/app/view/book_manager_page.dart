import 'package:flutter/material.dart';
import 'package:library_app/app/model/entity/book.dart';

class BookManagerPage extends StatefulWidget {
  BookManagerPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BookManagerPageState();
}

class BookManagerPageState extends State<BookManagerPage> {
  final _SearchDemoSearchDelegate _delegate = _SearchDemoSearchDelegate();

  List<ListTile> _booksBuilder() {
    // 1.获取当前所有馆藏书籍

    List<Book> books = [
      Book(title: 'Android开发', author: '王勇勇', isbn: 666),
      Book(title: 'Linux', author: '王勇勇', isbn: 666),
      Book(title: 'C++', author: '王勇勇', isbn: 666),
    ]; // TODO:....... (获取了书籍)

    // 2.把数据实体(Model或Entity)转换为Widget
    List<ListTile> booksWidget = books
        .map(
          (book) => ListTile(
                title: Text(book.title),
                subtitle: Text('${book.author} : ${book.isbn}'),
                onTap: () => print('你嗯了 ${book.title} !'),
              ),
        )
        .toList();

    // 3. 返还 booksWidget
    return booksWidget;
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
      body: ListView(
        children: _booksBuilder(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: '添加书籍',
        // onPressed: () => print('BookManagerPage : 你摁下了这个悬浮按钮'),
        onPressed: () {
          

        },
      ),
    );
  }
}

class _SearchDemoSearchDelegate extends SearchDelegate<int> {
  final List<int> _data =
      List<int>.generate(100001, (int i) => i).reversed.toList();
  final List<int> _history = <int>[42607, 85604, 66374, 44, 174];

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

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('data');
  }

  @override
  Widget buildResults(BuildContext context) {
    final int searched = int.tryParse(query);
    if (searched == null || !_data.contains(searched)) {
      return Center(
        child: Text(
          '"$query"\n is not a valid integer between 0 and 100,000.\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('data'),
        )
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}
