import 'package:flutter/material.dart';
import 'product.dart';
import 'cart.dart';

final Cart cart = Cart();

void main() {
  runApp(const MyApp()); // Added const
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flipkart Clone', // Changed title
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Define Flipkart's blue color if needed
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2874F0)),
        // useMaterial3: true, // Consider enabling Material 3
      ),
      home: const MainScreen(), // Changed home to MainScreen
      // Removed old routes and onGenerateRoute as navigation is handled by BottomNavBar primarily
      // Navigation to detail pages will be handled within the specific screens
    );
  }
}

// --- Main Screen with Bottom Navigation Bar ---
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of widgets to display for each tab
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CategoriesPage(), // Placeholder
    CartPage(),
    AccountPage(), // Placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar can be added here if needed for all screens,
      // or kept within individual screens like HomePage/CartPage
      body: IndexedStack( // Use IndexedStack to keep state of pages
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Flipkart blue
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // To show all labels
        showUnselectedLabels: true,
      ),
    );
  }
}


// --- Placeholder Screens ---
class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Added Scaffold for structure
      appBar: AppBar(title: const Text('Categories')),
      body: const Center(
        child: Text('Categories Page - Placeholder'),
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold( // Added Scaffold for structure
      appBar: AppBar(title: const Text('Account')),
      body: const Center(
        child: Text('Account Page - Placeholder'),
      ),
    );
  }
}


// --- Existing Screens (Modified slightly if needed) ---

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Keep Scaffold and AppBar here for now, as MainScreen doesn't have a global AppBar
    return Scaffold(
      appBar: AppBar(
        title: Text('Flipkart Clone'),
      ),
      body: ListView(
        children: <Widget>[
          // --- Banner Section ---
          Container(
            height: 200,
            margin: const EdgeInsets.all(8.0),
            child: Image.network(
              'https://via.placeholder.com/600x200.png?text=Promotional+Banner',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),

          // --- Category Section ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Categories',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              children: <Widget>[
                _buildCategoryItem(context, Icons.phone_android, 'Mobiles'), // Pass context
                _buildCategoryItem(context, Icons.tv, 'Electronics'),
                _buildCategoryItem(context, Icons.chair, 'Furniture'),
                _buildCategoryItem(context, Icons.watch, 'Fashion'),
                _buildCategoryItem(context, Icons.shopping_basket, 'Grocery'),
                _buildCategoryItem(context, Icons.more_horiz, 'More'),
              ],
            ),
          ),
          const SizedBox(height: 16.0),

          // --- Button to View Products (Navigate differently now) ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              child: Text('View All Products'),
              onPressed: () {
                // Navigate to ProductListPage using Navigator.push
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductListPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  // Helper widget for category items
  Widget _buildCategoryItem(BuildContext context, IconData icon, String label) { // Added context
    return InkWell( // Make categories tappable
       onTap: () {
        // TODO: Navigate to specific category page or filter ProductListPage
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped on $label')),
        );
         // Example navigation to ProductListPage (can be refined later)
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => const ProductListPage()),
         );
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class ProductListPage extends StatelessWidget {
  final List<Product> products = const [
    Product(
      id: '1',
      name: 'Product 1',
      imageUrl: 'https://via.placeholder.com/150',
      price: 20.0,
    ),
    Product(
      id: '2',
      name: 'Product 2',
      imageUrl: 'https://via.placeholder.com/150',
      price: 30.0,
    ),
    Product(
      id: '3',
      name: 'Product 3',
      imageUrl: 'https://via.placeholder.com/150',
      price: 40.0,
    ),
  ];

  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'), // Keep AppBar for this specific page
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(products[index].imageUrl),
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            onTap: () {
              // Navigate to ProductDetailsPage using Navigator.push
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: products[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name), // Keep AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to Cart tab - This needs a better way, maybe using a Provider/GlobalKey later
               // For now, just push CartPage, but this creates a new instance
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const CartPage()),
               );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(widget.product.imageUrl),
            Text(widget.product.name),
            Text('\$${widget.product.price.toStringAsFixed(2)}'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cart.addItem(widget.product);
                   ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${widget.product.name} added to cart')),
                  );
                });
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget { // Should be StatefulWidget to update total? Or use Provider. Keep simple for now.
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing cart directly might not update UI correctly if cart changes elsewhere.
    // Needs state management (Provider, Riverpod, Bloc) for robust updates.
    // For this example, it might appear to work if navigated back and forth.
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${cart.items.length})'), // Show item count
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty // Handle empty cart
                ? const Center(child: Text('Your cart is empty.'))
                : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover,), // Added size
                  title: Text(item.name),
                  subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                  // Add remove button later
                );
              },
            ),
          ),
          // Show total and checkout button only if cart is not empty
          if (cart.items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text('Total: \$${cart.getTotalPrice().toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge,),
                   ElevatedButton(
                     onPressed: () {
                       // Navigate to CheckoutPage using Navigator.push
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => const CheckoutPage()),
                       );
                     },
                     child: Text('Checkout'),
                   ),
                 ],
               ),
            ),
        ],
      ),
    );
  }
}


class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'), // Keep AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Shipping Address',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Payment Information',
              ),
            ),
             const SizedBox(height: 20), // Add spacing
            ElevatedButton(
              onPressed: () {
                // Process order logic here
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order Placed (Placeholder)')),
                );
                // Clear cart? Navigate back?
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
