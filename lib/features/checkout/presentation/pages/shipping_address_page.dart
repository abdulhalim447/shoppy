import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../home/data/models/product_model.dart';
import '../../data/models/order_model.dart';
import '../providers/delivery_charge_provider.dart';
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

  void _onConfirmAndPay() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Order confirmed! Proceeding to payment...')));
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
                      label: 'CONFIRM AND PAY',
                      onPressed: _onConfirmAndPay,
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
