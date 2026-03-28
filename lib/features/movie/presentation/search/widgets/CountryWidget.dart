import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movie/domain/models/CountryModel.dart';

import '../../../../../core/colors/VColors.dart';
import '../state/SearchState.dart';
import '../state_management/SearchPageManagement.dart';

class CountryWidget extends StatefulWidget {
  final Function(bool isSearchKeyword, String slugCountry) _callback;
  final Function(bool isClear) _isClear;
  final Function(bool isNewCountry, String countrySlug) _onSearch;

  const CountryWidget({
    super.key,
    required Function(bool isSearchKeyword, String slugCategory) callback,
    required Function(bool isClear) isClear,
    required Function(bool isNewCountry, String countrySlug) onSearch,
  }) : _callback = callback,
       _isClear = isClear,
       _onSearch = onSearch;

  @override
  State<CountryWidget> createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  late ValueNotifier<int> _selectedCountry;
  int _currentIndex = -1;

  @override
  void initState() {
    _selectedCountry = ValueNotifier(-1);
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
                print("index - $_currentIndex va $index");
                return InkWell(
                  onTap: () {
                    if (_currentIndex != index) {
                      print("index - new $index");
                      widget._callback(false, country.countrySlug);
                      widget._isClear(false);
                      widget._onSearch(true, country.countrySlug);
                      _currentIndex = index;
                      _selectedCountry.value = index;
                    } else {
                      widget._isClear(true);
                      _currentIndex = -1;
                      _selectedCountry.value = -1;
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
