import 'dart:developer';
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
  final bool disable;
  final TextInputType keyboardType;
  final Function? onSuffixIconPressed;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Function(ModelDropdown item)? onSelectDropdown;
  final Function(String value)? onChangeValue;
  final Function? onTap;
  final List<ModelDropdown>? dropdownList;
  final Future<List<ModelDropdown>>? fetchDropdown;
  final TextEditingController? searchController;
  final bool searchInNetwork;
  final String? regex;

  const CommonTextfield({
    super.key,
    required this.controller,
    this.label,
    this.prefixIcon,
    this.onChangeValue,
    this.dropdownList,
    this.fetchDropdown,
    this.searchInNetwork = false,
    this.searchController,
    this.disable = false,
    this.compulsory = false,
    this.type = FieldType.text,
    this.keyboardType = TextInputType.text,
    this.hintText = "Enter text",
    this.regex,
    this.onSuffixIconPressed,
    this.suffixIcon,
    this.onTap,
    this.onSelectDropdown,
  });

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  List<ModelDropdown> dropdownList = [];
  bool isLoadingDropdown = true;

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    if (widget.fetchDropdown != null) {
      try {
        log("Searching Function: ${widget.fetchDropdown}");
        dropdownList = await widget.fetchDropdown!;
        log("Searching Function2 : ${dropdownList.toString()}");
      } catch (e) {
        log("Error fetching dropdown data: $e");
      }
    } else if (widget.dropdownList != null) {
      dropdownList = widget.dropdownList!;
    }

    setState(() {
      isLoadingDropdown = false;
    });
  }

  void _showDropdownDialog() async {
    if (dropdownList.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No items found")));
      return;
    }

    TextEditingController searchController =
        widget.searchController ?? TextEditingController();
    List<ModelDropdown> filteredList = dropdownList;

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
                        if (widget.searchInNetwork) {
                          log("Searching in network");
                          _loadDropdownData();
                        } else {
                          setState(() {
                            filteredList = dropdownList
                                .where((item) => item.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        }
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
                                height: 1,
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
      },
    );

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
            if (widget.onTap != null) {
              widget.onTap!();
            } else if (widget.type == FieldType.dropdown &&
                !isLoadingDropdown) {
              _showDropdownDialog();
            }
          },
          child: AbsorbPointer(
            absorbing: widget.type == FieldType.dropdown,
            child: TextFormField(
              controller: widget.controller,
              enabled: !widget.disable,
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
              onChanged: (value) {
                if (widget.onChangeValue != null) {
                  widget.onChangeValue!(value);
                }
              },
              decoration: InputDecoration(
                hintText: isLoadingDropdown && widget.type == FieldType.dropdown
                    ? 'Loading...'
                    : widget.hintText,
                prefixIcon:
                    widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: widget.type == FieldType.dropdown
                    ? isLoadingDropdown
                        ? const SizedBox(
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(strokeWidth: 1),
                          )
                        : PhosphorIcon(
                            PhosphorIcons.caretDown(),
                            size: 20,
                          )
                    : (widget.suffixIcon != null)
                        ? IconButton(
                            icon: Icon(widget.suffixIcon),
                            onPressed: () {
                              if (widget.onSuffixIconPressed != null) {
                                widget.onSuffixIconPressed!();
                              }
                            },
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
