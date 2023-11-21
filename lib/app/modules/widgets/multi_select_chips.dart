import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/data/models/product_category.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MultiSelectChip extends StatefulWidget {
  final List<ProductCategory> reportList;
  final Function(List<ProductCategory>)? onSelectionChanged;
  final Function(List<ProductCategory>)? onMaxSelected;
  final int? maxSelection;

  const MultiSelectChip(this.reportList,
      {super.key,
      this.onSelectionChanged,
      this.onMaxSelected,
      this.maxSelection});

  @override
  State<MultiSelectChip> createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<ProductCategory> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.reportList) {
      choices.add(Container(
        padding: const EdgeInsets.all(8.0),
        child: ChoiceChip(
          padding: const EdgeInsets.all(15.0),
          label: Text(
            item.name ?? '',
            style: TextStyle(
                color: selectedChoices.contains(item)
                    ? Colors.white
                    : Colors.black),
          ),
          selected: selectedChoices.contains(item),
          backgroundColor: HexColor("#F5FCED"),
          selectedColor: AppColors.appTheme,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.appTheme),
          ),
          onSelected: (selected) {
            if (selectedChoices.length == (widget.maxSelection ?? -1) &&
                !selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                widget.onSelectionChanged?.call(selectedChoices);
              });
            }
          },
        ),
      ));
    }

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
