import 'package:flutter/material.dart';
import 'package:majestic/providers/order_provider.dart';
import 'package:majestic/widgets/card_order.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF1F5F9),
      appBar: AppBar(
        title: Text("Daftar Pesanan"),
        centerTitle: true,
        backgroundColor: Color(0xFF73C993),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black45,
              tabs: [
                Tab(text: 'Belum dibayar'),
                Tab(text: 'Selesai'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: orderProvider.products
                      .map(
                        (item) => CardOrder(
                          order: item,
                        ),
                      )
                      .toList(),
                ),
                Column(
                  children: const [Text("data 2")],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
