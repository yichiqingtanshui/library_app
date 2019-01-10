import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_app/app/model/entity/borrower.dart';

class AddBorrowerPage extends StatefulWidget {
  final Borrower thisBorrower;

  AddBorrowerPage(this.thisBorrower, {Key key}) : super(key: key);

  static const String routeName = '/add-borrower';

  @override
  AddBorrowerPageState createState() => AddBorrowerPageState();
}

class PersonData {
  String name = '';
  String phoneNumber = '';
  String email = '';
  String password = '';
}

class AddBorrowerPageState extends State<AddBorrowerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PersonData person = PersonData();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  bool _autovalidate = false;

  void _handleSubmitted() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('借阅人的信息'),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          autovalidate: _autovalidate,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 24.0),
                // Book.isbn
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.contacts),
                    hintText: '输入借阅人的名字',
                    labelText: '姓名',
                  ),
                  onSaved: (String value) {
                    //TODO: 保存isbn
                    // person.phoneNumber = value;
                  },
                  // validator: _validatePhoneNumber,
                  // TextInputFormatters are applied in sequence.
                  // inputFormatters: <TextInputFormatter>[
                  //   WhitelistingTextInputFormatter.digitsOnly,
                  //   // Fit the validating format.
                  //   _phoneNumberFormatter,
                  // ],
                ),
                SizedBox(height: 24.0),
                // Book.title
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.supervised_user_circle),
                    hintText: '输入你的性别',
                    labelText: '性别',
                  ),
                  onSaved: (String value) {
                    //TODO: 保存书名
                    // person.name = value;
                  },
                  // 合法验证
                  // validator: _validateName,
                ),
                SizedBox(height: 24.0),
                // Book.author
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.format_list_numbered),
                    hintText: '输入你的卡号',
                    labelText: '身份证号',
                  ),
                  // keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    //TODO: author
                    // person.email = value;
                  },
                ),
                SizedBox(height: 24.0),
                // Book.press
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.class_),
                    hintText: '你是哪个系的',
                    labelText: '系别',
                  ),
                  onSaved: (String value) {
                    //TODO: 保存出版社
                    // person.name = value;
                  },
                  // 合法验证
                  // validator: _validateName,
                ),
                SizedBox(height: 24.0),
                // Book.publish_time
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.chrome_reader_mode),
                    hintText: '你是哪个年级的)',
                    labelText: '年级',
                  ),
                  onSaved: (String value) {
                    //TODO: 保存出版时间
                    // person.name = value;
                  },
                  // 合法验证
                  // validator: _validateName,
                ),
                const SizedBox(height: 24.0),
                Center(
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    child: const Text(
                      '添加',
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
