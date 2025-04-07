// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../side_navigation.dart';

/// Represents the footer widget which is rendered on the screen
///
/// Makes use of the [SideNavigationBarFooter] data interface to build the footer
class SideNavigationBarFooterWidget extends StatefulWidget {
  /// Footer data obtained from user
  final SideNavigationBarFooter footerData;

  /// Whether [SideNavigationBar] is expandable at all
  final bool expandable;

  /// The current expanded state of [SideNavigationBar]
  final bool expanded;

  /// [SideNavigationBar.initiallyExpanded] value
  final bool initiallyExpanded;

  const SideNavigationBarFooterWidget({
    super.key,
    required this.footerData,
    required this.expandable,
    required this.expanded,
    required this.initiallyExpanded,
  });

  @override
  _SideNavigationBarFooterWidgetState createState() =>
      _SideNavigationBarFooterWidgetState();
}

class _SideNavigationBarFooterWidgetState
    extends State<SideNavigationBarFooterWidget> {
  @override
  Widget build(BuildContext context) {
    return _determineFooterWidget();
  }

  /// Determines the footer widget based on [expandable] and [expanded]
  Widget _determineFooterWidget() {
    if (widget.expandable) {
      if (widget.expanded) {
        return _FooterWidget(footerData: widget.footerData);
      } else {
        return Container();
      }
    } else {
      if (widget.initiallyExpanded) {
        return _FooterWidget(footerData: widget.footerData);
      } else {
        return Container();
      }
    }
  }
}

/// Internal Widget to just handle displaying data
class _FooterWidget extends StatefulWidget {
  final SideNavigationBarFooter footerData;
  const _FooterWidget({required this.footerData});

  @override
  _FooterWidgetState createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<_FooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: widget.footerData.label,
          ),
        ],
      ),
    );
  }
}
