/// App-wide constants
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // App info
  static const String appName = 'ZODO';
  static const String appVersion = '1.0.0';

  // Spacing
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // Border radius
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusXxl = 24.0;

  // Icon sizes
  static const double iconSizeXs = 16.0;
  static const double iconSizeSm = 20.0;
  static const double iconSizeMd = 24.0;
  static const double iconSizeLg = 32.0;
  static const double iconSizeXl = 48.0;

  // Animation durations
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Duration animationDurationNormal = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);

  // Product related
  static const String exclusiveBadgeText = 'EXCLUSIVE';
  static const String comingSoonBadgeText = 'COMING SOON';

  // Navigation routes
  static const String routeHome = '/';
  static const String routeProductDetails = '/product-details';
  static const String routeCheckout = '/checkout';
  static const String routeShippingAddress = '/shipping-address';
  static const String routeOrderHistory = '/order-history';

  // Form validation
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;
  static const int maxAddressLength = 100;

  // API endpoints (placeholder)
  static const String baseUrl = 'https://admin.zodo.top/api';
  static const String productsEndpoint = '/products';
  static const String ordersEndpoint = '/orders';
  static const String deliveryCharge = '/charges';
  static const String orderTracking = '/orders/track';

  // Dummy data
  static const String dummyUserName = 'Abdul Halim';
  static const String dummyUserEmail = 'abdul.halim@example.com';
  static const String dummyUserInitials = 'JD';

  // Price formatting
  static const String currencySymbol = '\৳';
  static const String currencyCode = 'BDT';

  // Pagination
  static const int pageSize = 10;
  static const int initialPage = 1;
}
