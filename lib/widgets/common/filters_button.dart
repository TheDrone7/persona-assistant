import 'package:flutter/material.dart';

/// A customizable button used for filter and sort controls, supporting optional icons and custom background color.
///
/// This button adapts its style based on the pressed state and can display an icon either at the start or end.
class FiltersButton extends StatelessWidget {
  /// The main content of the button, usually a [Text] widget.
  final Widget child;

  /// Callback when the button is pressed.
  final VoidCallback onPressed;

  /// Optional background color for the button.
  final Color? backgroundColor;

  /// Optional icon to display alongside the [child].
  final Widget? icon;

  /// Alignment for the icon (start or end).
  final IconAlignment iconAlignment;

  /// Creates a [FiltersButton] with optional icon and background color.
  const FiltersButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.icon,
    this.iconAlignment = IconAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      side: WidgetStateProperty.resolveWith<BorderSide>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          );
        }
        return BorderSide(
          color: Theme.of(context).colorScheme.outline.withAlpha(128),
        );
      }),
      padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return Theme.of(context).colorScheme.primary.withAlpha(20);
        }
        return backgroundColor ??
            Theme.of(context).colorScheme.onSecondary.withAlpha(60);
      }),
      foregroundColor: WidgetStatePropertyAll<Color>(
        Theme.of(context).colorScheme.onSurface,
      ),
      minimumSize: const WidgetStatePropertyAll<Size>(Size(0, 24.0)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    if (icon == null) {
      return TextButton(
        onPressed: onPressed,
        style: style.copyWith(
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
          ),
        ),
        child: child,
      );
    }

    return TextButton.icon(
      onPressed: onPressed,
      style: style,
      icon: icon,
      label: child,
      iconAlignment: iconAlignment,
    );
  }
}
