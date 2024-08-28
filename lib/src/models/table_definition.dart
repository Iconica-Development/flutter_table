import "package:flutter/material.dart";
import "package:flutter_table/src/models/table_column.dart";
import "package:flutter_table/src/models/table_item_model.dart";

/// [TableDefinition] is a class that defines the structure of a table.
/// Make sure to define generic type [T] as a subclass of [TableItemModel].
/// [colums] is a list of [TableColumn] that defines the columns of the table.
class TableDefinition<T extends TableItemModel> {
  /// [TableDefinition] is a class that defines the structure of a table.
  /// Make sure to define generic type [T] as a subclass of [TableItemModel].
  /// [colums] is a list of [TableColumn] that defines the columns of the table.
  TableDefinition({
    required this.columns,
    this.title,
    this.export,
    this.exportButton,
    this.paginationButtons,
    this.searchable = false,
    this.onSearch,
    this.sortOnMultipleColumns = false,
    this.tableHeaderPadding = const EdgeInsets.all(16.0),
    this.tableRowPadding = const EdgeInsets.all(16.0),
  });

  /// A list of [TableColumn] that defines the columns of the table.
  /// Make sure to define generic type [T] as a subclass of [TableItemModel].
  final List<TableColumn<T>> columns;

  /// Whether to sort on multiple columns. Defaults to false (1 column).
  final bool sortOnMultipleColumns;

  /// Padding for the table header.
  final EdgeInsets tableHeaderPadding;

  /// Padding for the table rows.
  final EdgeInsets tableRowPadding;

  /// Title of the table. Defaults to null. If null, the title is not displayed.
  final String? title;

  /// Whether the table is searchable. Defaults to false.
  final bool searchable;

  /// Function that returns a list of items based on a search query.
  /// Make sure to define generic type [T] as a subclass of [TableItemModel].
  final List<T> Function(String query)? onSearch;

  /// Function that exports the table data.
  final void Function(List<T>)? export;

  /// Widget that uses the [export] function to export the table data.
  /// There is a default export button if this is null.
  final Widget Function(BuildContext context, void Function(List<T>) export)?
      exportButton;

  /// Widget that displays pagination buttons.
  /// There is a default pagination button if this is null.
  final Widget Function(BuildContext context, Function(int page) onPageChanged)?
      paginationButtons;
}
