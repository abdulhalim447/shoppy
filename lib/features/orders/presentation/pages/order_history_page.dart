import 'package:flutter/material.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../checkout/data/models/order_model.dart';
import '../widgets/order_card.dart';
import '../widgets/order_timeline.dart';

/// Order history page
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late List<OrderModel> _orders;
  int? _expandedOrderIndex;

  @override
  void initState() {
    super.initState();
    _initializeDummyOrders();
  }

  void _initializeDummyOrders() {
    final now = DateTime.now();
    _orders = [
      OrderModel(
        orderId: '#WH2024-001',
        items: [
          OrderItem(
            productId: '1',
            productName: 'Premium Wireless Headphones',
            price: 149.99,
            quantity: 1,
            productImage: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&h=500&fit=crop',
          ),
        ],
        shippingAddress: ShippingAddress(
          fullName: 'John Doe',
          addressLine1: '123 Main Street',
          city: 'New York',
          state: 'NY',
          zipCode: '10001',
          country: 'United States',
          phoneNumber: '+1 (555) 000-0000',
        ),
        subtotal: 149.99,
        shippingCost: 0,
        total: 149.99,
        status: OrderStatus.outForDelivery,
        orderDate: now.subtract(const Duration(days: 2)),
        estimatedDeliveryDate: now.add(const Duration(days: 2)),
        timeline: [
          OrderTimeline(
            status: OrderStatus.placed,
            title: 'Order Placed',
            description: 'Your order has been confirmed',
            timestamp: now.subtract(const Duration(days: 2, hours: 10)),
            isCompleted: true,
          ),
          OrderTimeline(
            status: OrderStatus.processing,
            title: 'Processing',
            description: 'Order is being prepared at warehouse',
            timestamp: now.subtract(const Duration(days: 1, hours: 15)),
            isCompleted: true,
          ),
          OrderTimeline(
            status: OrderStatus.outForDelivery,
            title: 'Out for Delivery',
            description: 'Package is on the way to Dhaka Hub',
            timestamp: now.subtract(const Duration(hours: 9)),
            isCompleted: true,
          ),
          OrderTimeline(
            status: OrderStatus.delivered,
            title: 'Delivered',
            description: 'Package will be delivered soon',
            timestamp: now,
            isCompleted: false,
          ),
        ],
      ),
      OrderModel(
        orderId: '#WH2024-002',
        items: [
          OrderItem(
            productId: '2',
            productName: 'Gaming Mouse Pro X',
            price: 89.99,
            quantity: 1,
            productImage: 'https://images.unsplash.com/photo-1527814050087-3793815479db?w=500&h=500&fit=crop',
          ),
        ],
        shippingAddress: ShippingAddress(
          fullName: 'John Doe',
          addressLine1: '123 Main Street',
          city: 'New York',
          state: 'NY',
          zipCode: '10001',
          country: 'United States',
          phoneNumber: '+1 (555) 000-0000',
        ),
        subtotal: 89.99,
        shippingCost: 0,
        total: 89.99,
        status: OrderStatus.delivered,
        orderDate: now.subtract(const Duration(days: 7)),
        estimatedDeliveryDate: now.subtract(const Duration(days: 3)),
        timeline: [
          OrderTimeline(
            status: OrderStatus.placed,
            title: 'Order Placed',
            description: 'Your order has been confirmed',
            timestamp: now.subtract(const Duration(days: 7, hours: 3, minutes: 20)),
            isCompleted: true,
          ),
          OrderTimeline(
            status: OrderStatus.processing,
            title: 'Processing',
            description: 'Order prepared and packed',
            timestamp: now.subtract(const Duration(days: 6, hours: 5, minutes: 45)),
            isCompleted: true,
          ),
          OrderTimeline(
            status: OrderStatus.outForDelivery,
            title: 'Out for Delivery',
            description: 'Delivered to Dhaka city',
            timestamp: now.subtract(const Duration(days: 3, hours: 11, minutes: 30)),
            isCompleted: true,
          ),
          OrderTimeline(
            status: OrderStatus.delivered,
            title: 'Delivered',
            description: 'Successfully delivered to your address',
            timestamp: now.subtract(const Duration(days: 3, hours: 4, minutes: 20)),
            isCompleted: true,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MinimalAppBar(title: 'ORDER HISTORY'),
      body: _orders.isEmpty
          ? Center(child: Text('No orders yet', style: Theme.of(context).textTheme.bodyMedium))
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                final isExpanded = _expandedOrderIndex == index;

                return Column(
                  children: [
                    // Order Card
                    OrderCard(
                      order: order,
                      onTap: () {
                        setState(() {
                          _expandedOrderIndex = isExpanded ? null : index;
                        });
                      },
                    ),

                    // Timeline (shown when expanded)
                    if (isExpanded && order.timeline != null)
                      Container(
                        padding: const EdgeInsets.all(AppConstants.spacingMd),
                        margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: OrderTimelineWidget(timeline: order.timeline!),
                      ),
                  ],
                );
              },
            ),
    );
  }
}
