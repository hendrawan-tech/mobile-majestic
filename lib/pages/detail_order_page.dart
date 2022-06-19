import 'package:flutter/material.dart';
import 'package:majestic/models/order_model.dart';
import 'package:majestic/providers/order_provider.dart';
import 'package:majestic/widgets/card_order.dart';
import 'package:majestic/widgets/card_order_detail.dart';
import 'package:provider/provider.dart';

class DetailOrderPage extends StatefulWidget {
  final OrderModel order;
  const DetailOrderPage({Key? key, required this.order}) : super(key: key);

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F5F9),
      appBar: AppBar(
        title: Text("Detail Pesanan"),
        centerTitle: true,
        backgroundColor: Color(0xFF73C993),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            width: double.maxFinite,
            child: CardOrderDetail(
              order: widget.order,
            ),
          ),
        ],
      ),
    );
  }
}
