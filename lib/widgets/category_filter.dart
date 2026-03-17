import 'package:flutter/material.dart';
import '../models/pose_category.dart';

class CategoryFilter extends StatelessWidget {
  final List<PoseCategory> categories;
  final String? selectedCategoryId;
  final Function(String?) onCategorySelected;

  const CategoryFilter({
    Key? key,
    required this.categories,
    this.selectedCategoryId,
    required this.onCategorySelected,
  }) : super(key: key);

  Widget _buildCategoryChip(PoseCategory category, bool isSelected) {
    return GestureDetector(
      onTap: () => onCategorySelected(isSelected ? null : category.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? null : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.9)
                : Colors.white.withOpacity(0.6),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Text(
          '${category.icon}  ${category.name}',
          style: TextStyle(
            color: isSelected ? const Color(0xFF6C63FF) : const Color(0xFF555555),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          for (int i = 0; i < categories.length; i++) ...[
            if (i > 0) const SizedBox(width: 12),
            _buildCategoryChip(
              categories[i],
              selectedCategoryId == categories[i].id,
            ),
          ],
        ],
      ),
    );
  }
}
