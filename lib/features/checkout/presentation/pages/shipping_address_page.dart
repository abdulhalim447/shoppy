import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../home/data/models/product_model.dart';
import '../../data/models/order_model.dart';
import '../providers/delivery_charge_provider.dart';
import '../providers/order_provider.dart';
import '../providers/quantity_provider.dart';
import '../providers/total_amount_provider.dart';
import '../widgets/address_form.dart';
import '../widgets/product_order_summary.dart';

/// Shipping address page for checkout
class ShippingAddressPage extends ConsumerStatefulWidget {
  final ProductModel? product;
  final OrderModel? order;

  const ShippingAddressPage({Key? key, this.product, this.order}) : super(key: key);

  @override
  ConsumerState<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends ConsumerState<ShippingAddressPage> {
  late ShippingAddress _currentAddress;
  bool _isPlacingOrder = false;

  @override
  void initState() {
    super.initState();
    _currentAddress =
        widget.order?.shippingAddress ??
        ShippingAddress(
          fullName: '',
          addressLine1: '',
          addressLine2: '',
          city: '',
          state: '',
          zipCode: '',
          country: '',
          phoneNumber: '',
        );
    Future.microtask(() => ref.read(deliveryChargeProvider.notifier).fetchDeliveryCharges());
  }

  void _onAddressChanged(ShippingAddress address) {
    setState(() {
      _currentAddress = address;
    });
  }

  void _onConfirmAndPay() async {
    setState(() {
      _isPlacingOrder = true;
    });

    final localStorageService = LocalStorageService();
    final guestUsername = await localStorageService.getGuestUsername();
    final totalAmount = ref.read(totalAmountProvider);
    final quantity = ref.read(quantityProvider);

    final orderData = {
      "product_id": widget.product!.id,
      "customer_name": _currentAddress.fullName,
      "full_name": _currentAddress.fullName,
      "phone_number": _currentAddress.phoneNumber,
      "address_line1": _currentAddress.addressLine1,
      "address_line2": _currentAddress.addressLine2,
      "state": _currentAddress.state,
      "country": _currentAddress.country,
      "delivery_place": "dhaka", // This should be dynamic based on selection
      "quantity": quantity.toString(),
      "address": "${_currentAddress.addressLine1}, ${_currentAddress.addressLine2}",
      "city": _currentAddress.city,
      "userId": guestUsername,
      "postal_code": _currentAddress.zipCode,
      "total": totalAmount.toString(),
    };

    ref
        .read(orderProvider.notifier)
        .placeOrder(orderData: orderData)
        .then((_) {
          final orderState = ref.read(orderProvider);
          if (orderState.error == null && orderState.orderResponse != null) {
            localStorageService.saveGuestUsername(orderState.orderResponse!.guestUsername);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed successfully!')));
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(orderState.error ?? 'Failed to place order')));
          }
        })
        .whenComplete(() {
          setState(() {
            _isPlacingOrder = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MinimalAppBar(title: 'SHIPPING ADDRESS'),
      body: widget.product == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_bag_outlined, size: 64, color: AppColors.textSecondary),
                  const SizedBox(height: 16),
                  const Text('No product selected'),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Go Back')),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Order Summary
                    ProductOrderSummary(product: widget.product!),
                    const SizedBox(height: AppConstants.spacingLg),

                    // Address Form
                    AddressForm(initialAddress: _currentAddress, onAddressChanged: _onAddressChanged),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Confirm and Pay Button
                    GradientButton(
                      label: 'PLACE ORDER',
                      onPressed: _onConfirmAndPay,
                      isLoading: _isPlacingOrder,
                      width: double.infinity,
                      height: 56,
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                  ],
                ),
              ),
            ),
    );
  }
}
