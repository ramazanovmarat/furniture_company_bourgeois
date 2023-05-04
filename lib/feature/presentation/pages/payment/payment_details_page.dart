import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/cart_cubit/cart_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/shopping_cubit/shopping_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/bloc/payment_bloc.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/bloc/payment_bloc_provider.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/payment_animation/payment_visualizer.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/payment_animation/payment_visualizer_controller.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/payment_const.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/payment_view/payment_back_ui.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/payment_view/payment_front_ui.dart';
import 'package:furniture_company_bourgeois/feature/presentation/pages/payment/delivery_address_page.dart';
import 'package:audioplayers/audioplayers.dart';

class PaymentDetailsPage extends StatefulWidget {

  const PaymentDetailsPage({super.key});

  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  double? _screenHeight;
  final PaymentBloc _cardBloc = PaymentBloc();
  final FocusNode _secureCodeFocusNode = FocusNode();
  final PaymentVisualizerController _cardVisualizerController = PaymentVisualizerController();


  @override
  void initState() {
    super.initState();
    _initValues();
  }

  _initValues() {
    _secureCodeFocusNode.addListener(() => _cardVisualizerController.toggle());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
  }

  @override
  void dispose() {
    _cardVisualizerController.dispose();
    _secureCodeFocusNode.dispose();
    _cardBloc.dispose();
    super.dispose();
  }

  String? _data;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F4F4),
      appBar: AppBar(
        title: const Text(
          'Банковская карта',
          style: labelStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Form(
        key: _formKey ,
        child: SingleChildScrollView(
          child: PaymentBlocProvider(
            bloc: _cardBloc,
            child: Column(
              children: [
                SizedBox(
                  height: _screenHeight! * 1.1 / 3,
                  child: PaymentVisualizer(
                    itemWidth: MediaQuery.of(context).size.width,
                    widgetFront: const PaymentFrontUI(),
                    widgetBack: const PaymentBackUI(),
                    controller: _cardVisualizerController,
                    enableScroll: false,
                  ),
                ),
                MaterialButton(
                        onPressed: () async {
                          final result = await Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const DeliveryAddressPage()));

                          setState(() {
                            _data = result;
                          });
                        },
                        child: Row(children: [
                          const Icon(Icons.location_pin),
                          Text(_data == null ? 'Укажите адресс доставки' : '$_data'),
                        ])),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Номер карты',
                        ),
                        onChanged: (value) => _cardBloc.changeCardNumber(value),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(16),
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (text) {
                          if (text == null || text.isEmpty || text.length != 16) {
                            return 'Проверьте номер карты';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                              ],
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if(value!.isEmpty || value.length != 5) {
                                  return 'Введите срок действия карты';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Дата',
                                hintText: 'MM/YY',
                              ),
                              onChanged: _cardBloc.changeCardExpiry,
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                              ],
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if(value!.isEmpty || value.length != 3) {
                                  return 'Введите код';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'CVV',
                              ),
                              onChanged: _cardBloc.changeCardSecureCode,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ButtonTheme(
                        minWidth: double.infinity,
                        height: 50.0,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          color: buttonColor,
                          onPressed:  () async {

                            if(_formKey.currentState!.validate()) {
                              final player = AudioPlayer();
                              await player.play(AssetSource('apple_pay.mp3'));
                              showDialog(context: context, builder: (_) => const AnimatedAlertDialog()).then((value) {
                                Navigator.of(context).pop();
                                context.read<ShoppingCubit>().addShopping();
                                context.read<CartCubit>().clearCart();
                              });
                            }
                          },
                          child: const Text(
                            'Оплатить',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class AnimatedAlertDialog extends StatefulWidget {
  const AnimatedAlertDialog({super.key});

  @override
  _AnimatedAlertDialogState createState() => _AnimatedAlertDialogState();
}

class _AnimatedAlertDialogState extends State<AnimatedAlertDialog> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 450), vsync: this);
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.linear)
      ..addListener(() {
        setState(() {});
      });
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation!,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.done_rounded, size: 50, color: Colors.green),
                    SizedBox(height: 10),
                    Text('Оплата прошла успешно'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Благодарим за покупку мебели в нашей компании' , textAlign: TextAlign.center),
              const Divider(thickness: 1),
              const Text('Доставим в течении недели', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
    );
  }
}