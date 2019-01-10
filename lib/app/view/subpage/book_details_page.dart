import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_app/app/controller/book_controller.dart';
import 'package:library_app/app/model/entity/book.dart';

BookController _bookController = BookController();

class AddBookPage extends StatefulWidget {
  final Book thisBook;

  AddBookPage(this.thisBook, {Key key}) : super(key: key);

  static const String routeName = '/add-book';

  @override
  AddBookPageState createState() => AddBookPageState();
}

class TmpBook {
  int isbn;
  String title;
  String publish_time;
  String author;
  String brief;
  int amount;
  String press;
}

class AddBookPageState extends State<AddBookPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TmpBook tmpBook = TmpBook();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  void _handleSubmitted() async {
    final form = _formKey.currentState;
    form.save();
    Book updateOrNewBook = Book(
      id: widget.thisBook?.id,
      isbn: tmpBook.isbn,
      amount: tmpBook.amount,
      author: tmpBook.author,
      brief: tmpBook.brief,
      press: tmpBook.press,
      publish_time: tmpBook.publish_time,
      title: tmpBook.title,
    );
    bool result = false;
    if (widget.thisBook != null) {
      result = await _bookController.modifyByBook(updateOrNewBook);
    } else {
      result = await _bookController.add(updateOrNewBook);
    }
    showInSnackBar('提交成功');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('添加/修改书籍'),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 24.0),
                TextFormField(
                  initialValue: widget.thisBook?.isbn.toString() ?? "",
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.confirmation_number),
                    hintText: '听说这个号是书的唯一标示~',
                    labelText: 'ISBN',
                  ),
                  onSaved: (String value) {
                    tmpBook.isbn = int.tryParse(value);
                  },
                ),
                SizedBox(height: 24.0),
                // Book.title
                TextFormField(
                  initialValue: widget.thisBook?.title ?? "",
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.book),
                    hintText: '这本书叫啥么名字啊? =￣ω￣= ',
                    labelText: '书名',
                  ),
                  onSaved: (String value) {
                    tmpBook.title = value;
                  },
                ),
                SizedBox(height: 24.0),
                // Book.author
                TextFormField(
                  initialValue: widget.thisBook?.author ?? "",
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.people),
                    hintText: '哇,这个作者很厉害~',
                    labelText: '作者',
                  ),
                  // keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    tmpBook.author = value;
                  },
                ),
                SizedBox(height: 24.0),
                // Book.press
                TextFormField(
                  initialValue: widget.thisBook?.press ?? "",
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.home),
                    hintText: '来自何门何派~',
                    labelText: '出版社',
                  ),
                  onSaved: (String value) {
                    tmpBook.press = value;
                  },
                ),
                SizedBox(height: 24.0),
                // Book.publish_time
                TextFormField(
                  initialValue: widget.thisBook?.publish_time ?? "",
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.access_time),
                    hintText: '蛋生日期 ;-)',
                    labelText: '出版时间',
                  ),
                  onSaved: (String value) {
                    tmpBook.publish_time = value;
                  },
                  // 合法验证
                  // validator: _validateName,
                ),
                // Book.publish_time
                SizedBox(height: 24.0),
                TextFormField(
                  initialValue: widget.thisBook?.amount.toString() ?? "",
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.airport_shuttle),
                    hintText: '又来了多少小伙伴',
                    labelText: '进书数量',
                  ),
                  onSaved: (String value) {
                    tmpBook.amount = int.tryParse(value);
                  },
                ),
                // Book.publish_time
                SizedBox(height: 24.0),
                // Book.brief
                TextFormField(
                  initialValue: widget.thisBook?.brief ?? "",
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    hintText: '简洁,简介,傻傻分不清楚~',
                    helperText: '这本书讲了啥,说了啥,算了随便写吧(逃',
                    labelText: '简介',
                  ),
                  maxLines: 3,
                  onSaved: (String value) {
                    tmpBook.brief = value;
                  },
                ),
                const SizedBox(height: 24.0),
                Center(
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    child: const Text(
                      '提交',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _handleSubmitted,
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
