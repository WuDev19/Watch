import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/VColors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../domain/models/EpisodeList.dart';

class PageWidget extends StatefulWidget {
  final Map<int, List<EpisodeList>> pagination;
  final Function(List<EpisodeList> episodeList) onChoosePage;

  const PageWidget({super.key, required this.pagination, required this.onChoosePage});

  @override
  State<PageWidget> createState() => _PageWidgetState();
}

class _PageWidgetState extends State<PageWidget> {
  late final ItemScrollController _itemScrollController;
  int destination = 0;
  late final ValueNotifier<int> previous;
  late final ValueNotifier<int> next;

  @override
  void initState() {
    super.initState();
    _itemScrollController = ItemScrollController();
    previous = ValueNotifier(destination);
    next = ValueNotifier(destination);
  }

  // mai fix lại
  @override
  Widget build(BuildContext context) {
    int length = widget.pagination.length;
    final List<int> pages = widget.pagination.keys.toList()..sort();
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              scrollToIndex(destination - 3, length);
              previous.value = destination;
              next.value = destination;
            },
            child: ValueListenableBuilder(
              valueListenable: previous,
              builder: (context, value, child) {
                return Icon(
                  Icons.skip_previous,
                  color: value != 0 ? VColors.colorIcon : VColors.greySearch,
                );
              },
            ),
          ),
          SizedBox(
            width: length >= 3
                ? 132
                : length >= 2
                ? 88
                : 44,
            child: ScrollablePositionedList.builder(
              itemScrollController: _itemScrollController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: length,
              itemBuilder: (context, index) {
                final page = pages[index];
                return GestureDetector(
                  onTap: () {
                    widget.onChoosePage(widget.pagination[page]!);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: VColors.greySearch,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    width: 40,
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              scrollToIndex(destination + 3, length);
              next.value = destination;
              previous.value = destination;
            },
            child: ValueListenableBuilder(
              valueListenable: next,
              builder: (context, value, child) {
                return Icon(
                  Icons.skip_next,
                  color: value != length - 1
                      ? VColors.colorIcon
                      : VColors.greySearch,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void scrollToIndex(int newIndex, int length) {
    final safeIndex = newIndex.clamp(
      0,
      length - 1,
    ); // trả về trong khoảng an toàn
    destination = safeIndex;
    _itemScrollController.scrollTo(
      index: safeIndex,
      duration: const Duration(milliseconds: 500),
    );
  }
}
