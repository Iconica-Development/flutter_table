import "package:flutter/material.dart";

/// [FlutterTableTheme] is a class that defines the theme of a table.
class FlutterTableTheme {
  /// [FlutterTableTheme] is a class that defines the theme of a table.
  const FlutterTableTheme({
    required this.headerBackgroundColor,
    required this.headerTextStyle,
    required this.headerBorderColor,
    required this.headerIconColor,
    required this.rowBackgroundColor,
    required this.rowTextStyle,
    required this.rowBorderColor,
    required this.rowIconColor,
    required this.tableTitle,
    required this.exportButton,
    required this.paginationButtonColor,
    required this.paginationText,
    required this.searchIcon,
    required this.searchCloseIcon,
    required this.searchDecoration,
  });

  /// An empty [FlutterTableTheme].
  factory FlutterTableTheme.empty() => const FlutterTableTheme(
        headerBackgroundColor: Colors.transparent,
        headerTextStyle: TextStyle(),
        headerBorderColor: Colors.transparent,
        headerIconColor: Colors.transparent,
        rowBackgroundColor: Colors.transparent,
        rowTextStyle: TextStyle(),
        rowBorderColor: Colors.transparent,
        rowIconColor: Colors.transparent,
        tableTitle: TextStyle(),
        exportButton: TextStyle(),
        paginationButtonColor: Colors.transparent,
        paginationText: TextStyle(),
        searchIcon: Colors.transparent,
        searchCloseIcon: Colors.transparent,
        searchDecoration: InputDecoration(),
      );

  /// A standard [FlutterTableTheme].
  /// This theme uses the default theme of the [BuildContext].
  factory FlutterTableTheme.standard(BuildContext context) => FlutterTableTheme(
        headerBackgroundColor: Theme.of(context).primaryColor,
        headerTextStyle:
            Theme.of(context).textTheme.headlineSmall ?? const TextStyle(),
        headerBorderColor: Theme.of(context).dividerColor,
        headerIconColor: Theme.of(context).iconTheme.color ?? Colors.black,
        rowBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        rowTextStyle:
            Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
        rowBorderColor: Theme.of(context).dividerColor,
        rowIconColor: Theme.of(context).iconTheme.color ?? Colors.black,
        tableTitle:
            Theme.of(context).textTheme.headlineMedium ?? const TextStyle(),
        exportButton:
            Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
        paginationButtonColor: Theme.of(context).primaryColor,
        paginationText:
            Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
        searchIcon: Theme.of(context).iconTheme.color ?? Colors.black,
        searchCloseIcon: Theme.of(context).iconTheme.color ?? Colors.black,
        searchDecoration: InputDecoration(
          hintText: "Search",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );

  /// Background color of the header.
  final Color headerBackgroundColor;

  /// Text style of the header.
  final TextStyle headerTextStyle;

  /// Border color of the header.
  final Color headerBorderColor;

  /// Icon color of the header.
  final Color headerIconColor;

  /// Background color of the row.
  final Color rowBackgroundColor;

  /// Text style of the row.
  final TextStyle rowTextStyle;

  /// Border color of the row.
  final Color rowBorderColor;

  /// Icon color of the row.
  final Color rowIconColor;

  /// Text style of the table title.
  final TextStyle tableTitle;

  /// Text style of the export button.
  final TextStyle exportButton;

  /// Color of the pagination button.
  final Color paginationButtonColor;

  /// Text style of the pagination text.
  final TextStyle paginationText;

  /// Color of the search icon.
  final Color searchIcon;

  /// Color of the search close icon.
  final Color searchCloseIcon;

  /// Decoration of the search field.
  final InputDecoration searchDecoration;

  /// Copies the current [FlutterTableTheme] with some changes.
  FlutterTableTheme copyWith({
    Color? headerBackgroundColor,
    TextStyle? headerTextStyle,
    Color? headerBorderColor,
    Color? headerIconColor,
    Color? rowBackgroundColor,
    TextStyle? rowTextStyle,
    Color? rowBorderColor,
    Color? rowIconColor,
    TextStyle? tableTitle,
    TextStyle? exportButton,
    Color? paginationButtonColor,
    TextStyle? paginationText,
    Color? searchIcon,
    Color? searchCloseIcon,
    InputDecoration? searchDecoration,
  }) =>
      FlutterTableTheme(
        headerBackgroundColor:
            headerBackgroundColor ?? this.headerBackgroundColor,
        headerTextStyle: headerTextStyle ?? this.headerTextStyle,
        headerBorderColor: headerBorderColor ?? this.headerBorderColor,
        headerIconColor: headerIconColor ?? this.headerIconColor,
        rowBackgroundColor: rowBackgroundColor ?? this.rowBackgroundColor,
        rowTextStyle: rowTextStyle ?? this.rowTextStyle,
        rowBorderColor: rowBorderColor ?? this.rowBorderColor,
        rowIconColor: rowIconColor ?? this.rowIconColor,
        tableTitle: tableTitle ?? this.tableTitle,
        exportButton: exportButton ?? this.exportButton,
        paginationButtonColor:
            paginationButtonColor ?? this.paginationButtonColor,
        paginationText: paginationText ?? this.paginationText,
        searchIcon: searchIcon ?? this.searchIcon,
        searchCloseIcon: searchCloseIcon ?? this.searchCloseIcon,
        searchDecoration: searchDecoration ?? this.searchDecoration,
      );
}
