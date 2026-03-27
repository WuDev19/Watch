import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movie/domain/models/CountryModel.dart';

import '../../../../../core/colors/VColors.dart';
import '../state/SearchState.dart';
import '../state_management/SearchPageManagement.dart';

class CountryWidget extends StatefulWidget {
  final Function(bool isSearchKeyword, String slugCategory) _callback;

  const CountryWidget({
    super.key,
    required Function(bool isSearchKeyword, String slugCategory) callback,
  }) : _callback = callback;

  @override
  State<CountryWidget> createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  late ValueNotifier<int> _selectedCountry;
  late SearchPageManagement _searchPageManagement;
  int _currentIndex = -1;

  @override
  void initState() {
    _selectedCountry = ValueNotifier(-1);
    _searchPageManagement = context.read<SearchPageManagement>();
    super.initState();
  }

  @override
  void dispose() {
    _selectedCountry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      SearchPageManagement,
      SearchState,
      (List<CountryModel>, bool, String?)
    >(
      selector: (SearchState state) =>
          (state.countries, state.isCountriesLoading, state.errorCountries),
      builder: (context, state) {
        if (state.$1.isNotEmpty && state.$2 == false && state.$3 == null) {
          return SizedBox(
            height: 45,
            child: ListView.builder(
              itemBuilder: (context, index) {
                final country = state.$1[index];
                return InkWell(
                  onTap: () {
                    if (_currentIndex != index) {
                      widget._callback(false, country.countrySlug);
                      _currentIndex = index;
                      _selectedCountry.value = index;
                      _searchPageManagement.searchMovieAccordingToCategory(
                        country.countrySlug,
                        true,
                      );
                    }
                  },
                  child: ValueListenableBuilder(
                    valueListenable: _selectedCountry,
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
                            country.countryName,
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
