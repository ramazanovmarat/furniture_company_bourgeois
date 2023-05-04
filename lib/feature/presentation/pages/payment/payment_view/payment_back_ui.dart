
import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/bloc/payment_bloc_provider.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/payment_const.dart';

class PaymentBackUI extends StatelessWidget {
  const PaymentBackUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.only(
          left: 16.0, right: 16.0, bottom: 32.0, top: 16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: Colors.black87,
              height: 50.0,
              width: double.infinity,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.black38,
                    height: 40.0,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: StreamBuilder<String>(
                    stream: PaymentBlocProvider.of(context).bloc.sCardSecureCode,
                    builder: (_, snapshot) {
                      return Text(
                        snapshot.data ?? '',
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}