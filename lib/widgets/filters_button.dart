import 'package:flutter/material.dart';

class FiltersButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final IconData? icon;

  const FiltersButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          ),
          backgroundColor: WidgetStatePropertyAll<Color>(
            backgroundColor ??
                Theme.of(context).colorScheme.onSecondary.withAlpha(60),
          ),
          foregroundColor: WidgetStatePropertyAll<Color>(
            Theme.of(context).colorScheme.onSurface,
          ),
          minimumSize: WidgetStatePropertyAll<Size>(const Size(0, 24.0)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: child,
      );
    }

    return TextButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        ),
        backgroundColor: WidgetStatePropertyAll<Color>(
          backgroundColor ??
              Theme.of(context).colorScheme.onSecondary.withAlpha(60),
        ),
        foregroundColor: WidgetStatePropertyAll<Color>(
          Theme.of(context).colorScheme.onSurface,
        ),
        minimumSize: WidgetStatePropertyAll<Size>(const Size(0, 24.0)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: Icon(icon),
      label: child,
    );
  }
}
