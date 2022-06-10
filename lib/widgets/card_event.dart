import 'package:flutter/material.dart';
import 'package:majestic/config.dart';
import 'package:majestic/models/auth_model.dart';
import 'package:majestic/models/product_model.dart';
import 'package:majestic/providers/detail_provider.dart';
import 'package:provider/provider.dart';

class CardEvent extends StatelessWidget {
  final ProductModel product;
  final AuthModel user;
  CardEvent(this.product, this.user);

  @override
  Widget build(BuildContext context) {
    DetailProvider detailProvider = Provider.of(context);

    print(detailProvider.product);

    handlePress() async {
      if (await detailProvider.detail(
        id: product.id.toString(),
        user: user.id.toString(),
      )) {
        Navigator.pushNamed(context, '/detail');
      }
    }

    return GestureDetector(
      onTap: handlePress,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        elevation: 4,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                '${Config.url}/${product.image.toString()}',
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        // Container(
                        //   width: 38,
                        //   height: 38,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     border: Border.all(
                        //       color: Colors.white,
                        //       width: 2,
                        //     ),
                        //     image: const DecorationImage(
                        //       fit: BoxFit.cover,
                        //       image: NetworkImage(
                        //           'https://images.pexels.com/photos/1832324/pexels-photo-1832324.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: const [
                        //     Text(
                        //       "Nabila Putri",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 14,
                        //         letterSpacing: 2,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: 3,
                        //     ),
                        //     Text(
                        //       "nabilaputri@gmail.com",
                        //       style: TextStyle(
                        //         color: Colors.grey,
                        //         fontSize: 12,
                        //         letterSpacing: 2,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: product.favorite == true
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: const Icon(
                                Icons.favorite,
                                size: 20,
                                color: Colors.white,
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.favorite_border_outlined,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${product.title}",
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 3,
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
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(.9),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
