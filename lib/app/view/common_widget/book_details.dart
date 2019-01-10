import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  BookDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图书详情'),
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Back',
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                  'https://img1.doubanio.com/view/subject/l/public/s27329267.jpg'),
            ),
          )
        ],
      ),
    );
  }
}
