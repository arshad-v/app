import 'product.dart';

class Cart {
  final List<Product> items = [];

  void addItem(Product product) {
    items.add(product);
  }

  void removeItem(Product product) {
    items.remove(product);
  }

  double getTotalPrice() {
    return items.fold(0, (sum, item) => sum + item.price);
  }
}
