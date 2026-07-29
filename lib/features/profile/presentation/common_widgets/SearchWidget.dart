import 'package:flutter/material.dart';

import '../../../../core/colors/VColors.dart';

class SearchWidget extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final void Function(String content) onSearch;
  final void Function() onEmpty;
  final void Function(String value)? onChange;

  const SearchWidget({
    super.key,
    required this.hint,
    required this.onSearch,
    required this.controller,
    required this.onEmpty,
    this.onChange,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final ValueNotifier<String> _isTyping = ValueNotifier("");

  @override
  void dispose() {
    _isTyping.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: TextField(
        controller: widget.controller,
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          _isTyping.value = value;
          if (widget.onChange != null) {
            widget.onChange!(value);
          }
        },
        onSubmitted: (value) {
          if (value.isNotEmpty) widget.onSearch(value);
        },
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: VColors.white.withAlpha(120)),
          prefixIcon: GestureDetector(
            onTap: () => widget.onSearch(widget.controller.text.trim()),
            child: Icon(Icons.search, color: VColors.white.withAlpha(150)),
          ),
          suffixIcon: ValueListenableBuilder(
            valueListenable: _isTyping,
            builder: (context, value, child) =>
                Visibility(visible: value.isNotEmpty, child: child!),
            child: IconButton(
              icon: Icon(
                Icons.clear_rounded,
                color: VColors.white.withAlpha(150),
              ),
              onPressed: () {
                widget.onEmpty();
                widget.controller.clear();
                _isTyping.value = "";
              },
            ),
          ),
          filled: true,
          fillColor: Colors.grey[900],
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
