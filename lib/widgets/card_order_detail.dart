import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:majestic/config.dart';
import 'package:majestic/models/order_model.dart';
import 'package:majestic/providers/auth_provider.dart';
import 'package:majestic/providers/order_provider.dart';
import 'package:provider/provider.dart';

class CardOrderDetail extends StatefulWidget {
  final OrderModel order;
  const CardOrderDetail({Key? key, required this.order}) : super(key: key);

  @override
  State<CardOrderDetail> createState() => _CardOrderDetailState();
}

class _CardOrderDetailState extends State<CardOrderDetail> {
  List<PlatformFile>? _files;
  File? image;

  void _openFileExporer() async {
    _files = (await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      allowedExtensions: null,
    ))!
        .files;
    print('file : ${_files!.first.path}');
    setState(() {
      image = File(_files!.first.path.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleSubmit() async {
      if (await orderProvider.payment(
          file: _files!.first.path, id: widget.order.id.toString())) {
        await Provider.of<OrderProvider>(context, listen: false).getProducts(
          id: authProvider.user!.id.toString(),
        );
        await Provider.of<OrderProvider>(context, listen: false)
            .getProductsDone(
          id: authProvider.user!.id.toString(),
        );
        Navigator.pushReplacementNamed(context, '/order');
      }
    }

    return Card(
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
                      widget.order.code.toString(),
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
                    color: (widget.order.status == "Menunggu Pembayaran")
                        ? Colors.yellow
                        : (widget.order.status == "Menunggu Konfirmasi")
                            ? Colors.amber
                            : (widget.order.status == "Pembayaran Dikonfirmasi")
                                ? Colors.orange
                                : (widget.order.status == "Selesai")
                                    ? Colors.green
                                    : Colors.redAccent,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    widget.order.status.toString(),
                    style: TextStyle(
                      color: widget.order.status == "Menunggu Pembayaran"
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
                      "${widget.order.product!.title} (x${widget.order.quantity})",
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
                      widget.order.total.toString(),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transfer Ke",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${widget.order.payment!.name} (${widget.order.payment!.bank})",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "No Rekening",
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.order.payment!.number.toString(),
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
            (widget.order.status == "Menunggu Pembayaran"
                ? Column(
                    children: [
                      image != null
                          ? Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 400,
                                  child: Image.file(image!),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Divider(
                                    color: Colors.black12,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF73C993),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: double.infinity,
                                  child: TextButton(
                                    onPressed: handleSubmit,
                                    child: const Text(
                                      'Kirim Bukti Pembayaran',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF73C993),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () async {
                                  _openFileExporer();
                                },
                                child: const Text(
                                  'Pilih Bukti Pembayaran',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Divider(
                          color: Colors.black12,
                        ),
                      ),
                    ],
                  )
                : (widget.order.transfer == null
                    ? Container()
                    : Column(
                        children: [
                          Text(
                            "Bukti Transfer",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            height: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.order.transfer! == ""
                                      ? 'https://m.nsoproject.com/webfile/no_image.png'
                                      : Config.url +
                                          '/' +
                                          widget.order.transfer!.toString(),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              color: Colors.black12,
                            ),
                          )
                        ],
                      ))),
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
                  widget.order.date.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
