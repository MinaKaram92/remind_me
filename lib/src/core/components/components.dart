import 'package:flutter/material.dart';

import '../error/failures.dart';

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget goBack(context) {
  return IconButton(
    icon: const Icon(Icons.arrow_back_ios_new),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}

String errorMessage(Failure failure) {
  if (failure.runtimeType == CacheFailure) {
    return 'There is something wrong, please try again later.';
  } else {
    return 'Unexpected error, please try again later';
  }
}

customSnackBar(
  context, {
  required String message,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color,
    shape: const RoundedRectangleBorder(),
    duration: const Duration(seconds: 2),
  ));
}
