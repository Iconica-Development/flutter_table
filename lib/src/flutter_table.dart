import "package:flutter/material.dart";
import "package:flutter_table/src/models/table_definition.dart";
import "package:flutter_table/src/models/table_item_model.dart";
import "package:flutter_table/src/models/table_theme.dart";
import "package:flutter_table/src/widgets/header.dart";
import "package:flutter_table/src/widgets/row.dart";

/// [FlutterTable] is a widget that displays a table.
/// Make sure to define generic type [T] as a subclass of [TableItemModel].
class FlutterTable<T extends TableItemModel> extends StatefulWidget {
  /// [FlutterTable] is a widget that displays a table.
  /// Make sure to define generic type [T] as a subclass of [TableItemModel].
  /// [data] is a list of items to display in the table.
  /// [tableDefinition] is a [TableDefinition] that defines
  /// the structure of the table.
  /// [onPageChanged] is a function that returns a list of
  /// items based on a page number.
  /// [rowBuilder] is a function that builds the widget for a row.
  /// [theme] is a [FlutterTableTheme] that defines the theme of the table.
  /// ```dart
  /// FlutterTable<MyData>(
  ///   tableDefinition: TableDefinition<MyData>(
  ///     title: 'My Table',
  ///     columns: [
  ///       TableColumn<MyData>(
  ///         name: 'Title',
  ///         size: 1,
  ///         itemBuilder: (context, item) => Text(
  ///           item?.data['Title'],
  ///         ),
  ///       ),
  ///       TableColumn<MyData>(
  ///         name: 'Size',
  ///         size: 1,
  ///         itemBuilder: (context, item) {
  ///           return Text(
  ///             item?.data['Size'],
  ///           );
  ///         },
  ///       ),
  ///     ],
  ///   ),
  ///   data: data,
  /// ),
  /// ```
  const FlutterTable({
    required this.data,
    required this.tableDefinition,
    this.onPageChanged,
    this.rowBuilder,
    this.theme,
    super.key,
  });

  final List<T> data;
  final TableDefinition<T> tableDefinition;
  final FlutterTableTheme? theme;
  final Widget Function(BuildContext context, T item)? rowBuilder;
  final Future<List<T>> Function(int page)? onPageChanged;

  @override
  State<FlutterTable<T>> createState() => _FlutterTableState<T>();
}

class _FlutterTableState<T extends TableItemModel>
    extends State<FlutterTable<T>> {
  int currentPage = 0;
  bool isSearching = false;
  bool isFiltered = false;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  late List<T> data;
  List<T> _previousData = [];
  List<T> _previousFilteredData = [];
  Map<String, dynamic> sortedDescending = <String, dynamic>{};

  FlutterTableTheme? theme;

  @override
  void initState() {
    data = widget.data;
    if (widget.tableDefinition.searchable) {
      searchController.addListener(_listener);
    }
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        theme = widget.theme ?? FlutterTableTheme.standard(context);
      });
    });
  }

  @override
  void dispose() {
    if (widget.tableDefinition.searchable) {
      searchController.removeListener(_listener);
    }
    searchController.dispose();
    super.dispose();
  }

  void _listener() {
    setState(() {
      if (searchController.text.isEmpty) {
        data = List.from(_previousData);
        return;
      }

      if (widget.tableDefinition.onSearch != null) {
        data = widget.tableDefinition.onSearch!.call(searchController.text);
        return;
      }

      search(searchController.text);
    });
  }

  void search(String query, [List<T>? resetData]) {
    if (resetData != null) {
      _previousData = List.from(resetData);
    }

    data = _previousData
        .where(
          (element) => element.data.values.any(
            (element) => element.toString().contains(searchController.text),
          ),
        )
        .toList();
  }

  void filter(List<T> filteredItems) {
    _previousFilteredData = List.from(data);
    data = filteredItems;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (theme == null) {
      return const SizedBox();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.tableDefinition.searchable && isSearching
              ? Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: searchFocusNode,
                        controller: searchController,
                        decoration: theme!.searchDecoration,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    InkWell(
                      onTap: () {
                        setState(() {
                          searchController.clear();
                          isSearching = !isSearching;
                          searchFocusNode.unfocus();
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: theme!.searchCloseIcon,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      widget.tableDefinition.title ?? "",
                    ),
                    const Spacer(),
                    if (widget.tableDefinition.export != null) ...[
                      widget.tableDefinition.exportButton?.call(
                            context,
                            widget.tableDefinition.export!,
                          ) ??
                          OutlinedButton(
                            onPressed: () =>
                                widget.tableDefinition.export!(data),
                            child: const Text("Export"),
                          ),
                    ],
                    if (widget.tableDefinition.searchable) ...[
                      const SizedBox(width: 16.0),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _previousData = List.from(data);
                            isSearching = !isSearching;
                            searchFocusNode.requestFocus();
                          });
                        },
                        child: Icon(Icons.search, color: theme!.searchIcon),
                      ),
                    ],
                  ],
                ),
        ),
        FlutterTableHeader<T>(
          isSearching: isSearching,
          onSort: (value) {
            // ignore: avoid_dynamic_calls
            var descending = !(sortedDescending[value.name] ?? false);
            sortedDescending = {
              ...widget.tableDefinition.sortOnMultipleColumns
                  ? sortedDescending
                  : {},
              ...{
                value.name: descending,
              },
            };

            if (value.onSort != null) {
              if (isFiltered) {
                var sortedItems = List.from(value.onSort!.call(descending));

                if (isSearching) {
                  sortedItems.removeWhere((e) => !_previousData.contains(e));
                } else {
                  sortedItems.removeWhere((e) => !data.contains(e));
                }

                data = List.from(sortedItems);
                search(searchController.text, data);
              } else {
                data = value.onSort!.call(descending);
                search(searchController.text, data);
              }
            }

            setState(() {});
          },
          onFilter: (items) {
            isFiltered = true;
            filter(items);
            setState(() {});
          },
          resetFilter: () {
            isFiltered = false;
            data = List.from(_previousFilteredData);
            sortedDescending = {};
            _previousFilteredData = [];
            setState(() {});
          },
          isFiltered: isFiltered,
          sortedDescending: sortedDescending,
          theme: theme!,
          tableDefinition: widget.tableDefinition,
          padding: widget.tableDefinition.tableHeaderPadding,
        ),
        for (var item in data) ...[
          widget.rowBuilder?.call(context, item) ??
              FlutterTableRow(
                theme: theme!,
                onTap: item.onTap,
                padding: widget.tableDefinition.tableRowPadding,
                data: item,
                tableDefinition: widget.tableDefinition,
              ),
        ],
        if (widget.onPageChanged != null) ...[
          const SizedBox(height: 8.0),
          widget.tableDefinition.paginationButtons
                  ?.call(context, widget.onPageChanged!) ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (currentPage != 0) ...[
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          theme!.paginationButtonColor,
                        ),
                      ),
                      onPressed: () async {
                        currentPage = currentPage - 1;
                        var newData = await widget.onPageChanged!(currentPage);
                        if (isFiltered &&
                            widget.tableDefinition.onFilter != null) {
                          var newFilteredData =
                              await widget.tableDefinition.onFilter!.call();
                          filter(newFilteredData);
                          _previousFilteredData = List.from(newData);
                        } else {
                          data = List.from(newData);
                        }

                        search(searchController.text, data);

                        setState(() {});
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 16.0),
                  ],
                  Text(
                    (currentPage + 1).toString(),
                    style: theme!.paginationText,
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        theme!.paginationButtonColor,
                      ),
                    ),
                    onPressed: () async {
                      currentPage = currentPage + 1;
                      var newData = await widget.onPageChanged!(currentPage);
                      if (isFiltered &&
                          widget.tableDefinition.onFilter != null) {
                        var newFilteredData =
                            await widget.tableDefinition.onFilter!.call();
                        filter(newFilteredData);
                        _previousFilteredData = List.from(newData);
                      } else {
                        data = List.from(newData);
                      }

                      search(searchController.text, data);

                      setState(() {});
                    },
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
        ],
      ],
    );
  }
}
