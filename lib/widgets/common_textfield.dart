import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum FieldType { text, dropdown }

class ModelDropdown {
  final String id;
  final String name;

  ModelDropdown({required this.id, required this.name});

  factory ModelDropdown.fromJson(Map<String, dynamic> json) {
    return ModelDropdown(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CommonTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final bool compulsory;
  final FieldType type;
  final TextInputType keyboardType;
  final Function(ModelDropdown item)? onSelectDropdown;
  final List<ModelDropdown> dropdownList;
  final String? regex;
  const CommonTextfield({
    super.key,
    required this.controller,
    required this.label,
    this.dropdownList = const [],
    this.compulsory = false,
    this.type = FieldType.text,
    this.keyboardType = TextInputType.text,
    this.hintText = "Enter text",
    this.regex,
    this.onSelectDropdown,
  });

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  void _showDropdownDialog() async {
    TextEditingController searchController = TextEditingController();
    List<ModelDropdown> filteredList = widget.dropdownList;

    final selectedValue = await showDialog<ModelDropdown>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label ?? 'Select an option',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            filteredList = widget.dropdownList
                                .where((item) => item.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: double.maxFinite,
                        child: filteredList.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                itemCount: filteredList.length,
                                itemBuilder: (context, index) {
                                  final item = filteredList[index];
                                  return ListTile(
                                    title: Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop(item);
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                  height: 1, // Reduces the space between items
                                ),
                              )
                            : const Center(
                                child: Text('No results found'),
                              ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
    if (selectedValue != null && widget.onSelectDropdown != null) {
      widget.onSelectDropdown!(selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Row(
            children: [
              Text(
                widget.label!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 5),
              if (widget.compulsory)
                const Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                )
            ],
          ),
        if (widget.label != null) const SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            if (widget.type == FieldType.dropdown) {
              _showDropdownDialog();
            }
          },
          child: AbsorbPointer(
            absorbing: widget.type == FieldType.dropdown,
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              readOnly: widget.type == FieldType.dropdown,
              validator: (value) {
                if (widget.regex != null &&
                    !RegExp(widget.regex!).hasMatch(value!)) {
                  return 'Invalid format';
                } else if (widget.compulsory && value!.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: widget.type == FieldType.dropdown
                    ? PhosphorIcon(
                        PhosphorIcons.caretDown(),
                        size: 20,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
