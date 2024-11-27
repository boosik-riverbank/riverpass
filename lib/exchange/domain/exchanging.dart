import 'package:riverpass/balance/repository/balance_repository.dart';
import 'package:riverpass/exchange/service/exchange_history_service.dart';
import 'package:riverpass/exchange/store/exchange_store.dart';

class Exchanging {
  Future<void> doExchange(ExchangeHistoryService exchangeHistoryService, BalanceRepository balanceRepository, ExchangeStore exchangeStore) async {
    await exchangeHistoryService.uploadExchangeData(exchangeStore.toExchangeData());
    await balanceRepository.getBalance(exchangeStore.getUserId()!, 'KRW');
  }
}