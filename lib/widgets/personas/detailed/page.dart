import 'package:flutter/material.dart';
import 'package:persona_data/lib.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'info.dart';
import 'fusions.dart';
import 'fissions.dart';

/// A detailed page displaying all information about a [Persona].
class DetailedPersonaPage extends StatefulWidget {
  /// The persona to display.
  final Persona persona;
  const DetailedPersonaPage({super.key, required this.persona});

  @override
  State<DetailedPersonaPage> createState() => _DetailedPersonaPageState();
}

class _DetailedPersonaPageState extends State<DetailedPersonaPage> {
  int _selectedIndex = 0;

  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return InfoTab(persona: widget.persona);
      case 1:
        return const FusionsTab();
      case 2:
        return const FissionsTab();
      default:
        return const SizedBox.shrink();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    );
  }
}

class _NavBarIconWithSpacing extends StatelessWidget {
  final IconData icon;
  final String label;

  const _NavBarIconWithSpacing({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(icon),
        const SizedBox(height: 8), // Adjust this value for more/less spacing
      ],
    );
  }
}
