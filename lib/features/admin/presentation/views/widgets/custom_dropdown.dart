
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key, required this.menuList,required this.onChanged});
  final List<String> menuList;
    final ValueChanged<String?> onChanged;

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  
  String? selectedCategory;
 

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCategory,
      hint: Text('Select Category'),
      items: widget.menuList.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedCategory = newValue;
        });
        widget.onChanged(newValue);
      },
    );
  }
}