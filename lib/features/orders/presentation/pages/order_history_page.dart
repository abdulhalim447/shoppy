import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../providers/order_history_provider.dart';
import '../widgets/order_card.dart';
import '../widgets/order_timeline.dart';

/// Order history page
class OrderHistoryPage extends ConsumerStatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends ConsumerState<OrderHistoryPage> {
  int? _expandedOrderIndex;

  @override
  void initState() {
    super.initState();
    // Fetch order history when the page loads
    Future.microtask(() => ref.read(orderHistoryProvider.notifier).fetchOrderHistory());
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderHistoryProvider);
    final orders = orderState.orders;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MinimalAppBar(title: 'ORDER HISTORY'),
      body: orderState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : orderState.error != null
          ? Center(child: Text(orderState.error!))
          : orders.isEmpty
          ? Center(child: Text('No orders yet', style: Theme.of(context).textTheme.bodyMedium))
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
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
                    if (isExpanded)
                      Container(
                        padding: const EdgeInsets.all(AppConstants.spacingMd),
                        margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: OrderTimelineWidget(
                          status: order.status,
                          createdAt: order.createdAt,
                          updatedAt: order.updatedAt,
                        ),
                      ),
                  ],
                );
              },
            ),
    );
  }
}
