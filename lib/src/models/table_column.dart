import "package:flutter/material.dart";

/// [TableColumn] is a class that defines the structure of a column in a table.
/// Make sure to define generic type [T] as a subclass of [TableItemModel].
class TableColumn<T> {
  /// [TableColumn] is a class that defines the structure 
  /// of a column in a table.
  /// Make sure to define generic type [T] as a subclass of [TableItemModel].
  TableColumn({
    required this.name,
    required this.size,
    this.itemBuilder,
    this.onSort,
  });

  /// Name of the column.
  final String name;

  /// Size of the column.
  /// This is used to determine the width of the column using a [Flex] widget.
  final int size;

  /// Function that returns a list of items based on a sort query.
  /// Make sure to define generic type [T] as a subclass of [TableItemModel].
  /// If null, the column is not sortable.
  final List<T> Function(bool)? onSort;

  /// Function that builds the widget for the column.
  /// Make sure to define generic type [T] as a subclass of [TableItemModel].
  final Widget Function(BuildContext context, T? item)? itemBuilder;
}
