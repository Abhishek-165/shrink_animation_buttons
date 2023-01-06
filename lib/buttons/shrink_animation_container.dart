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

  /// The decoration to paint behind the [child].
  final BoxDecoration? decoration;
  final double? height;
  final double? width;

  final Widget child;
  // Called when the widget is clicked
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
    ///initialise the animation controller for the shrink animation on the widget
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: widget.lowerBound,
      upperBound: widget.upperBound,
      // Calls the listener every time the value of the animation changes.
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Called when this _controller object is removed from the tree permanently.
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return GestureDetector(
      // Reverse the state of the controller when the controller changes changed to forward or completed.
      onTapCancel: () {
        if (_controller?.status == AnimationStatus.forward ||
            _controller?.status == AnimationStatus.completed) {
          _tapUp(null);
        }
      },
      onTapDown: _tapDown,
      onTap: widget.onTap,
      onTapUp: _tapUp,

      ///  [ScaleTransition], which animates changes in scale smoothly over a given duration.
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

//Starts running this animation forwards (towards the end).
  void _tapDown(TapDownDetails details) {
    _controller!.forward();
  }

// Starts running this animation in reverse (towards the beginning).
  void _tapUp(TapUpDetails? tapUpDetails) {
    _controller!.reverse();
  }
}
