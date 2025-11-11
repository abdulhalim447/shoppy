import 'package:flutter/material.dart';

import '../../features/checkout/data/models/order_model.dart';
import '../../features/checkout/presentation/pages/shipping_address_page.dart';
import '../../features/home/data/models/product_model.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/orders/presentation/pages/order_history_page.dart';
import '../../features/product_details/data/models/product_details_model.dart';
import '../../features/product_details/presentation/pages/product_details_page.dart';
import '../constants/app_constants.dart';

/// App router for navigation
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.routeHome:
        return MaterialPageRoute(builder: (_) => const HomePage(), settings: settings);

      case AppConstants.routeProductDetails:
        final product = settings.arguments as ProductDetailsModel?;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(
            product:
                product ??
                ProductDetailsModel(
                  id: '1',
                  name: 'Crusher EVO Wireless Headphones',
                  description: 'Premium Audio Experience with Sensory Bass',
                  fullDescription:
                      'Experience the ultimate audio revolution with Crusher EVO headphones. Featuring our signature Sensory Bass technology, these premium wireless headphones deliver crystal-clear audio with deep, immersive bass. Perfect for music lovers, gamers, and professionals who demand the best sound quality.',
                  price: 199.99,
                  imageUrl:
                      'https://www.skullcandy.com/cdn/shop/files/crusher_evo_buy_box_bone_1_400x.png?v=1759774679',
                  additionalImages: [
                    'https://www.skullcandy.com/cdn/shop/files/CrusherANC2_Primer_1_528041b1-350e-4c24-9883-0c3a1089c61f.png?v=1759771139',
                    'https://gadgetnmusic.com/wp-content/uploads/2023/03/Untitled-design-2023-03-19T162540.138.jpg',
                  ],
                  rating: 4.8,
                  reviewCount: 2156,
                  features: [
                    '40-Hour Battery Life',
                    'Sensory Bass Technology',
                    'Active Noise Cancellation',
                    'Premium Comfort Fit',
                    'Bluetooth 5.2 Connection',
                    'Built-in Microphone',
                    'Foldable Design',
                    'Wireless Charging',
                  ],
                  reviews: [
                    CustomerReview(
                      reviewerName: 'Ahmed K.',
                      rating: 5,
                      title: 'Best headphones for the price!',
                      content:
                          'The Sensory Bass is incredible! The sound quality is amazing and the battery lasts forever. Highly recommend for anyone who loves music.',
                      reviewDate: DateTime.now().subtract(const Duration(days: 5)),
                    ),
                    CustomerReview(
                      reviewerName: 'Fatima R.',
                      rating: 4.5,
                      title: 'Great sound, very comfortable',
                      content:
                          'Wearing these for hours is no problem. The noise cancellation works great and the bass is punchy without being overwhelming.',
                      reviewDate: DateTime.now().subtract(const Duration(days: 10)),
                    ),
                    CustomerReview(
                      reviewerName: 'Hassan M.',
                      rating: 5,
                      title: 'Perfect for gaming and music',
                      content:
                          'I use these for both gaming and music production. The sound quality is professional-grade and the wireless connection is rock solid.',
                      reviewDate: DateTime.now().subtract(const Duration(days: 15)),
                    ),
                  ],
                  stockCount: 150,
                  sku: 'CRUSHER-EVO-001',
                  isExclusive: true,
                ),
          ),
          settings: settings,
        );

      case AppConstants.routeCheckout:
      case AppConstants.routeShippingAddress:
        final argument = settings.arguments;
        ProductModel? product;
        OrderModel? order;

        if (argument is ProductModel) {
          product = argument;
        } else if (argument is OrderModel) {
          order = argument;
        }

        return MaterialPageRoute(
          builder: (_) => ShippingAddressPage(product: product, order: order),
          settings: settings,
        );

      case AppConstants.routeOrderHistory:
        return MaterialPageRoute(builder: (_) => const OrderHistoryPage(), settings: settings);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))),
          settings: settings,
        );
    }
  }

  /// Navigate to home
  static void goHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(AppConstants.routeHome, (route) => false);
  }

  /// Navigate to product details
  static void goProductDetails(BuildContext context, ProductDetailsModel product) {
    Navigator.of(context).pushNamed(AppConstants.routeProductDetails, arguments: product);
  }

  /// Navigate to checkout
  static void goCheckout(BuildContext context, OrderModel? order) {
    Navigator.of(context).pushNamed(AppConstants.routeShippingAddress, arguments: order);
  }

  /// Navigate to order history
  static void goOrderHistory(BuildContext context) {
    Navigator.of(context).pushNamed(AppConstants.routeOrderHistory);
  }
}
