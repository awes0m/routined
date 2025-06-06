// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../side_navigation.dart';

/// Represents the toggler widget which is used to change expanded state of [SideNavigationBar]
class SideBarTogglerWidget extends StatefulWidget {
  /// Toggler data obtained from user
  final SideBarToggler togglerData;

  /// The current expanded state of [SideNavigationBar]
  final bool expanded;

  /// What to do when the toggler is pressed
  final VoidCallback onToggle;

  /// Style customizations
  final SideNavigationBarTogglerTheme togglerTheme;

  const SideBarTogglerWidget({
    super.key,
    required this.togglerData,
    required this.expanded,
    required this.onToggle,
    required this.togglerTheme,
  });

  @override
  _SideBarTogglerWidgetState createState() => _SideBarTogglerWidgetState();
}

class _SideBarTogglerWidgetState extends State<SideBarTogglerWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.expanded
            ? widget.togglerData.shrinkIcon
            : widget.togglerData.expandIcon,
        color:
            widget.expanded
                ? widget.togglerTheme.shrinkIconColor
                : widget.togglerTheme.expandIconColor,
      ),
      onPressed: widget.onToggle,
    );
  }
}
