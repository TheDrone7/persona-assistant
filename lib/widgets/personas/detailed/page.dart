import 'package:flutter/material.dart';
import 'package:persona_assistant/widgets/personas/detailed/unlock.dart';
import 'package:persona_data/lib.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persona_assistant/widgets/common/section_header.dart';
import 'package:persona_assistant/widgets/common/section_spacing.dart';
import 'package:persona_assistant/types/padding.dart';

import 'arcana.dart';
import 'stats.dart';
import 'affinities.dart';
import 'skills.dart';
import 'inherits.dart';

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
        return ListView(
          children: [
            DetailedPersonaPageArcanaBox(
              arcana: widget.persona.arcana,
              level: widget.persona.level,
              isSpecial: widget.persona.hasSpecialFusion,
            ),
            if (widget.persona.unlockMethod != PersonaUnlockMethod.level) ...[
              const SectionSpacing(),
              const SectionHeader(
                title: 'Requirements',
                padding: EdgeInsets.symmetric(
                  horizontal: CommonPadding.horizontal,
                  vertical: CommonPadding.requirementsVertical,
                ),
              ),
              DetailedPersonaUnlockMethodBox(
                details:
                    widget.persona.unlockMethod == PersonaUnlockMethod.locked
                    ? "A party member's unique persona."
                    : widget.persona.fusionCondition ?? '',
                short: widget.persona.conditionShort,
              ),
            ],
            const SectionSpacing(),
            const SectionHeader(title: 'Persona Stats'),
            DetailedPersonaPageStatsBox(stats: widget.persona.stats),
            const SectionSpacing(),
            const SectionHeader(title: 'Combat Affinities'),
            DetailedPersonaPageAffinitiesBox(
              affinities: widget.persona.resistances,
            ),
            const SectionSpacing(),
            const SectionHeader(title: 'Skills'),
            DetailedPersonaPageSkillsList(skills: widget.persona.skills),
            const SectionSpacing(),
            const SectionHeader(title: 'Fusion Inheritance Types'),
            DetailedPersonaPageInheritanceBox(
              inherits: widget.persona.inheritanceType,
            ),
            const SectionSpacing(),
          ],
        );
      case 1:
        return const Center(child: Text('Fusions'));
      case 2:
        return const Center(child: Text('Fissions'));
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.merge_type),
            label: 'Fusions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_split),
            label: 'Fissions',
          ),
        ],
      ),
    );
  }
}
