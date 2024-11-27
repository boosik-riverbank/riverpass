import 'package:logger/logger.dart';
import 'package:riverpass/balance/repository/balance_repository.dart';
import 'package:riverpass/common/env.dart';
import 'package:riverpass/exchange/model/exchange_rate.dart';
import 'package:riverpass/exchange/repository/exchage_rate_repository.dart';
import 'package:riverpass/logger/logger.dart';
import 'package:riverpass/login/repository/user_repository.dart';
import 'package:riverpass/login/service/login_service.dart';
import 'package:riverpass/login/service/user_service.dart';

class Onboarding {
  Future<bool> onboardData() async {
    if (devMode) {
      Logger.level = Level.debug;
    } else {
      Logger.level = Level.info;
    }
    logger.d('Onboarding start!');
    logger.d('Exchange rate loading start.');
    await ExchangeRateRepository().init();

    logger.d('User loading start.');
    // final user = await UserServiceFactory().createUserServiceInstance().getByPreference();

    var isSignedIn = await LoginService().isSignedIn();
    if (isSignedIn) {
      return true;
    } else {
      return false;
    }
    //
    // logger.d('User loading finish: $user');
    // if (user != null) {
    //   logger.d('User ${user.id} info is already saved in preference');
    //   final isSignedUp = await LoginService().isSignedUp(user.email, user.provider);
    //   if (isSignedUp) {
    //     logger.d('User ${user.id} is already signed up.');
    //     await UserRepository().init(user.id);
    //     await BalanceRepository().getBalance(user.id, 'KRW');
    //     return true;
    //   } else {
    //     logger.d('User ${user.id} is not signed up yet.');
    //   }
    // }
    //
    // logger.d('This user need to sign up.');
    // return false;
  }
}