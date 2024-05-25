import 'package:flutter/material.dart';

class MyAlertDialog {
  void showCustomAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Confirm Action',
          content: Text('Are you sure you want to proceed?'),
          confirmButtonText: 'Yes',
          cancelButtonText: 'No',
          onConfirm: () {
            // Handle the confirm action
            Navigator.of(context).pop();
          },
          onCancel: () {
            // Handle the cancel action
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.confirmButtonText,
    required this.cancelButtonText,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green.shade50,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.green.shade900,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            cancelButtonText,
            style: TextStyle(color: Colors.green.shade900),
          ),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            primary: Colors.green.shade700,
          ),
          child: Text(
            confirmButtonText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Usage

