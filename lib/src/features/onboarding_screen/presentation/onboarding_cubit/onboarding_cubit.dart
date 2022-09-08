import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/src/config/routes/route_manager.dart';
import 'package:simple_todo_app/src/core/resources/assets_manager.dart';
import 'package:simple_todo_app/src/features/onboarding_screen/models/onboarding_model.dart';
import 'package:simple_todo_app/src/features/onboarding_screen/presentation/onboarding_cubit/onboarding_states.dart';
import '../../../../core/helpers/local/cache_helper.dart';

class OnboardingCubit extends Cubit<OnboardingStates> {
  OnboardingCubit() : super(InitialOnboardingState());

  static OnboardingCubit get(context) => BlocProvider.of(context);

  bool islastOnboarding = false;
  double expansionFactor = 3;

  void changeOnboardingStatus({required bool islast}) {
    islastOnboarding = islast;
    emit(ChangeOnboardingStatusState());
  }

  List<OnboardingModel> onboardingModels = [
    OnboardingModel(
      image: ImageAssets.onBoardingLogo1,
      firstTextSpan: 'Remind Me ',
      secondTextSpan: 'is a simble app that helping you to remind your tasks',
    ),
    OnboardingModel(
      image: ImageAssets.onBoardingLogo2,
      text: 'You can update tasks as completed tasks after you finished it',
    ),
    OnboardingModel(
      image: ImageAssets.onBoardingLogo3,
      text:
          'You can access your tasks as completed and incompleted with sub categories as tasks and birthdays',
    ),
  ];

  void gotoLayout(context) {
    CacheHelper.saveData(key: 'islastOnboarding', value: islastOnboarding)
        .then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.remindMeLayoutRoute, (route) => false);
      ;
    });
  }

  void goNext(PageController pageController) {
    pageController.nextPage(
      duration: const Duration(seconds: 5),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }
}
