import 'package:example/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_table/flutter_table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MyData> data = [];

  @override
  void initState() {
    data.add(
      MyData(
        data: {
          'Title': '1',
          'Size': '4',
        },
        onTap: () {},
      ),
    );
    data.add(
      MyData(
        data: {
          'Title': '2',
          'Size': '5',
        },
      ),
    );
    data.add(
      MyData(
        data: {
          'Title': '3',
          'Size': '6',
        },
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: FlutterTable<MyData>(
                tableDefinition: TableDefinition<MyData>(
                  title: 'My Table',
                  columns: [
                    TableColumn<MyData>(
                      name: 'Title',
                      size: 1,
                      itemBuilder: (context, item) => Text(
                        item?.data['Title'],
                      ),
                    ),
                    TableColumn<MyData>(
                      name: 'Size',
                      size: 1,
                      itemBuilder: (context, item) {
                        return Text(
                          item?.data['Size'],
                        );
                      },
                    ),
                  ],
                ),
                data: data,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyData extends TableItemModel {
  MyData({
    required super.data,
    super.onTap,
  });
}
