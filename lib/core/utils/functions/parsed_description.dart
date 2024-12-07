import '../../../features/product/data/model/product.dart';

String getTabContent(ProductModel product, int tabIndex) {
  switch (tabIndex) {
    case 0:
      return product.parsedDescription['description'] ?? "N/A";
    case 1:
      return product.parsedDescription['usage'] ?? "N/A";
    case 2:
      return product.parsedDescription['component'] ?? "N/A";
    default:
      return "N/A";
  }
}