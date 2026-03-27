import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/colors/VColors.dart';
import '../../../domain/models/CategoryModel.dart';
import '../state/SearchState.dart';
import '../state_management/SearchPageManagement.dart';

class CategoryWidget extends StatefulWidget {
  final Function(bool isSearchKeyword, String slugCategory) _callback;

  const CategoryWidget({
    super.key,
    required Function(bool isSearchKeyword, String slugCategory) callback,
  }) : _callback = callback;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late ValueNotifier<int> _selectedCategory;
  late SearchPageManagement _searchPageManagement;
  int _currentIndex = -1;

  @override
  void initState() {
    _selectedCategory = ValueNotifier(-1);
    _searchPageManagement = context.read<SearchPageManagement>();
    context.read<SearchPageManagement>().getCategories();
    super.initState();
  }

  @override
  void dispose() {
    _selectedCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      SearchPageManagement,
      SearchState,
      (List<CategoryModel>, bool, String?)
    >(
      selector: (SearchState state) =>
          (state.categories, state.isCategoriesLoading, state.errorCategories),
      builder: (context, state) {
        if (state.$1.isNotEmpty && state.$2 == false && state.$3 == null) {
          return SizedBox(
            height: 45,
            child: ListView.builder(
              itemBuilder: (context, index) {
                final category = state.$1[index];
                return InkWell(
                  onTap: () {
                    if (_currentIndex != index) {
                      widget._callback(false, category.categorySlug);
                      _currentIndex = index;
                      _selectedCategory.value = index;
                      _searchPageManagement.searchMovieAccordingToCategory(
                        category.categorySlug,
                        true,
                      );
                    }
                  },
                  child: ValueListenableBuilder(
                    valueListenable: _selectedCategory,
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
                            category.category,
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
