import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../utils/text_utils.dart';
import '../utils/size_utils.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isBooked = false;

  final List<Map<String, dynamic>> _reviews = [
    {"user": "Alice", "rating": 4, "comment": "Good product!"},
    {"user": "Bob", "rating": 5, "comment": "Excellent and fast delivery!"},
  ];

  void _showReviewDialog(BuildContext context) {
    int rating = 0;
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Write a Review", style: TextUtils.headingStyle(context)),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: AppColors.warning,
                    ),
                    onPressed: () => setState(() => rating = index + 1),
                  );
                }),
              ),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(labelText: "Comment"),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final comment = commentController.text.trim();
              if (rating == 0 || comment.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please provide rating and comment", style: TextUtils.errorTextStyle(context))),
                );
                return;
              }
              setState(() {
                _reviews.add({'user': 'You', 'rating': rating, 'comment': comment});
              });
              Navigator.pop(context);
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  void _showBookingSheet(BuildContext context) {
    final List<String> timeSlots = [
      '10:00 AM - 11:00 AM',
      '12:00 PM - 01:00 PM',
      '02:00 PM - 03:00 PM',
      '04:00 PM - 05:00 PM',
    ];
    String? selectedSlot;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: StatefulBuilder(
          builder: (context, setModalState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Choose a Time Slot", style: TextUtils.subheadingStyle(context)),
              SizeUtils.height10,
              ...timeSlots.map((slot) => RadioListTile<String>(
                title: Text(slot),
                value: slot,
                groupValue: selectedSlot,
                onChanged: (value) => setModalState(() => selectedSlot = value),
              )),
              SizeUtils.height10,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: selectedSlot == null
                    ? null
                    : () {
                  Navigator.pop(context);
                  setState(() => isBooked = true);

                  showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: Text("Booking Confirmed ✅", style: TextUtils.headingStyle(context)),
                      content: Text("Your appointment for:\n\n$selectedSlot\n\nhas been booked!"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
                child: Text("Confirm Booking", style: TextUtils.buttonTextStyle(context)),
              ),
              SizeUtils.height10,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product['title'], style: TextUtils.subheadingStyle(context)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        elevation: 0.5,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              // Image & Video
              SizedBox(
                height: 260,
                child: PageView(
                  children: [
                    product['imageUrl'] != null
                        ? Image.network(product['imageUrl'], fit: BoxFit.cover)
                        : Image.asset('assets/images/service_category.jpg', fit: BoxFit.cover),
                    Container(
                      color: Colors.black,
                      child: const Center(
                        child: Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['title'], style: TextUtils.headingStyle(context)),
                    SizeUtils.height10,
                    Text("₹${product['price']}", style: TextUtils.customStyle(context, size: 18, weight: FontWeight.bold, color: AppColors.success)),
                    SizeUtils.height10,
                    Row(
                      children: [
                        Text("${product['category']} > ${product['subcategory']}", style: TextUtils.smallTextStyle(context)),
                        const Spacer(),
                        Chip(
                          label: Text(
                            product['status'] == 'sold' ? 'SOLD' : 'AVAILABLE',
                            style: TextStyle(color: product['status'] == 'sold' ? AppColors.danger : AppColors.success),
                          ),
                          backgroundColor: product['status'] == 'sold' ? AppColors.danger.withOpacity(0.2) : AppColors.success.withOpacity(0.2),
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    Text("Property Highlights", style: TextUtils.subheadingStyle(context)),
                    SizeUtils.height10,
                    Text("• Verified listing\n• Great location\n• Negotiable price\n• Immediate availability", style: TextUtils.bodyStyle(context)),
                    SizeUtils.height20,
                    Text("Location", style: TextUtils.subheadingStyle(context)),
                    SizeUtils.height10,
                    Text(product['location'], style: TextUtils.bodyStyle(context)),
                    SizeUtils.height20,
                    Text("Ratings", style: TextUtils.subheadingStyle(context)),
                    SizeUtils.height10,
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.warning, size: 20),
                        SizeUtils.width10,
                        Text("${product['rating']} / 5", style: TextUtils.bodyStyle(context)),
                      ],
                    ),
                    SizeUtils.height20,
                    Text("Reviews", style: TextUtils.subheadingStyle(context)),
                    SizeUtils.height10,
                    if (isBooked)
                      ..._reviews.map((review) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(review['user'], style: TextUtils.customStyle(context, weight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: List.generate(5, (i) {
                                  return Icon(
                                    i < review['rating'] ? Icons.star : Icons.star_border,
                                    size: 18,
                                    color: AppColors.warning,
                                  );
                                }),
                              ),
                              SizeUtils.height10,
                              Text(review['comment'], style: TextUtils.bodyStyle(context)),
                            ],
                          ),
                        ),
                      )),
                    isBooked
                        ? ElevatedButton(
                      onPressed: () => _showReviewDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: Text("Write a Review", style: TextUtils.buttonTextStyle(context)),
                    )
                        : Text("You need to visit the place to submit a review.", style: TextUtils.smallTextStyle(context)),
                    SizeUtils.height20,
                    Text("Seller Contact", style: TextUtils.subheadingStyle(context)),
                    SizeUtils.height10,
                    isBooked
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("📞 +91 9876543210", style: TextUtils.bodyStyle(context)),
                        Text("📧 vendor@example.com", style: TextUtils.bodyStyle(context)),
                      ],
                    )
                        : Text("Book an appointment to unlock seller details.", style: TextUtils.smallTextStyle(context)),
                  ],
                ),
              ),
            ],
          ),

          // Sticky CTA
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SafeArea(
                top: false,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: isBooked ? null : () => _showBookingSheet(context),
                  child: Text(
                    isBooked ? "Appointment Booked" : "Book Appointment",
                    style: TextUtils.buttonTextStyle(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
