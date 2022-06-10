import 'package:flutter/material.dart';
import 'package:majestic/config.dart';
import 'package:majestic/models/payment_model.dart';

class CardPayment extends StatelessWidget {
  final PaymentModel payment;
  final int selected;

  CardPayment(this.payment, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      '${Config.url}/${payment.image}',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                payment.bank.toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          selected == payment.id
              ? const Icon(
                  Icons.check_circle_outlined,
                  color: Colors.green,
                  size: 20,
                )
              : const Icon(
                  Icons.circle_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
        ],
      ),
    );
  }
}
