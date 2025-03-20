import 'package:flutter/material.dart';
import 'package:mid_term/components/product_card.dart';
import 'models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  List<Product> _featuredProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // In a real app, you would fetch this data from Supabase
      // For demo purposes, we're using mock data
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay

      setState(() {
        _featuredProducts = [
          Product(
            id: '1',
            name: 'Wireless Headphones',
            price: 99.99,
            category: '',
            imageUrl: 'https://placeholder.svg?height=200&width=200',
          ),
        ];

        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                child: CustomScrollView(
                  slivers: [
                    _buildAppBar(),
                    _buildSearchBar(),
                    _buildFeaturedProductsSection(),
                  ],
                ),
              ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      title: Row(
        children: [
          Text(
            'ShopApp',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search products...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedProductsSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Featured Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: _featuredProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  onDelete: () {},
                  onEdit: () {},
                  product: _featuredProducts[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
