import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductFilterWidget extends StatefulWidget {
  final Map<String, List<String>> categoryMap;
  final String? initialCategory;
  final String? initialSubcategory;
  final void Function(String? category, String? subcategory) onFilterChanged;

  const ProductFilterWidget({
    super.key,
    required this.categoryMap,
    this.initialCategory,
    this.initialSubcategory,
    required this.onFilterChanged,
  });

  @override
  State<ProductFilterWidget> createState() => _ProductFilterWidgetState();
}

class _ProductFilterWidgetState extends State<ProductFilterWidget> {
  String? selectedCategory;
  String? selectedSubcategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
    selectedSubcategory = widget.initialSubcategory;
  }

  void _updateFilters({String? category, String? subcategory}) {
    setState(() {
      selectedCategory = category ?? selectedCategory;
      selectedSubcategory = subcategory ?? selectedSubcategory;
    });

    widget.onFilterChanged(selectedCategory, selectedSubcategory);
  }

  void _showCategoryDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: widget.categoryMap.keys.map((cat) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(cat),
                onTap: () {
                  Navigator.pop(context);
                  _updateFilters(category: cat, subcategory: null);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _showSubcategoryDialog() {
    final subcategories = widget.categoryMap[selectedCategory] ?? [];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: subcategories.map((sub) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(sub),
                onTap: () {
                  Navigator.pop(context);
                  _updateFilters(subcategory: sub);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Filter Products", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _showCategoryDialog,
                  child: _buildFilterTile(
                    icon: Icons.category,
                    text: selectedCategory ?? "Category",
                    enabled: true,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: selectedCategory != null ? _showSubcategoryDialog : null,
                  child: _buildFilterTile(
                    icon: Icons.filter_alt_outlined,
                    text: selectedSubcategory ?? "Subcategory",
                    enabled: selectedCategory != null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTile({required IconData icon, required String text, required bool enabled}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: enabled ? Colors.white : Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: enabled ? Colors.black : Colors.grey,
              ),
            ),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
