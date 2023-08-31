import 'package:store_mgt/core/cont/path_const.dart';
import 'package:store_mgt/core/cont/text_const.dart';
import 'package:store_mgt/screens/onboarding/widget/onboarding_tile.dart';

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