import 'package:flutter/material.dart';

class ShrinkAnimationCard extends StatefulWidget {
  const ShrinkAnimationCard({
    this.color,
    this.elevation,
    super.key,
    this.onTap,
    this.clipBehavior,
    this.duration = const Duration(
      milliseconds: 400,
    ),
    this.lowerBound = 0.0,
    this.upperBound = 0.03,
    this.shadowColor,
    this.surfaceTintColor,
    this.borderOnForeground = true,
    this.semanticContainer = true,
    this.margin,
    required this.child,
    this.shape,
  });

  final double? elevation;
  //The value at which this animation is deemed to be dismissed.
  final double lowerBound;
  //The value at which this animation is deemed to be completed.
  final double upperBound;
  final Widget child;
  final VoidCallback? onTap;
  final Clip? clipBehavior;
  final Color? color;
  //The length of time this animation should last.
  //If [reverseDuration] is specified, then [duration] is only used when going [forward]. Otherwise, it specifies the duration going in both directions.
  final Duration duration;
  final ShapeBorder? shape;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final bool borderOnForeground;
  final bool semanticContainer;
  final EdgeInsetsGeometry? margin;
  @override
  State createState() => _ShrinkAnimationCardState();
}

class _ShrinkAnimationCardState extends State<ShrinkAnimationCard>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: widget.lowerBound,
      upperBound: widget.upperBound,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return GestureDetector(
      onTapCancel: () {
        if (_controller?.status == AnimationStatus.forward ||
            _controller?.status == AnimationStatus.completed) {
          _tapUp(null);
        }
      },
      onTapDown: _tapDown,
      onTap: widget.onTap,
      onTapUp: _tapUp,
      child: Transform.scale(
        scale: _scale,
        child: Card(
          key: widget.key,
          color: widget.color,
          shadowColor: widget.shadowColor,
          surfaceTintColor: widget.surfaceTintColor,
          elevation: widget.elevation,
          shape: widget.shape,
          borderOnForeground: widget.borderOnForeground,
          margin: widget.margin,
          clipBehavior: widget.clipBehavior,
          semanticContainer: widget.semanticContainer,
          child: widget.child,
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller!.forward();
  }

  void _tapUp(TapUpDetails? tapUpDetails) {
    _controller!.reverse();
  }
}
