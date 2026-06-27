import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback? detail;
  final VoidCallback? edit;
  final VoidCallback? hapus;

  const ActionButtons({
    super.key,
    this.detail,
    this.edit,
    this.hapus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        if (detail != null)
          IconButton(
            tooltip: "Detail",
            icon: const Icon(Icons.visibility, color: Colors.blue),
            onPressed: detail,
          ),

        if (edit != null)
          IconButton(
            tooltip: "Edit",
            icon: const Icon(Icons.edit, color: Colors.orange),
            onPressed: edit,
          ),

        if (hapus != null)
          IconButton(
            tooltip: "Hapus",
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: hapus,
          ),
      ],
    );
  }
}