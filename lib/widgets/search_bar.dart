import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onSubmitted;
  final String hintText;

  const SearchBar({
    Key? key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hintText = '搜索姿势...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
        onChanged: onChanged,
        onSubmitted: (value) {
          onSubmitted?.call();
        },
      ),
    );
  }
}