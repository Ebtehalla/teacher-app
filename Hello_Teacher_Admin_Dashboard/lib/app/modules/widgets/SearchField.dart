import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';

class SearchField extends StatelessWidget {
  final void Function(String) onQueryChange;
  final VoidCallback? onSearch;
  final VoidCallback? onClear;
  final String searchQuery;
  final TextEditingController? textEditingController;
  // final TextEditingController searchTextController = TextEditingController();
  SearchField(
      {Key? key,
      required this.onQueryChange,
      required this.searchQuery,
      this.onClear,
      this.onSearch,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        // Just return the search query text, don't call the callback here
        onQueryChange(value);
      },
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: "Search",
          fillColor: secondaryColor,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
            onTap: onSearch,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding * 0.75),
              margin:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset("assets/icons/Search.svg"),
            ),
          ),
          suffix: IntrinsicWidth(
            child: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                if (textEditingController != null) {
                  textEditingController!.clear();
                }
                if (onClear != null) {
                  onClear!();
                }
              },
            ),
          )),
    );
  }
}
