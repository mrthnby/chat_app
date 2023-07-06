import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/platform_sensitive_widget.dart';

class PlatformSensitiveAlertDialog extends PlatformSensitiveWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const PlatformSensitiveAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });

  Future<bool?> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context, builder: (context) => this)
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
          );
  }

  @override
  Widget androidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(content),
      actions: actions,
    );
  }

  @override
  Widget iosWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(content),
      actions: actions,
    );
  }
}
