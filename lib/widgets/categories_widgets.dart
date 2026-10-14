import 'package:flutter/material.dart';

class CategoryItem {
  final String title;
  final IconData icon;

  const CategoryItem({required this.title, required this.icon});
}

class CategoriesWidgets extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String>? onSelectCategory;

  const CategoriesWidgets({
    super.key,
    this.selectedCategory = 'Semua',
    this.onSelectCategory,
  });

  static const Color primaryColor = Color(0xFF2563EB); // Royal Blue
  static const Color textSecondaryColor = Color(0xFF64748B); // Slate 500
  static const Color borderColor = Color(0xFFE2E8F0); // Subtle Border

  static const List<CategoryItem> _categoryList = [
    CategoryItem(title: 'Semua', icon: Icons.grid_view_rounded),
    CategoryItem(title: 'Smartphone', icon: Icons.smartphone_rounded),
    CategoryItem(title: 'Laptop', icon: Icons.laptop_mac_rounded),
    CategoryItem(title: 'Audio', icon: Icons.headphones_rounded),
    CategoryItem(title: 'Aksesoris', icon: Icons.devices_other_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: _categoryList.map((category) {
          final isSelected = selectedCategory == category.title;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (onSelectCategory != null) {
                    onSelectCategory!(category.title);
                  }
                },
                borderRadius: BorderRadius.circular(24),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isSelected ? primaryColor : borderColor,
                      width: 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        category.icon,
                        size: 16,
                        color: isSelected ? Colors.white : textSecondaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        category.title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected ? Colors.white : textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
