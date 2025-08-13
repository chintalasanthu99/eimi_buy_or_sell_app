import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_bloc.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/common_screens/custom_container.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/text_utils.dart';
import '../utils/size_utils.dart';





class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? product;
  const ProductDetailScreen({super.key,this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final BaseBloc _bloc = BaseBloc();
  final ScrollController _scrollController = ScrollController();

  bool isBooked = false;

  final List<Map<String, dynamic>> _reviews = [
    {"user": "Alice", "rating": 4, "comment": "Good product!"},
    {"user": "Bob", "rating": 5, "comment": "Excellent and fast delivery!"},
  ];
  _ProductDetailScreenState();

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (_) => _bloc,
        child: buildPage(),
      ),
    );
  }


  Widget buildPage() {
    return BlocListener<BaseBloc, BaseState>(listener: (context, state) async {
      if (state is BaseError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: Duration(milliseconds: 2000),
              content: customThemeText(state.errorMessage,14,fontWeight: FontWeight.w600,color: Colors.white),
              backgroundColor: AppColors.primary),
        );
      } else if (state is DataLoaded) {
        //ADD YOUR FUNCTIONALITY
      }
    }, child: BlocBuilder<BaseBloc, BaseState>(
      bloc: _bloc,
      builder: (context, state) {
        return Center(
          child: CustomContainer(
              buildUI(state, context), state, onRefresh, statusBarColor: AppColors.transparent),
        );
      },
    ));
  }

  Widget buildUI(state, context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //APP BAR
                  Container(
                    height: deviceHeight(context)*0.36,
                    child: PageView(
                      children: [
                        widget.product!['imageUrl'] != null
                            ? Image.network(widget.product!['imageUrl'], fit: BoxFit.cover)
                            : Image.asset('assets/images/product_image.png', fit: BoxFit.cover),
                        Container(
                          color: Colors.black,
                          child: const Center(
                            child: Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //BODY
                  Expanded(
                    child: Container(
                      color: AppColors.white,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          margin:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              VerticalSpace(height: 10,),
                              Column(
                                children:  [
                                  //BODY WIDGETS

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      VerticalSpace(height: 10,),
                                      customThemeText(widget.product!['title'], 16,fontWeight:FontWeight.w700,color: AppColors.black),
                                      VerticalSpace(height: 10,),
                                      customThemeText("₹${widget.product!['price']}",14,fontWeight: FontWeight.w500),
                                      SizeUtils.height10,
                                      horizontalLine(context,color: AppColors.grey10),
                                      SizeUtils.height10,
                                      customThemeText("Property Details", 16,fontWeight: FontWeight.w700),
                                      SizeUtils.height10,
                                      customThemeText("• Verified listing\n• Great location\n• Negotiable price\n• Immediate availability", 14),
                                      SizeUtils.height10,
                                      horizontalLine(context,color: AppColors.grey10),
                                      SizeUtils.height10,
                                      customThemeText("About Property",16,fontWeight: FontWeight.w600),
                                      SizeUtils.height10,
                                      customThemeText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in volupt...Read more", 14),
                                      SizeUtils.height10,
                                      horizontalLine(context,color: AppColors.grey10),
                                      SizeUtils.height10,
                                      customThemeText("Reviews", 16,fontWeight: FontWeight.w600),
                                      SizeUtils.height10,
                                      if (isBooked)
                                        ..._reviews.map((review) => Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: customThemeText(review['user'], 14),
                                            subtitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Row(
                                                //   children: List.generate(5, (i) {
                                                //     return Icon(
                                                //       i < review['rating'] ? Icons.star : Icons.star_border,
                                                //       size: 18,
                                                //       color: AppColors.warning,
                                                //     );
                                                //   }),
                                                // ),
                                                // SizeUtils.height10,
                                                customThemeText(review['comment'],14),
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
                                        child: customThemeText("Write a Review", 14),
                                      )
                                          : customThemeText("You need to visit the place to submit a review.", 14),
                                      SizeUtils.height10,
                                      horizontalLine(context,color: AppColors.grey10),
                                      SizeUtils.height10,
                                      customThemeText("Seller Contact", 16,fontWeight: FontWeight.w600),
                                      SizeUtils.height10,
                                      isBooked
                                          ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          customThemeText("📞 +91 9876543210", 14),
                                          customThemeText("📧 vendor@example.com", 14),
                                        ],
                                      )
                                          : customThemeText("Book an appointment to unlock seller details.", 14),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //BOTTOM WIDGETS
                  buttonWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  //UI WIDGETS   -> We have to use custom components whatever we have in project.

  Widget buttonWidget(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        width: double.infinity,
        // height: 50,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16)),
        child: customThemeText(
            "Book Visit",16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            textAlign: TextAlign.center
        )
    ).onTap((){
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (_) =>  ProductUploadSuccessScreen()),
      // );
    });
  }

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


  //FUNCTIONALITY
  void _showToastBar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 6,
        backgroundColor : AppColors.primary,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: customThemeText(
            message,
            14,
            textAlign: TextAlign.center,fontWeight: FontWeight.w600,color: Colors.white
        ),
        backgroundColor: AppColors.primary,
        // behavior: SnackBarBehavior.floating,
        // elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
    );
  }



  Future<void> onRefresh()async {
    bool data = false;
    // WRITE YOUR REFRESH LOGIC
  }

  //API CALLS
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }


}

