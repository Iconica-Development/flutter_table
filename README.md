[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart) 

Use this package to display tables in your application

## Setup

Add ```flutter_table``` to your ```pubspec.yaml``` file.

## How to use

```dart
 FlutterTable<MyData>(
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
``` 

Make sure to define a class that extends ```TableItemModel``` like this
```dart
class MyData extends TableItemModel {
  MyData({
    required super.data,
    super.onTap,
  });
}

```

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_table) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](../CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_table/pulls).

## Author

This flutter_table package for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>