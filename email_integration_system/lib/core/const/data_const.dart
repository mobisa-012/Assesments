import 'package:email_integration_system/core/const/path_const.dart';
import 'package:email_integration_system/core/const/text_const.dart';
import 'package:email_integration_system/screens/onboarding/widget/onboarding_tile.dart';

class DataConstants {
  static final onboardingTiles =[
    const OnboardingTile(
      title: TextConstants.getStarted,
      description: TextConstants.chat,
      image: PathConstants.chat,
    ),
    const OnboardingTile(
      title: TextConstants.getStarted,
      description: TextConstants.isometric,
      image: PathConstants.isometric,
    ),
    const OnboardingTile(
      title: TextConstants.getStarted,
      description: TextConstants.marketing,
      image: PathConstants.marketing,
    )
  ];
}