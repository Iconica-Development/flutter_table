import "package:flutter/material.dart";
import "package:flutter_table/flutter_table.dart";

class FlutterTableRow<T extends TableItemModel> extends StatelessWidget {
  const FlutterTableRow({
    required this.tableDefinition,
    required this.theme,
    this.data,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
    super.key,
  });

  final T? data;
  final TableDefinition<T> tableDefinition;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final FlutterTableTheme theme;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: theme.rowBackgroundColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              border: Border.all(
                width: 1.0,
                color: theme.rowBorderColor,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...tableDefinition.columns.map(
                  (e) => Expanded(
                    flex: e.size,
                    child: e.itemBuilder?.call(context, data) ??
                        Text(
                          data?.data[e.name],
                          style: theme.rowTextStyle,
                        ),
                  ),
                ),
                if (onTap != null) ...[
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 20,
                    height: 20,
                    child: Icon(
                      Icons.chevron_right,
                      color: theme.rowIconColor,
                    ),
                  ),
                ] else ...[
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 20,
                    height: 20,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}
