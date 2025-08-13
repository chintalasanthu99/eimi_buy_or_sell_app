import 'package:Eimi/utils/text_utils.dart';
import 'package:flutter/material.dart';
import '../utils/app_strings.dart';

class LocationDropdown extends StatelessWidget {
  final String selected;
  final void Function(String) onChanged;

  const LocationDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final locations = [
      AppStrings.hyderabad,
      AppStrings.bangalore,
      AppStrings.chennai,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            AppStrings.selectLocation,
            style: TextUtils.headingStyle(context),
          ),
        ),
        ...locations.map((loc) {
          return RadioListTile<String>(
            activeColor: Theme.of(context).colorScheme.primary,
            title: Text(loc, style: TextUtils.customStyle(context,size: 12)),
            value: loc,
            groupValue: selected,
            onChanged: (val) => onChanged(val!),
          );
        }).toList(),
      ],
    );
  }
}
