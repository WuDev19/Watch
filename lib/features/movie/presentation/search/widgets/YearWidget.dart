import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movie/domain/models/YearModel.dart';

import '../../../../../core/colors/VColors.dart';
import '../state/SearchState.dart';
import '../state_management/SearchPageManagement.dart';

class YearWidget extends StatefulWidget {
  final Function(bool isSearchKeyword, int year) _callback;

  const YearWidget({
    super.key,
    required Function(bool isSearchKeyword, int year) callback,
  }) : _callback = callback;

  @override
  State<YearWidget> createState() => _YearWidgetState();
}

class _YearWidgetState extends State<YearWidget> {
  late ValueNotifier<int> _selectedYear;
  late SearchPageManagement _searchPageManagement;
  int _currentIndex = -1;

  @override
  void initState() {
    _selectedYear = ValueNotifier(-1);
    _searchPageManagement = context.read<SearchPageManagement>();
    super.initState();
  }

  @override
  void dispose() {
    _selectedYear.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      SearchPageManagement,
      SearchState,
      (List<YearModel>, bool, String?)
    >(
      selector: (SearchState state) =>
          (state.years, state.isYearsLoading, state.errorYears),
      builder: (context, state) {
        if (state.$1.isNotEmpty && state.$2 == false && state.$3 == null) {
          return SizedBox(
            height: 45,
            child: ListView.builder(
              itemBuilder: (context, index) {
                final year = state.$1[index];
                return InkWell(
                  onTap: () {
                    if (_currentIndex != index) {
                      widget._callback(false, year.year);
                      _currentIndex = index;
                      _selectedYear.value = index;
                      _searchPageManagement.searchMovieAccordingToCategory(
                        year.year.toString(),
                        true,
                      );
                    }
                  },
                  child: ValueListenableBuilder(
                    valueListenable: _selectedYear,
                    builder: (BuildContext context, value, Widget? child) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: value == index
                              ? VColors.colorIcon
                              : VColors.greySearch,
                          borderRadius: const BorderRadiusGeometry.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            year.year.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              itemCount: state.$1.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
