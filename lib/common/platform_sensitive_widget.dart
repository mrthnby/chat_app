import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformSensitiveWidget extends StatelessWidget {
  const PlatformSensitiveWidget({super.key});

  Widget androidWidget(BuildContext context);
  Widget iosWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? androidWidget(context) : iosWidget(context);
  }
}
