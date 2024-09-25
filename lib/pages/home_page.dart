import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:fynd_1/components/navbar.dart';
import 'package:provider/provider.dart';

import '../components/filter_dropdown.dart';
import '../providers/data_provider.dart';

class HomePage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();  // Initialize ScrollController

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('fynd',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
        IconButton(
          padding: EdgeInsets.only(right: 10),
          icon: Icon(Icons.undo),
          onPressed: () {
            // Implement undo logic here
            print('Undo button pressed');
          },
        ),
      ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              FilterModule(),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: CardSwiper(
                padding:EdgeInsets.symmetric(horizontal: 9),
                controller: CardSwiperController(),
                allowedSwipeDirection: const AllowedSwipeDirection.only(up: true, right: true, left: true, down: false),
                //numberOfCardsDisplayed: 2,
                cardsCount: dataProvider.products.length,
                cardBuilder: (BuildContext context, int index, int horizontalOffsetPercentage, int verticalOffsetPercentage) {
                  final product = dataProvider.products[index];
                  
                  // Reset scroll position when a new card is displayed
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (scrollController.hasClients) {
                      scrollController.jumpTo(0);
                    }
                  });
                  
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0), // Adjusted paddin
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: SingleChildScrollView(
                          controller: scrollController, // Attach ScrollController
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.network(
                                product.images[0],
                                fit: BoxFit.cover,
                                height: 300,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              for (int i = 1; i < product.images.length; i++)
                                Image.network(
                                  product.images[i],
                                  fit: BoxFit.cover,
                                  height: 300,
                                ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(product.description),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                onSwipe: (int previousIndex, int? currentIndex, CardSwiperDirection direction) async {
                  // Define your business logic for each swipe direction
                  switch (direction) {
                    case CardSwiperDirection.left:
                      // Logic for swipe left
                      print("Swiped left");
                      break;
                    case CardSwiperDirection.right:
                      // Logic for swipe right
                      print("Swiped right");
                      break;
                    case CardSwiperDirection.top:
                      // Logic for swipe up
                      print("Swiped up");
                      break;
                    case CardSwiperDirection.bottom:
                      // Logic for swipe down
                      print("Swiped down");
                      break;
                    case CardSwiperDirection.none:
                      // Logic for swipe none
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
          ),
        ],
      ),
      
      bottomNavigationBar:BottomNavigation() ,
    );
  }
}


class FilterDropdown extends StatelessWidget {
  final String title;
  final List<String> options;

  FilterDropdown({
    required this.title,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjusted padding
      child: ExpansionTile(
        title: Text(title),
        children: options.map((String option) {
          return CheckboxListTile(
            title: Text(option),
            value: dataProvider.selectedFilters[title]?.contains(option) ?? false,
            onChanged: (bool? value) {
              dataProvider.toggleFilter(title, option);
            },
          );
        }).toList(),
      ),
    );
  }
}
