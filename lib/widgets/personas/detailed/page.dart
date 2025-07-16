import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import 'info.dart';
import 'fusions.dart';
import 'fissions.dart';

/// A detailed page displaying all information about a [Persona].
///
/// This page provides a comprehensive view of a persona with three main tabs:
/// - Info: Basic persona information, stats, and details
/// - Fusions: Available fusion combinations with this persona
/// - Fissions: Available fission combinations to create this persona
class DetailedPersonaPage extends StatefulWidget {
  /// The persona to display detailed information for.
  final Persona persona;

  /// Creates a [DetailedPersonaPage] widget.
  ///
  /// The [persona] parameter is required and represents the persona
  /// whose detailed information will be displayed.
  const DetailedPersonaPage({super.key, required this.persona});

  @override
  State<DetailedPersonaPage> createState() => _DetailedPersonaPageState();
}

class _DetailedPersonaPageState extends State<DetailedPersonaPage> {
  /// The currently selected tab index.
  /// 0 = Info, 1 = Fusions, 2 = Fissions
  int _selectedIndex = 0;

  /// Builds the content for the currently selected tab.
  ///
  /// Returns the appropriate tab content widget based on [_selectedIndex].
  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return InfoTab(persona: widget.persona);
      case 1:
        return FusionsTab(persona: widget.persona);
      case 2:
        return FissionsTab(persona: widget.persona);
      default:
        return const SizedBox.shrink();
    }
  }

  /// Handles tab selection changes.
  ///
  /// [index] - The index of the newly selected tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg1.jpg',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(color: Colors.transparent),
              ),
            ),
            title: Text(widget.persona.name),
            leading: IconButton(
              icon: const FaIcon(FontAwesomeIcons.xmark),
              onPressed: () =>
                  Navigator.of(context).popUntil((Route r) => r.isFirst),
            ),
          ),
          body: _buildTabContent(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: _NavBarIconWithSpacing(
                  icon: FontAwesomeIcons.circleInfo,
                  label: 'Info',
                ),
                label: 'Info',
              ),
              BottomNavigationBarItem(
                icon: _NavBarIconWithSpacing(
                  icon: FontAwesomeIcons.arrowsTurnToDots,
                  label: 'Fusions',
                ),
                label: 'Fusions',
              ),
              BottomNavigationBarItem(
                icon: _NavBarIconWithSpacing(
                  icon: FontAwesomeIcons.arrowsToCircle,
                  label: 'Fissions',
                ),
                label: 'Fissions',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A custom navigation bar icon widget that includes spacing below the icon.
///
/// This widget is used to create consistent spacing in the bottom navigation bar
/// icons, providing better visual alignment and touch targets.
class _NavBarIconWithSpacing extends StatelessWidget {
  /// The icon to display.
  final IconData icon;

  /// The label text (used for accessibility).
  final String label;

  /// Creates a [_NavBarIconWithSpacing] widget.
  ///
  /// Both [icon] and [label] are required parameters.
  const _NavBarIconWithSpacing({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(icon),
        const SizedBox(height: 8), // Spacing for better visual alignment
      ],
    );
  }
}
