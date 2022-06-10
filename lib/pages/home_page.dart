import 'package:flutter/material.dart';
import 'package:majestic/providers/event_provider.dart';
import 'package:majestic/providers/order_provider.dart';
import 'package:majestic/widgets/card_event.dart';
import 'package:provider/provider.dart';
import 'package:majestic/models/auth_model.dart';
import 'package:majestic/providers/auth_provider.dart';
import 'package:majestic/providers/destination_provider.dart';
import 'package:majestic/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AuthModel? user = authProvider.user;

    DestinationProvider destinationProvider =
        Provider.of<DestinationProvider>(context);
    EventProvider eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (() => Navigator.pushNamed(context, '/profile')),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF73C993), width: 2),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${user!.profile}'),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.centerRight,
                      onPressed: () async {
                        await Provider.of<OrderProvider>(context, listen: false)
                            .getProducts(
                          id: authProvider.user!.id.toString(),
                        );
                        Navigator.pushNamed(context, '/order');
                      },
                      icon: const Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: const Text(
                  "Find Your\nDream Destination",
                  style: TextStyle(
                    fontSize: 28,
                    letterSpacing: 3,
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                    labelColor: const Color(0xFF73C993),
                    unselectedLabelColor: Colors.grey,
                    controller: _tabController,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: CircleTabIndicator(
                        color: const Color(0xFF73C993), radius: 4),
                    tabs: const [
                      Tab(text: 'Destination'),
                      Tab(text: 'Event'),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 14),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: destinationProvider.products
                            .map(
                              (destination) => CardWidget(destination, user),
                            )
                            .toList(),
                      ),
                    ),
                    Column(
                      children: eventProvider.products
                          .map(
                            (event) => CardEvent(event, user),
                          )
                          .toList(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color? color, @required double? radius})
      : _painter = _CirclePainter(color!, radius!);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
