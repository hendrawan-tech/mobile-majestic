import 'package:flutter/material.dart';
import 'package:majestic/models/comment_model.dart';
import 'package:majestic/pages/payment_page.dart';
import 'package:majestic/providers/detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:majestic/config.dart';
import 'package:majestic/models/auth_model.dart';
import 'package:majestic/models/product_model.dart';
import 'package:majestic/providers/auth_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _comments = TextEditingController();
  int _itemCount = 1;

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AuthModel? user = authProvider.user;
    DetailProvider detailProvider = Provider.of<DetailProvider>(context);
    ProductModel? product = detailProvider.product;
    DateTime now = DateTime.now();

    handleLike() async {
      if (await detailProvider.like(
        id: user!.id.toString(),
        post: detailProvider.product!.id.toString(),
      )) {
        Navigator.pushReplacementNamed(context, '/detail');
      }
    }

    handleComment() async {
      if (await detailProvider.comment(
        id: user!.id.toString(),
        post: detailProvider.product!.id.toString(),
        comment: _comments.text,
      )) {
        Navigator.pushReplacementNamed(context, '/detail');
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Success Comment",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Failed Comment",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }

    Widget comment(CommentModel comment) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF73C993),
                  width: 2,
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(comment.user!.profilePhotoPath == null
                      ? 'https://m.nsoproject.com/webfile/no_image.png'
                      : Config.url +
                          '/' +
                          comment.user!.profilePhotoPath.toString()),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.user!.name.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    comment.comment.toString(),
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      height: 1.5,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        '${Config.url}/${product!.image.toString()}',
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 50, left: 10, right: 10, bottom: 50),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 3,
                                  height: 1.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white70,
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${product.address}",
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        textBaseline: TextBaseline.alphabetic,
                                        fontSize: 14,
                                        letterSpacing: 2,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(.9),
                          Colors.black.withOpacity(.1),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  right: 40,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: product.favorite == true
                        ? FloatingActionButton(
                            backgroundColor: Colors.redAccent,
                            heroTag: 2,
                            onPressed: handleLike,
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                          )
                        : FloatingActionButton(
                            backgroundColor: Colors.white,
                            heroTag: 2,
                            onPressed: handleLike,
                            child: const Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      product.category == 'Destinasi'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.redAccent,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      product.likes!.length.toString(),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                const Text(
                                  "Harga Tiket",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "${product.price}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  product.likes!.length.toString(),
                                ),
                              ],
                            ),
                      product.category == 'Destinasi'
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xFF73C993),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  enableDrag: false,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return BottomSheet(
                                      onClosing: () {},
                                      enableDrag: false,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                                  setState) =>
                                              Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 25,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  "Pembelian Tiket",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Divider(
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Pilih Tanggal",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          "${now.day}-${now.month}-${now.year}",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        DateTime? newDate =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate: now,
                                                          firstDate: DateTime(
                                                              now.year),
                                                          lastDate:
                                                              DateTime(2100),
                                                        );
                                                        if (newDate == null) {
                                                          return;
                                                        }
                                                        setState(() =>
                                                            now = newDate);
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        size: 25,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Jumlah Tiket",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        _itemCount != 1
                                                            ? GestureDetector(
                                                                onTap: (() =>
                                                                    setState(
                                                                      () =>
                                                                          _itemCount--,
                                                                    )),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .remove_circle_outline,
                                                                  size: 25,
                                                                  color: Color(
                                                                      0xFF73C993),
                                                                ),
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .remove_circle_outline,
                                                                size: 25,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          child: Text(
                                                            _itemCount
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: (() =>
                                                              setState(
                                                                () =>
                                                                    _itemCount++,
                                                              )),
                                                          child: const Icon(
                                                            Icons
                                                                .add_circle_outline,
                                                            size: 25,
                                                            color: Color(
                                                              0xFF73C993,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 20),
                                                  child: Divider(
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Nama",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      user!.name.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Harga Tiket",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      product.price.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Jumlah Tiket",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      '($_itemCount)',
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 20),
                                                  child: Divider(
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Total Harga",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      (double.parse(product
                                                                  .price
                                                                  .toString()) *
                                                              _itemCount)
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xFF73C993),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 20),
                                                  child: Divider(
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF73C993),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  height: 48,
                                                  width: double.infinity,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return PaymentPage(
                                                          qty: _itemCount
                                                              .toString(),
                                                          total: (double.parse(
                                                                      product
                                                                          .price
                                                                          .toString()) *
                                                                  _itemCount)
                                                              .toString(),
                                                          date:
                                                              '${now.year}-${now.month}-${now.day}',
                                                          post: product.id
                                                              .toString(),
                                                        );
                                                      }));
                                                    },
                                                    child: const Text(
                                                      'Pembayaran',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                "Beli Tiket",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    product.description.toString(),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 83, 83, 83),
                      fontSize: 14,
                      letterSpacing: 2,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Comments",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.black12,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF73C993),
                            width: 2,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              user!.profilePhotoPath == null
                                  ? user.profile.toString()
                                  : Config.url +
                                      '/' +
                                      user.profilePhotoPath.toString(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 100,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15,
                                ),
                                // height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0E0E0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Expanded(
                                  child: TextFormField(
                                    controller: _comments,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    decoration: const InputDecoration.collapsed(
                                      hintText: "Comment Here!",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            IconButton(
                              onPressed: handleComment,
                              icon: const Icon(
                                Icons.send,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: Colors.black12,
                    ),
                  ),
                  Column(
                    children: product.comments!
                        .map(
                          (destination) => comment(destination),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
