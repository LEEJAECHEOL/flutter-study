import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyRow(),
    );
  }
}


class MyRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Row"),
      ),
      body: MyWidget()
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                    Icons.account_circle, size: 50, color: Colors.red,)
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Flutter Study',
                    style: Theme.of(context).textTheme.headline),
                Text('플러터 간단히 공부해보자 ㅎㅎ!! '),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('공부'),
            Text('Flutter'),
          ],
        ),
        SizedBox(height: 16),
        Row(children: [],),
        SizedBox(height: 8,),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(child: Icon(Icons.favorite),flex: 1,fit: FlexFit.tight,),
            Flexible(child: Icon(Icons.favorite),flex: 1,fit: FlexFit.tight),
            Flexible(child: Icon(Icons.favorite),flex: 1,fit: FlexFit.tight),
            Flexible(child: Icon(Icons.favorite),flex: 1,fit: FlexFit.tight),
          ],
        )
      ],
    );
  }
}
