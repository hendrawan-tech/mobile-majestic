import 'package:flutter/material.dart';
import 'package:majestic/models/order_model.dart';
import 'package:majestic/pages/detail_order_page.dart';

class CardOrder extends StatelessWidget {
  final OrderModel order;
  const CardOrder({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailOrderPage(order: order))),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black26,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kode Pesanan",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        order.code.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: (order.status == "Menunggu Pembayaran")
                          ? Colors.yellow
                          : (order.status == "Menunggu Konfirmasi")
                              ? Colors.amber
                              : (order.status == "Pembayaran Dikonfirmasi")
                                  ? Colors.orange
                                  : (order.status == "Selesai")
                                      ? Colors.green
                                      : Colors.redAccent,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      order.status.toString(),
                      style: TextStyle(
                        color: order.status == "Menunggu Pembayaran"
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  color: Colors.black12,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tiket",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${order.product!.title} (x${order.quantity})",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Total Harga",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        order.total.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  color: Colors.black12,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.calendar_month_sharp,
                    size: 16,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    order.date.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
