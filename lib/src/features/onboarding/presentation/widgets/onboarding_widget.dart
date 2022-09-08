import 'package:flutter/material.dart';
import 'package:simple_todo_app/src/core/resources/values_manager.dart';

import '../../models/onboarding_model.dart';

class OnboardingWidget extends StatelessWidget {
  final OnboardingModel model;
  const OnboardingWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          width: AppSize.s250,
          height: AppSize.s250,
          image: AssetImage(model.image),
        ),
        const SizedBox(
          height: AppSize.s50,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.headline5,
            text: model.text,
            children: <TextSpan>[
              TextSpan(
                  text: model.firstTextSpan,
                  style: Theme.of(context).textTheme.headline4!),
              TextSpan(
                  text: model.secondTextSpan,
                  style: Theme.of(context).textTheme.headline5),
            ],
          ),
        ),
      ],
    );
  }
}
