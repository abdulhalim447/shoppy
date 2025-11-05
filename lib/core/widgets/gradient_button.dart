import 'package:flutter/material.dart';

import '../../config/constants/app_constants.dart';
import '../../config/theme/app_colors.dart';

/// A custom gradient button with blue-to-purple gradient
class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double height;
  final LinearGradient? gradient;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final double elevation;

  const GradientButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height = 56,
    this.gradient,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.elevation = 0,
  }) : super(key: key);

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: AppConstants.animationDurationFast, vsync: this);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.isEnabled && !widget.isLoading) {
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final gradient = widget.gradient ?? AppColors.ctaGradient;
    final opacity = widget.isEnabled && !widget.isLoading ? 1.0 : 0.5;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.isEnabled && !widget.isLoading ? widget.onPressed : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: widget.borderRadius,
            boxShadow: [
              if (widget.elevation > 0)
                BoxShadow(
                  color: AppColors.neonBlue.withOpacity(0.3),
                  blurRadius: widget.elevation,
                  offset: Offset(0, widget.elevation / 2),
                ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.isEnabled && !widget.isLoading ? widget.onPressed : null,
              borderRadius: widget.borderRadius,
              child: Opacity(
                opacity: opacity,
                child: Center(
                  child: widget.isLoading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.textPrimary.withOpacity(0.8)),
                          ),
                        )
                      : Text(
                          widget.label,
                          style:
                              widget.textStyle ??
                              const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                                letterSpacing: 0.5,
                              ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
