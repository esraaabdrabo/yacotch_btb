import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/features/payment/controller/payment_cubit.dart';
import 'package:unicode_moyasar/unicode_moyasar.dart';

import '../../../core/ui/toast.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key, required this.amount, required this.userId, required this.typeUser, required this.subscriptionId})
      : super(key: key);

  final num amount;
  final int userId;
  final int typeUser;
  final int subscriptionId;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: MoyasarPayment(
              moyasarPaymentData: MoyasarPaymentData(
                appName: "UNICODE",
                secretKey: "sk_test_v9YxowEXSjAoNvLTczCZGxLfcYJNhaAwzAHr4nJi",
                publishableSecretKey:
                    "pk_test_vmALpRCM5khhCm2uc1X4aCi4prXkN6dcTJNBPLwX",
                purchaseAmount: widget.amount,
                locale: PaymentLocale.en,
                paymentEnvironment: PaymentEnvironment.test,
                paymentOptions: [
                  PaymentOption.card,
                  PaymentOption.applepay,
                  PaymentOption.stcpay,
                ],
              ),
              onPaymentSucess: (response) {
                PaymentCubit.of(context)
                    .createPayment(context, widget.userId, widget.amount);
                PaymentCubit.of(context).assignSubscriptionToUser(context, widget.subscriptionId, widget.typeUser);
                debugPrint("Success ------> ${response.toMap()}");
                Navigator.of(context).pop();
              },
              onPaymentFailed: (response) {
                Toast.show('Errror');
                Navigator.of(context).pop();
              },
            ),
          );
        },
      ),
    );
  }
}
