import "package:flutter/material.dart";

import "package:flutter_table/src/models/table_column.dart";
import "package:flutter_table/src/models/table_definition.dart";
import "package:flutter_table/src/models/table_item_model.dart";
import "package:flutter_table/src/models/table_theme.dart";

class FlutterTableHeader<T extends TableItemModel> extends StatefulWidget {
  const FlutterTableHeader({
    required this.tableDefinition,
    required this.theme,
    required this.sortedDescending,
    required this.onSort,
    this.padding = const EdgeInsets.all(16.0),
    super.key,
  });

  final TableDefinition<T> tableDefinition;
  final FlutterTableTheme theme;
  final Map<String, dynamic> sortedDescending;
  final Function(TableColumn<T>) onSort;

  final EdgeInsets padding;

  @override
  State<FlutterTableHeader<T>> createState() => _FlutterTableHeaderState<T>();
}

class _FlutterTableHeaderState<T extends TableItemModel>
    extends State<FlutterTableHeader<T>> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.theme.headerBackgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            border: Border.all(
              width: 1.0,
              color: widget.theme.headerBorderColor,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...widget.tableDefinition.columns.map(
                (e) => Expanded(
                  flex: e.size,
                  child: _HeaderItem<T>(
                    theme: widget.theme,
                    column: e,
                    onTap: widget.onSort,
                    ascending: widget.sortedDescending[e.name] ?? false,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16),
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      );
}

class _HeaderItem<T> extends StatelessWidget {
  const _HeaderItem({
    required this.theme,
    required this.column,
    required this.onTap,
    required this.ascending,
  });

  final TableColumn<T> column;
  final Function(TableColumn<T>) onTap;
  final bool ascending;
  final FlutterTableTheme theme;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          onTap(column);
        },
        child: Row(
          children: [
            Text(
              column.name.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: theme.headerTextStyle,
            ),
            if (column.onSort != null)
              Icon(
                ascending ? Icons.arrow_upward : Icons.arrow_downward,
                size: 14,
                color: theme.headerIconColor,
              ),
          ],
        ),
      );
}
