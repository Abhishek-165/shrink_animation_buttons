import 'package:flutter/material.dart';

class ShrinkAnimationContainer extends StatefulWidget {
  const ShrinkAnimationContainer({
    this.decoration,
    this.height,
    this.width,
    super.key,
    this.onTap,
    this.duration = const Duration(
      milliseconds: 400,
    ),
    this.lowerBound = 0.0,
    this.upperBound = 0.03,
    this.margin,
    this.padding,
    this.alignment,
    this.color,
    this.foregroundDecoration,
    this.constraints,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    required this.child,
  });
  final BoxDecoration? decoration;
  final double? height;
  final double? width;
  final Widget child;
  final VoidCallback? onTap;
  //The value at which this animation is deemed to be dismissed.
  final double lowerBound;
  //The value at which this animation is deemed to be completed.
  final double upperBound;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  //The length of time this animation should last.
  //If [reverseDuration] is specified, then [duration] is only used when going [forward]. Otherwise, it specifies the duration going in both directions.
  final Duration duration;
  final AlignmentGeometry? alignment;
  final Color? color;
  final Decoration? foregroundDecoration;
  final BoxConstraints? constraints;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior;
  @override
  State createState() => _ShrinkAnimationContainerState();
}

class _ShrinkAnimationContainerState extends State<ShrinkAnimationContainer>
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
        child: Container(
            alignment: widget.alignment,
            margin: widget.margin,
            padding: widget.padding,
            height: widget.height,
            width: widget.width,
            color: widget.color,
            foregroundDecoration: widget.foregroundDecoration,
            decoration: widget.decoration,
            constraints: widget.constraints,
            transformAlignment: widget.transformAlignment,
            clipBehavior: widget.clipBehavior,
            child: widget.child),
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
