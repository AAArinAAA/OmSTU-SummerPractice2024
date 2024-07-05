import 'package:flutter/material.dart';
import 'custom_widgets/button.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Кофейня',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentCategory = "Cold Coffees"; 
  final ScrollController _scrollController = ScrollController();
  ScrollController _horizontalScrollController = ScrollController();
  int totalItemsInCart = 0; 

  List<String> categories = ["Cold Coffees", "Hot Coffees", "Bottled Beverages", "Lunch & Breakfast", "Milk & Juice"];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _horizontalScrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  int _calculateCategoryIndex(double offset) {
    return (offset / 450).floor();
  }

  void _scrollListener() {
    setState(() {
      int index = _calculateCategoryIndex(_scrollController.offset);
      if (index != -1 && index < categories.length) {
        currentCategory = categories[index];
        double screenWidth = MediaQuery.of(context).size.width;
        double categoryWidth = categories.length * 200;

        double scrollTo = index * 120.0 - (screenWidth - 120.0) / 2.0;
        scrollTo = scrollTo.clamp(0, categoryWidth - screenWidth);

        if (index == categories.length - 1) {
          scrollTo = categoryWidth - screenWidth;
        }

        _horizontalScrollController.animateTo(
          scrollTo,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }


void _selectCategory(String category) {
  setState(() {
    currentCategory = category;
  });

  int index = categories.indexOf(category);
  if (index != -1) {
    _scrollController.jumpTo(
      index * 570,
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _horizontalScrollController,
            child: Row(
              children: categories.map((category) => _buildCategoryButton(category)).toList(),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategorySection("Cold Coffees", [
                    Row(
                      children: [
                    _buildItem("Iced Flat White", "assets/Iced Flat White.jpg", 200),
                    _buildItem("Iced Shaken Espresso", "assets/Iced Shaken Espresso.jpg", 250),
                      ],
                    ),
                    Row(
                      children: [
                    _buildItem("Iced Caffè Mocha", "assets/Iced Caffè Mocha.jpg", 250),
                    _buildItem("Iced Caramel Macchiato", "assets/Iced Caramel Macchiato.jpg", 250),
                      ],
                    )
                  ]),
                  _buildCategorySection("Hot Coffees", [
                    Row(
                      children: [
                    _buildItem("Cappuccino", "assets/Cappuccino.jpg", 200),
                    _buildItem("Caramel Macchiato", "assets/Caramel Macchiato.jpg", 200),
                      ],),
                    Row(
                      children: [
                    _buildItem("Caffè Mocha", "assets/Caffè Mocha.jpg", 250),
                    _buildItem("Caffè Misto", "assets/Caffè Misto.jpg", 200),
                      ],),
                  ]),
                  _buildCategorySection("Bottled Beverages", [
                    Row(
                      children: [
                        _buildItem("Orange juice, 0.2L", "assets/Orange juice, 0.2L.png", 50),
                        _buildItem("Mojito", "assets/Mojito.png", 75),
                      ],
                    ),
                    
                    Row(
                      children: [
                        _buildItem("Evolution Fresh® Orange", "assets/Evolution Fresh® Orange.jpg", 125),
                        _buildItem("Horizon® Chocolate Milk", "assets/Horizon® Chocolate Milk.jpg", 60),
                      ],
                    )
                  ]),
                  _buildCategorySection("Lunch & Breakfast", [
                    Row (children: [
                    _buildItem("Bacon, Sausage & Egg Wrap", "assets/Bacon, Sausage & Egg Wrap.jpg", 325),
                    _buildItem("Bacon & Gruyère Egg Bites", "assets/Bacon & Gruyère Egg Bites.jpg", 175),
                    ],),
                    
                    Row (children: [
                    _buildItem("Ham & Swiss on Baguette", "assets/Ham & Swiss on Baguette.jpg", 250),
                    _buildItem("Cheese & Fruit Protein Box", "assets/Cheese & Fruit Protein Box.jpg", 400),
                    ],)
                  ]),
                  _buildCategorySection("Milk & Juice", [
                    Row(
                      children: [
                        _buildItem("Hot Chocolate", "assets/Hot Chocolate.jpg", 200),
                        _buildItem("Caramel Apple Spice", "assets/Caramel Apple Spice.jpg", 150),
                      ],
                    ),
                    Row(
                      children: [
                        _buildItem("White Hot Chocolate", "assets/White Hot Chocolate.jpg", 200),
                        _buildItem("Vanilla Crème", "assets/Vanilla Crème.jpg", 150),
                  ]),
                  const SizedBox(height: 20,),
                ],
              ),
        ]),
          ),
      )],
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          _selectCategory(category);
        },
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            color: currentCategory == category ? const Color.fromRGBO(205, 180, 219, 1) : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                color: currentCategory == category ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Widget> items) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 4.0,
          runSpacing: 2.0,
          children: items,
        ),
      ],
    ),
  );
}


  Widget _buildItem(String itemName, String imageUrl, int cost) {
  return GestureDetector(
    onTap: () {
    },
    child: Container(
      width: 160,
      height: 240,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 160,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(            
                  itemName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            )
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProductButton(
                    price: cost
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}
}
