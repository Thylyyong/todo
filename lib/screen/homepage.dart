import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as custom_scroll_view;
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/screen/category_card.dart' as category_widget;
import 'package:flutter_application_1/widget/product_card.dart';
import '../provider/search_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_1/data/mock_data.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController searchController = TextEditingController();
  final List<String> suggestions = [
    'Laptop',
    'T-Shirt',
    'Book',
    'Chair',
    'Table',
    'Phone',
    'Headphones',
    'Shoes',
    'Watch',
    'Bag',
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 151, 190, 223),
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Cart'),
              onTap: () {
                Navigator.pushNamed(context, 'cart');
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, 'login');
              },
            ),
          ],
        ),
      ),
      endDrawer: const Drawer(
        child: Text('End Drawer'),
      ),
      appBar: AppBar(
        title: const Text("Welcome to our store"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, 'cart');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, 'login');
            },
          ),
        ],
      ),
      
      body: LayoutBuilder(
      
        builder: (context, constraints) {
          int crossAxisCount;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 6;
          } else if (constraints.maxWidth > 800) {
            crossAxisCount = 4;
          } else {
            crossAxisCount = 2;
          }
          return custom_scroll_view.CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverToBoxAdapter(
                child:
                    Consumer<SearchProvider>(builder: (context, searchProvider, child) {
                  
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                 
                  children: [
                        Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return suggestions.where((String option) {
                            return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          final searchProvider = Provider.of<SearchProvider>(context, listen: false);
                          searchProvider.setSearch(selection);
                          Navigator.pushNamed(context, 'search');
                        },
                        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                          return TextField(
                            
                            controller: textEditingController,
                              focusNode: focusNode,
                              
                              decoration: const InputDecoration(
                 
                                prefixIcon: Icon(Icons.search),
                                
                                border: OutlineInputBorder(),
                                hintText: 'Search products',
                              ),
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          
                        ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.25,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        viewportFraction: 1.0,
                      ),
                      items: mockBanners.map((banner) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: AssetImage(banner),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                      
                 
                    const Text('Products',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: productProvider.products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            product: productProvider.products[index]);
                      },
                    ),
                  ],
                               ),
               );
            }
            )
              
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, 'cart');
          } else if (index == 1) {
            Navigator.pushNamed(context, 'profile');
          }
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
        ),
      ),
    );
  }
}