import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/debounce.dart';
import '../cubit/cubits.dart';

final debounce = Debouncer();

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: TextField(
        onChanged: (String? searchTerm) {
          if (searchTerm != null) {
            debounce.run(() {
              context.read<SearchCharacterCubit>().setSearchTerm(searchTerm);
            });
          }
        },
        decoration: const InputDecoration(
          label: Text('Search character'),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
