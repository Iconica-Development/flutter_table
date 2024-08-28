import "package:flutter/material.dart";

/// [TableItemModel] is a class that defines the structure of an item in a table
/// Make sure to define a class that extends this class
class TableItemModel {
  TableItemModel({
    required this.data,
    this.onTap,
  });

  /// On tap callback for the item.
  final VoidCallback? onTap;

  /// Data of the item.
  final Map<String, dynamic> data;
}
