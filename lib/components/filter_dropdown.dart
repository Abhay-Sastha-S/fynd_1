import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data_provider.dart';

class FilterModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Column(
      children: [
        Text('Filters',style: TextStyle(fontWeight: FontWeight.bold)),
        
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
          child: Wrap(
            spacing: 8.0,
            children: dataProvider.selectedFilters.entries
                .expand((entry) => entry.value.map((value) => FilterChip(
                      label: Text(value),
                      selected: true,
                      onSelected: (selected) {
                        if (!selected) {
                          dataProvider.toggleFilter(entry.key, value);
                        }
                      },
                    )))
                .toList(),
          ),
        ),
        FilterDropdown(
          title: 'Brand',
          options: ['Brand A', 'Brand B', 'Brand C'],
        ),
        FilterDropdown(
          title: 'Color',
          options: ['Red', 'Blue', 'Green'],
        ),
        FilterDropdown(
          title: 'Size',
          options: ['S', 'M', 'L', 'XL'],
        ),
        FilterDropdown(
          title: 'Price Range',
          options: ['\$0 - \$50', '\$50 - \$100', '\$100 - \$200'],
        ),
        FilterDropdown(
          title: 'Material',
          options: ['Cotton', 'Polyester', 'Wool'],
        ),
        FilterDropdown(
          title: 'Type',
          options: ['T-Shirts', 'Jeans', 'Dresses'],
        ),
      ],
    );
  }
}

class FilterDropdown extends StatelessWidget {
  final String title;
  final List<String> options;

  FilterDropdown({
    required this.title,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(title),
        children: options.map((String option) {
          return CheckboxListTile(
            title: Text(option),
            value: dataProvider.selectedFilters[title]?.contains(option) ?? false,
            onChanged: (bool? value) {
              dataProvider.toggleFilter(title, option);
            },
          );
        }).toList(),
      ),
    );
  }
}