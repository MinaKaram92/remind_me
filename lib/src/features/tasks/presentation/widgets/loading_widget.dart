import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_todo_app/src/core/app_cubit/app_cubit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppCubit.get(context).isDark ? Colors.black : Colors.white,
      child: Center(
          child: CircularProgressIndicator(
        color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
      )),
    );
  }
}
