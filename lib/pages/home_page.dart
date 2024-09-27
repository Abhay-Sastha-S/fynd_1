import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:fynd_1/components/card.dart';
import 'package:provider/provider.dart';
import '../components/filter_dropdown.dart';
import '../providers/data_provider.dart';
import '../components/navbar.dart';

class HomePage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 45,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
      centerTitle: true,
        title: Text(' fynd', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            padding:EdgeInsets.only(right:10),
            icon: Icon(Icons.undo),
            onPressed: () {
              print('Undo button pressed');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CardSwiper(
          padding: EdgeInsets.symmetric(horizontal: 9),
          controller: CardSwiperController(),
          allowedSwipeDirection: const AllowedSwipeDirection.only(
              up: true, right: true, left: true, down: false),
          cardsCount: dataProvider.products.length,
          cardBuilder: (BuildContext context, int index,
              int horizontalOffsetPercentage, int verticalOffsetPercentage) {
            final product = dataProvider.products[index];

            // Reset scroll position when a new card is displayed
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (scrollController.hasClients) {
                scrollController.jumpTo(0);
              }
            });

            return ProductCard(
              product: product,
              scrollController: scrollController,
              horizontalOffsetPercentage: horizontalOffsetPercentage,
              verticalOffsetPercentage: verticalOffsetPercentage,
            );
          },
          onSwipe: (int previousIndex, int? currentIndex, CardSwiperDirection direction) async {
            // Define your business logic for each swipe direction
            switch (direction) {
              case CardSwiperDirection.left:
                print("Swiped left");
                break;
              case CardSwiperDirection.right:
                print("Swiped right");
                break;
              case CardSwiperDirection.top:
                print("Swiped up");
                break;
              case CardSwiperDirection.bottom:
                print("Swiped down");
                break;
              case CardSwiperDirection.none:
                print("Swiped none");
                break;
            }
            dataProvider.onCardSwiped(currentIndex ?? previousIndex, direction);
            return true;
          },
          onEnd: () async {
            print("No more cards");
          },
          onTapDisabled: () async {
            print("Tap disabled");
          },
          onUndo: (int? previousIndex, int currentIndex, CardSwiperDirection direction) {
            print("Undo swipe");
            return true;
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              FilterModule(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}