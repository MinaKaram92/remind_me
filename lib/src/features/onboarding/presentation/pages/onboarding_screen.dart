import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/src/core/resources/strings_manager.dart';
import 'package:simple_todo_app/src/core/resources/values_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../onboarding_cubit/onboarding_cubit.dart';
import '../onboarding_cubit/onboarding_states.dart';
import '../widgets/onboarding_widget.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController pageController = PageController();

  OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocConsumer<OnboardingCubit, OnboardingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          OnboardingCubit cubit = OnboardingCubit.get(context);
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: TextButton(
                        onPressed: () {
                          cubit.changeOnboardingStatus(islast: true);
                          cubit.gotoLayout(context);
                        },
                        child: Text(
                          StringsManager.skipOnboarding,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.teal),
                        ),
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        itemBuilder: (context, index) {
                          return OnboardingWidget(
                              model: cubit.onboardingModels[index]);
                        },
                        physics: BouncingScrollPhysics(),
                        allowImplicitScrolling: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.onboardingModels.length,
                        controller: pageController,
                        onPageChanged: (index) {
                          if (index == cubit.onboardingModels.length - 1) {
                            cubit.changeOnboardingStatus(islast: true);
                          } else {
                            cubit.changeOnboardingStatus(islast: false);
                          }
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: AppSize.s30,
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: cubit.onboardingModels.length,
                            axisDirection: Axis.horizontal,
                            effect: ExpandingDotsEffect(
                              expansionFactor: cubit.expansionFactor,
                              activeDotColor: Colors.teal,
                              dotColor: Colors.black,
                              spacing: AppSize.s10,
                            ),
                          ),
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          child: const Icon(
                            Icons.forward,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (cubit.islastOnboarding) {
                              cubit.gotoLayout(context);
                            } else {
                              cubit.goNext(pageController);
                            }
                          },
                          backgroundColor: Colors.teal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
