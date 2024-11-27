import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpass/balance/repository/balance_repository.dart';
import 'package:riverpass/exchange/domain/exchanging.dart';
import 'package:riverpass/exchange/service/exchange_history_service.dart';
import 'package:riverpass/exchange/store/exchange_store.dart';

class InPersonBillingPage extends StatefulWidget {
  const InPersonBillingPage({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<StatefulWidget> createState() {
    return _InPersonBillingPageState();
  }
}

class _InPersonBillingPageState extends State<InPersonBillingPage> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;
  final _exchangeStore = ExchangeStore();
  bool _isSelectedOnce = false;
  final _nameTextEditingController = TextEditingController();
  final _passportTextEditingController = TextEditingController();
  final _timeTextEditingController = TextEditingController();
  final _snsTextEditingController = TextEditingController();
  final _spaceTextEditingController = TextEditingController();

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        _isSelectedOnce = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2024),
          lastDate: DateTime(2100),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        // title: Text(AppLocalizations.of(context)!.directCurrencyExchange, style: const TextStyle(fontWeight: FontWeight.bold),),
        title: Text("Information", style: const TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
              onPressed: () {
                context.push("/translation");
              },
              icon: const Icon(Icons.g_translate_outlined))
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraint) => ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: constraint.maxHeight
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Confirm transaction information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF989898)),),
                      SizedBox(height: 20),
                      const Text('Visit Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF989898)),),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          )
                        ),
                        controller: _spaceTextEditingController,
                      ),
                      SizedBox(height: 30),
                      const Text('Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF989898)),),
                      SizedBox(height: 10),
                      OutlinedButton(
                          onPressed: () {
                            _restorableDatePickerRouteFuture.present();
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                          child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Center(
                                  child: Text('Select calendar', style: TextStyle(fontSize: 20),)
                              )
                          )
                      ),
                      SizedBox(height: 10),
                      _isSelectedOnce ? Text("${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}", style: TextStyle(fontSize: 20),) : SizedBox(),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            hintText: 'am 00 - pm 23',
                            hintStyle: TextStyle(color: Color(0xFF989898))
                        ),
                        controller: _timeTextEditingController,
                      ),
                      SizedBox(height: 30),
                      const Text('Name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF989898)),),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            hintText: 'John Doe',
                            hintStyle: TextStyle(color: Color(0xFF989898))
                        ),
                        controller: _nameTextEditingController,
                      ),
                      SizedBox(height: 30),
                      const Text('Passport number', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF989898)),),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            hintText: 'M12345678',
                            hintStyle: TextStyle(color: Color(0xFF989898))
                        ),
                        controller: _passportTextEditingController,
                      ),
                      SizedBox(height: 30),
                      const Text('Messenger (We will contact)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF989898)),),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            hintText: 'Instagram @riverbank',
                            hintStyle: TextStyle(color: Color(0xFF989898))
                        ),
                        controller: _snsTextEditingController,
                      ),
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF53B1FD),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: CupertinoButton(
                        onPressed: () {
                          ExchangeStore().setIsFinalized(false);
                          ExchangeStore().setSns(_snsTextEditingController.value.text);
                          ExchangeStore().setMethod('in_person: ${_spaceTextEditingController.value.text}');
                          // Exchanging().doExchange(
                          //     ExchangeHistoryService(),
                          //     BalanceRepository(),
                          //     ExchangeStore()).then((_) {
                          //   Fluttertoast.showToast(msg: 'Upload success!');
                          // });
                          // context.go('/balance');
                          context.push('/confirm');
                        },
                        child: Container(
                            child: Center(
                              // child: Text(AppLocalizations.of(context)!.exchange, style: TextStyle(color: Colors.white, fontSize: 20))
                                child: Text("Exchange", style: TextStyle(color: Colors.white, fontSize: 20))
                            )
                        ),
                      )
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}