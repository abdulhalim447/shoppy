import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/text_styles.dart';

/// Custom bottom navigation bar item
class BottomNavItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  BottomNavItem({required this.icon, required this.label, required this.onTap});
}

/// Custom bottom navigation bar with neon accent
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavItem> items;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.items,
    this.backgroundColor = AppColors.background,
    this.activeColor = AppColors.neonBlue,
    this.inactiveColor = AppColors.textSecondary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (index) => _BottomNavBarItem(
                item: items[index],
                isActive: index == currentIndex,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Individual bottom navigation bar item
class _BottomNavBarItem extends StatefulWidget {
  final BottomNavItem item;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;

  const _BottomNavBarItem({
    Key? key,
    required this.item,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
  }) : super(key: key);

  @override
  State<_BottomNavBarItem> createState() => _BottomNavBarItemState();
}

class _BottomNavBarItemState extends State<_BottomNavBarItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    if (widget.isActive) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(_BottomNavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _animationController.forward();
    } else if (!widget.isActive && oldWidget.isActive) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.item.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.item.icon, color: widget.isActive ? widget.activeColor : widget.inactiveColor, size: 24),
            const SizedBox(height: 4),
            Text(
              widget.item.label,
              style: AppTextStyles.labelSmall.copyWith(
                color: widget.isActive ? widget.activeColor : widget.inactiveColor,
                fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
