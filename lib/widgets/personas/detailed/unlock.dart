import 'package:flutter/material.dart';
import '../../common/card.dart' as common;

class DetailedPersonaUnlockMethodBox extends StatelessWidget {
  final String details;
  final String short;

  const DetailedPersonaUnlockMethodBox({
    super.key,
    required this.details,
    required this.short,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12.0),
      child: common.Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                short,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                details.isNotEmpty ? details : 'No specific unlock method',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
