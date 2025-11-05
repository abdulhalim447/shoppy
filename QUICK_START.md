# SHOPPY - Quick Start Guide

## 🚀 Getting Started in 5 Minutes

### Step 1: Prerequisites
Ensure you have Flutter installed:
```bash
flutter --version
```

If not installed, visit: https://flutter.dev/docs/get-started/install

### Step 2: Clone & Setup
```bash
# Navigate to project directory
cd shoppy

# Get dependencies
flutter pub get
```

### Step 3: Run the App
```bash
# Run on connected device or emulator
flutter run

# Or run on web
flutter run -d chrome

# Or run on specific device
flutter run -d <device_id>
```

### Step 4: Build for Production
```bash
# Web
flutter build web --release

# Android APK
flutter build apk --release

# iOS
flutter build ios --release
```

## 📱 App Navigation

### Home Screen
- View featured exclusive product
- Browse upcoming products carousel
- Access Orders and Settings via bottom navigation

### Product Details
- Tap any product to view details
- See product images, features, and reviews
- Click "ORDER NOW" to proceed to checkout

### Checkout
- Enter shipping address
- Review order summary
- Confirm and complete purchase

### Order History
- View all orders with status
- Expand orders to see timeline
- Track delivery progress

### Settings
- View user profile
- Manage account settings
- Sign out

## 🎨 Customization

### Change Colors
Edit `lib/config/theme/app_colors.dart`:
```dart
static const Color neonBlue = Color(0xFF00d4ff);
static const Color vibrantPurple = Color(0xFFb537ff);
```

### Change Typography
Edit `lib/config/theme/text_styles.dart`:
```dart
static const TextStyle headlineLarge = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
);
```

### Add New Routes
Edit `lib/config/navigation/app_router.dart`:
```dart
case AppConstants.routeNewPage:
  return MaterialPageRoute(builder: (_) => const NewPage());
```

## 🔧 Project Structure

```
lib/
├── config/              # Configuration files
│   ├── theme/          # Colors, typography, theme
│   ├── constants/      # App constants
│   └── navigation/     # Routes and navigation
├── core/               # Reusable components
│   ├── widgets/        # Custom widgets
│   ├── animations/     # Animations
│   └── utils/          # Utilities and helpers
└── features/           # Feature modules
    ├── home/           # Home feature
    ├── product_details/# Product details feature
    ├── checkout/       # Checkout feature
    ├── orders/         # Orders feature
    └── settings/       # Settings feature
```

## 📊 Key Files

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point |
| `lib/config/theme/app_colors.dart` | Color definitions |
| `lib/config/theme/app_theme.dart` | Material theme |
| `lib/config/navigation/app_router.dart` | Route management |
| `lib/core/widgets/gradient_button.dart` | Custom button |
| `lib/features/home/presentation/pages/home_page.dart` | Home screen |

## 🐛 Troubleshooting

### Build Issues
```bash
# Clean build
flutter clean
flutter pub get
flutter run

# Update dependencies
flutter pub upgrade
```

### Device Issues
```bash
# List connected devices
flutter devices

# Run on specific device
flutter run -d <device_id>
```

### Hot Reload Not Working
```bash
# Stop the app and restart
flutter run
```

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design](https://material.io/design)
- [Flutter Packages](https://pub.dev)

## 💡 Tips & Tricks

### Hot Reload
Press `r` in terminal to hot reload during development

### Hot Restart
Press `R` in terminal to hot restart the app

### Debug Mode
```bash
flutter run --debug
```

### Release Mode
```bash
flutter run --release
```

### Profile Mode
```bash
flutter run --profile
```

## 🎯 Next Steps

1. **Customize Design**: Update colors and typography in `config/theme/`
2. **Add Features**: Create new features in `features/` directory
3. **Integrate API**: Replace dummy data with real API calls
4. **Add Authentication**: Implement user login/signup
5. **Deploy**: Build and deploy to app stores

## 📞 Support

For issues or questions:
1. Check the README.md for detailed documentation
2. Review PROJECT_SUMMARY.md for architecture details
3. Check Flutter documentation: https://flutter.dev/docs

## ✅ Checklist

- [ ] Flutter installed and updated
- [ ] Project dependencies installed (`flutter pub get`)
- [ ] App runs successfully (`flutter run`)
- [ ] All screens are accessible
- [ ] Navigation works correctly
- [ ] No console errors

---

**Happy Coding! 🚀**

