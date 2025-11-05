# SHOPPY - Project Structure

## 📁 Complete Directory Tree

```
shoppy/
├── lib/
│   ├── main.dart                          # App entry point
│   │
│   ├── config/                            # Configuration & Setup
│   │   ├── constants/
│   │   │   └── app_constants.dart         # App-wide constants
│   │   ├── navigation/
│   │   │   └── app_router.dart            # Route management
│   │   └── theme/
│   │       ├── app_colors.dart            # Color palette
│   │       ├── app_theme.dart             # Material theme
│   │       └── text_styles.dart           # Typography
│   │
│   ├── core/                              # Reusable Components
│   │   ├── animations/
│   │   │   └── page_transitions.dart      # Page animations
│   │   ├── utils/
│   │   │   ├── extensions.dart            # Dart extensions
│   │   │   └── responsive_helper.dart     # Responsive utilities
│   │   └── widgets/
│   │       ├── badge.dart                 # Badge widget
│   │       ├── bottom_nav_bar.dart        # Bottom navigation
│   │       ├── custom_app_bar.dart        # App bar variants
│   │       ├── gradient_button.dart       # Gradient button
│   │       ├── product_card.dart          # Product card
│   │       └── shimmer_loading.dart       # Loading effect
│   │
│   └── features/                          # Feature Modules
│       ├── home/
│       │   ├── data/
│       │   │   └── models/
│       │   │       └── product_model.dart
│       │   └── presentation/
│       │       ├── pages/
│       │       │   └── home_page.dart
│       │       └── widgets/
│       │           ├── featured_product_section.dart
│       │           └── upcoming_products_carousel.dart
│       │
│       ├── product_details/
│       │   ├── data/
│       │   │   └── models/
│       │   │       └── product_details_model.dart
│       │   └── presentation/
│       │       ├── pages/
│       │       │   └── product_details_page.dart
│       │       └── widgets/
│       │           ├── features_list.dart
│       │           ├── product_image_section.dart
│       │           └── reviews_section.dart
│       │
│       ├── checkout/
│       │   ├── data/
│       │   │   └── models/
│       │   │       └── order_model.dart
│       │   └── presentation/
│       │       ├── pages/
│       │       │   └── shipping_address_page.dart
│       │       └── widgets/
│       │           ├── address_form.dart
│       │           ├── form_field.dart
│       │           └── order_summary_card.dart
│       │
│       ├── orders/
│       │   ├── data/
│       │   │   └── models/
│       │   │       └── (uses order_model from checkout)
│       │   └── presentation/
│       │       ├── pages/
│       │       │   └── order_history_page.dart
│       │       └── widgets/
│       │           ├── order_card.dart
│       │           └── order_timeline.dart
│       │
│       └── settings/
│           ├── data/
│           │   └── models/
│           │       └── user_model.dart
│           └── presentation/
│               ├── pages/
│               │   └── settings_page.dart
│               └── widgets/
│                   ├── settings_menu_item.dart
│                   └── user_profile_card.dart
│
├── pubspec.yaml                           # Dependencies
├── README.md                              # Project documentation
├── QUICK_START.md                         # Quick start guide
├── PROJECT_SUMMARY.md                     # Project overview
├── IMPLEMENTATION_DETAILS.md              # Architecture details
├── COMPLETION_REPORT.md                   # Completion report
└── PROJECT_STRUCTURE.md                   # This file
```

## 📊 File Statistics

### By Category
| Category | Count | Purpose |
|----------|-------|---------|
| Pages | 5 | Full-screen widgets |
| Widgets | 15+ | Reusable components |
| Models | 5 | Data structures |
| Config | 4 | App configuration |
| Utils | 2 | Helper functions |
| Total | 36+ | All Dart files |

### By Feature
| Feature | Files | Purpose |
|---------|-------|---------|
| Home | 3 | Home screen |
| Product Details | 4 | Product information |
| Checkout | 4 | Order placement |
| Orders | 3 | Order tracking |
| Settings | 3 | User settings |
| Core | 8+ | Reusable components |
| Config | 4 | App setup |

## 🎯 Key Files

### Configuration Files
```
config/
├── constants/app_constants.dart      # Routes, spacing, icons
├── navigation/app_router.dart        # Route generation
└── theme/
    ├── app_colors.dart               # Color definitions
    ├── app_theme.dart                # Material theme
    └── text_styles.dart              # Typography
```

### Core Components
```
core/
├── animations/page_transitions.dart  # Page animations
├── utils/
│   ├── extensions.dart               # Dart extensions
│   └── responsive_helper.dart        # Responsive utilities
└── widgets/
    ├── badge.dart                    # Status badges
    ├── bottom_nav_bar.dart           # Navigation bar
    ├── custom_app_bar.dart           # App bar variants
    ├── gradient_button.dart          # CTA button
    ├── product_card.dart             # Product display
    └── shimmer_loading.dart          # Loading effect
```

### Feature Modules
```
features/
├── home/                             # Home screen
├── product_details/                  # Product details
├── checkout/                         # Checkout flow
├── orders/                           # Order history
└── settings/                         # Settings page
```

## 🔄 Data Flow

### Home → Product Details → Checkout
```
HomePage
  ↓
ProductDetailsPage (receives ProductDetailsModel)
  ↓
ShippingAddressPage (creates OrderModel)
  ↓
OrderHistoryPage (displays OrderModel)
```

### Navigation Routes
```
/ (Home)
├── /product-details (Product Details)
├── /shipping-address (Checkout)
├── /order-history (Order History)
└── /settings (Settings)
```

## 📦 Dependencies

### Direct Dependencies
```yaml
google_fonts: ^6.1.0              # Typography
cached_network_image: ^3.4.1      # Image caching
intl: ^0.19.0                     # Date formatting
provider: ^6.0.0                  # State management
```

### Flutter SDK
```yaml
flutter:
  sdk: flutter
```

## 🏗️ Architecture Layers

### Presentation Layer
- Pages: Full-screen widgets
- Widgets: Reusable UI components
- Animations: Transitions and effects

### Data Layer
- Models: Data structures
- Serialization: toJson/fromJson

### Configuration Layer
- Theme: Colors, typography
- Constants: App-wide values
- Navigation: Route management

## 📱 Screen Structure

### Home Screen
```
HomePage
├── AppBar (BrandedAppBar)
├── FeaturedProductSection
│   └── ProductCard
├── UpcomingProductsCarousel
│   └── HorizontalProductCard[]
└── CustomBottomNavBar
```

### Product Details Screen
```
ProductDetailsPage
├── AppBar (CustomAppBar)
├── ProductImageSection
├── FeaturesList
├── ReviewsSection
└── GradientButton (ORDER NOW)
```

### Checkout Screen
```
ShippingAddressPage
├── AppBar (CustomAppBar)
├── OrderSummaryCard
├── AddressForm
│   └── CustomFormField[]
└── GradientButton (CONFIRM)
```

### Order History Screen
```
OrderHistoryPage
├── AppBar (CustomAppBar)
└── OrderCard[]
    ├── OrderInfo
    └── OrderTimelineWidget (expandable)
```

### Settings Screen
```
SettingsPage
├── AppBar (CustomAppBar)
├── UserProfileCard
└── SettingsMenuItem[]
```

## 🎨 Design System Files

### Colors
- `app_colors.dart`: 20+ color definitions
- Semantic colors (background, surface, border)
- Brand colors (neon blue, purple, yellow)
- Status colors (success, error, warning)

### Typography
- `text_styles.dart`: 10+ text styles
- Display, Headline, Title, Body, Caption
- Consistent sizing and weights

### Theme
- `app_theme.dart`: Material 3 dark theme
- Component themes (AppBar, Button, Card, etc.)
- Consistent styling across app

## 🔌 Extension Points

### Easy to Add
1. **New Feature**: Create in `features/` folder
2. **New Widget**: Create in `core/widgets/`
3. **New Route**: Add to `app_router.dart`
4. **New Color**: Add to `app_colors.dart`
5. **New Style**: Add to `text_styles.dart`

### Integration Points
- API calls: Replace dummy data in models
- Authentication: Add to navigation
- State management: Upgrade to Provider/Riverpod
- Analytics: Add to page transitions
- Notifications: Add to order updates

## 📈 Scalability

### Current Capacity
- 5 features implemented
- 36+ files organized
- 3000+ lines of code
- 8+ reusable widgets

### Growth Ready
- Feature-First Architecture
- Modular components
- Clear separation of concerns
- Easy to extend

---

**This structure ensures the app remains organized and scalable as it grows.**

