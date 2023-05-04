import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/bloc/payment_bloc.dart';

class PaymentBlocProvider extends InheritedWidget {

  final PaymentBloc bloc;

  const PaymentBlocProvider({Key? key, required Widget child, required this.bloc})
      : super(key: key, child: child);

  static PaymentBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PaymentBlocProvider>()!;
  }

  @override
  bool updateShouldNotify(PaymentBlocProvider oldWidget) {
    return true;
  }

}