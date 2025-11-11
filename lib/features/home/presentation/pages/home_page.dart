import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../providers/product_provider.dart';
import '../widgets/featured_product_section.dart';
import '../widgets/upcoming_products_carousel.dart';

/// Home page of the app
class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch products from API
    Future.microtask(() {
      ref.read(productProvider.notifier).fetchAllProducts();
    });
  }

  void _onBuyNow() {
    final productState = ref.read(productProvider);
    if (productState.mainProduct != null) {
      // Navigate to checkout with product data
      Navigator.of(context).pushNamed(AppConstants.routeShippingAddress, arguments: productState.mainProduct);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product not available')));
    }
  }

  void _onNavItemTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    switch (index) {
      case 0:
        // Home - already here
        break;
      case 1:
        // Orders
        Navigator.of(context).pushNamed(AppConstants.routeOrderHistory);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: BrandedAppBar(
        appName: AppConstants.appName,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'privacy') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: const Text('Privacy Policy'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Open Link'),
                              onPressed: () async {
                                final Uri url = Uri.parse('https://sites.google.com/view/zodoapp/home');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: 'privacy', child: Text('Privacy Policy')),
            ],
          ),
        ],
      ),

      body: productState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productState.hasError
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(productState.error ?? 'Error loading products'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(productProvider.notifier).fetchAllProducts();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured Product Section
                    if (productState.mainProduct != null)
                      FeaturedProductSection(product: productState.mainProduct!, onBuyNow: _onBuyNow),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Upcoming Products Section
                    if (productState.comingSoonProducts.isNotEmpty)
                      UpcomingProductsCarousel(
                        products: productState.comingSoonProducts,
                        onProductTap: () {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(const SnackBar(content: Text('Product details coming soon')));
                        },
                      ),
                    const SizedBox(height: AppConstants.spacingXl),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentNavIndex,
        items: [
          BottomNavItem(icon: Icons.home, label: 'HOME', onTap: () => _onNavItemTap(0)),
          BottomNavItem(icon: Icons.history, label: 'ORDERS', onTap: () => _onNavItemTap(1)),
        ],
      ),
    );
  }
}
