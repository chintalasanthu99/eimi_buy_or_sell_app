import 'package:flutter/material.dart';

// Local static product list
final List<Map<String, dynamic>> allProducts = List.generate(15, (index) {
  return {
    "title": "Product ${index + 1}",
    "category": index % 2 == 0 ? "Plots" : "Electronics",
    "subcategory": "Subcat ${index + 1}",
    "price": 50000 + index * 1000,
    "likes": 10 + index,
    "wishCount": 5 + index,
    "rating": 4 + (index % 2),
    "status": index % 3 == 0 ? "sold" : "available",
    "imageUrl": index % 4 == 0 ? null : "https://picsum.photos/200?random=$index",
    "location": index % 2 == 0 ? "Hyderabad" : "Bangalore"
  };
});

// Local static user reviews
final List<Map<String, dynamic>> userReviews = [
  {
    "product": allProducts[0]["title"],
    "rating": 4,
    "comment": "Nice plot, good location and accessible."
  },
  {
    "product": allProducts[2]["title"],
    "rating": 5,
    "comment": "Amazing deal, seller was helpful!"
  },
  {
    "product": allProducts[5]["title"],
    "rating": 3,
    "comment": "Okay experience. Needs better maintenance."
  },
];

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Reviews")),
      body: userReviews.isEmpty
          ? const Center(child: Text("You haven’t posted any reviews yet."))
          : ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: userReviews.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final review = userReviews[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review['product'] ?? "Product",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (i) {
                      return Icon(
                        i < review['rating']
                            ? Icons.star
                            : Icons.star_border,
                        size: 18,
                        color: Colors.orange,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    review['comment'] ?? "",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
