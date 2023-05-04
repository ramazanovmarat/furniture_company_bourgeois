import 'package:flutter/material.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/bloc/payment_bloc_provider.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/payment_const.dart';

class PaymentFrontUI extends StatelessWidget {
  const PaymentFrontUI({super.key});

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                StreamBuilder<String>(
                  stream: PaymentBlocProvider.of(context).bloc.sCardNumber,
                  builder: (_, snapshot) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),

                      child: snapshot.hasData && snapshot.data![0] == '5'
                          ? SizedBox(width: 40, child: Image.asset('assets/images/mastercard.png'))
                          : snapshot.hasData && snapshot.data![0] == '4'
                          ? SizedBox(width: 50, child: Image.asset('assets/images/visa.png'))
                          : snapshot.hasData && snapshot.data![0] == '2'
                          ? SizedBox(width: 50, child: Image.asset('assets/images/mir.png'))
                          : const SizedBox(),
                    );
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: StreamBuilder<String>(
                stream: PaymentBlocProvider.of(context).bloc.sCardNumber,
                builder: (_, snapshot) {
                  return Text(
                    snapshot.data ?? '',
                    style:
                    const TextStyle(fontSize: 24.0, letterSpacing: 2, shadows: [
                      Shadow(
                        color: Colors.black12,
                        offset: Offset(2, 1),
                      )
                    ]),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Дата:'),
                StreamBuilder<String>(
                  stream: PaymentBlocProvider.of(context).bloc.sCardExpiry,
                  builder: (_, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}