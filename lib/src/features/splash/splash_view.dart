import 'package:flutter/material.dart';
import 'package:simple_todo_app/src/config/routes/route_manager.dart';
import 'package:simple_todo_app/src/core/app_cubit/app_cubit.dart';
import 'package:simple_todo_app/src/core/resources/assets_manager.dart';
import 'package:simple_todo_app/src/core/resources/strings_manager.dart';
import 'package:simple_todo_app/src/core/resources/values_manager.dart';
import '../../core/resources/constants_manager.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: AppConstants.splashTime), () {
      if (AppConstants.boardingFinished != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.remindMeLayoutRoute, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.onBoardingRoute, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppCubit.get(context).isDark ? Colors.black : Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringsManager.splashTitle,
                style: Theme.of(context).textTheme.headline3,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppPadding.p50),
                child: Image(
                    width: AppSize.s300,
                    height: AppSize.s300,
                    image: AssetImage(ImageAssets.splashImage)),
              ),
              Text(StringsManager.splashBody,
                  style: Theme.of(context).textTheme.headline5),
              const SizedBox(
                height: AppSize.s50,
              ),
              CircularProgressIndicator(
                color:
                    AppCubit.get(context).isDark ? Colors.white : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
