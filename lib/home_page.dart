import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinf_projeck/item_product.dart';
import 'package:sinf_projeck/like_page.dart';
import 'package:sinf_projeck/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<String> categories = ['All', 'Red', 'Blue', 'Green', 'Grey', 'Yellow'];
  List<Product> products = [
    Product(
        name: 'Car',
        type: 'Electric',
        cost: '100\$',
        image: 'assets/mashina.jpg',
        category: 'Red'),
    Product(
        name: 'Car',
        type: 'Electric',
        cost: '100\$',
        image: 'assets/mashina.jpg',
        category: 'Red'),
    Product(
        name: 'Car',
        type: 'Electric',
        cost: '100\$',
        image: 'assets/mashina.jpg',
        category: 'Red'),
    Product(
        name: 'Car',
        type: 'Electric',
        cost: '100\$',
        image: 'assets/mashina.jpg',
        category: 'Red'),
    Product(
        name: 'Car',
        type: 'Electric',
        cost: '100\$',
        image: 'assets/mashina.jpg',
        category: 'Red'),
    Product(
        name: 'Car',
        type: 'Electric',
        cost: '100\$',
        image: 'assets/mashina.jpg',
        category: 'Red'),
    Product(
        name: 'Car',
        type: 'Electric',
        cost: '100\$',
        image: 'assets/mashina.jpg',
        category: 'Red'),
  ];
  int likedItems = 0;
  List<Product> sortedProducts = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      sortedProducts = products;
    });
  }

  void _openLikePage() async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => LikePage(
            likedItems: products.where((element) => element.isLike).toList(),),
      ),) as List;
    setState(() {
      likedItems = result.length;
    });
    for(int i = 0; i < products.length; i++) {
      if(!result.contains(products[i])){
        setState(() {
          products[i].isLike = false;
          sortedProducts[i].isLike = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Cars',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.black,
              )),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                    products = sortedProducts;
                  });
                  _openLikePage();
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                margin: const EdgeInsets.only(bottom: 25, left: 15),
                alignment: Alignment.center,
                child: Text(
                  likedItems.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return _categories(index);
                  }),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return productItem(
                    context,
                    products,
                    index,
                    () {
                      setState(() {
                        products[index].isLike = !products[index].isLike;
                        if (products[index].isLike) {
                          likedItems++;
                        } else {
                          likedItems--;
                        }
                      });
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  Container _categories(int index) {
    return Container(
      padding: index != categories.length - 1
          ? const EdgeInsets.only(left: 10)
          : const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: MaterialButton(
        elevation: 0,
        color: (_selectedIndex != index) ? Colors.white : Colors.grey.shade300,
        shape: const StadiumBorder(),
        onPressed: () {
          setState(() {
            _selectedIndex = index;
            products = sortedProducts
                .where((element) => categories[index] == element.category)
                .toList();
            if (index == 0) {
              products = sortedProducts;
            }
          });
        },
        child: Text(
          categories[index],
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
