import 'package:eimi_buy_or_sell_app/user/book_visit_screen.dart';
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
  final PageController _pageController = PageController();
  final List<Map<String, dynamic>> _reviews = [
    {"user": "Alice", "rating": 4, "comment": "Good product!"},
    {"user": "Bob", "rating": 5, "comment": "Excellent and fast delivery!"},
  ];


  int _pageIndex = 0;
  bool _liked = false;

// Build the list you want to show in the header pager
  List<String> get _mediaUrls {
    // Case 1: images is a List (preferred)
    final list = (widget.product?['images'] as List?)
        ?.map((e) => e?.toString() ?? '')
        .where((s) => s.trim().isNotEmpty)
        .toList() ??
        const <String>[];
    if (list.isNotEmpty) return list;


    return const <String>[];
  }

  int get _pageCount => _mediaUrls.isEmpty ? 1 : _mediaUrls.length;


  void _next() {
    if (_pageIndex < _pageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  void _prev() {
    if (_pageIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }
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

  Widget buildUI(state, BuildContext context) {
    final total = _pageCount;
    final current = (_pageIndex + 1).clamp(1, total);

    return Container(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            // CONTENT
            Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // APP BAR / MEDIA


                  // BODY
                  Expanded(
                    child: Container(
                      color: AppColors.white,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _headerMedia(
                              context: context,
                              height: deviceHeight(context) * 0.36,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _titlePriceSection(widget.product),
                                  SizeUtils.height10,
                                  horizontalLine(context, color: AppColors.grey10),
                                  SizeUtils.height10,
                                  _detailsSection(widget.product),
                                  SizeUtils.height10,
                                  horizontalLine(context, color: AppColors.grey10),
                                  SizeUtils.height10,
                                  _aboutSection(widget.product),
                                  SizeUtils.height10,
                                  horizontalLine(context, color: AppColors.grey10),
                                  SizeUtils.height10,
                                  _reviewsSection(
                                    isBooked: isBooked,
                                    reviews: _reviews,
                                    onWrite: () => _showReviewDialog(context),
                                  ),
                                  SizeUtils.height10,
                                  horizontalLine(context, color: AppColors.grey10),
                                  SizeUtils.height10,
                                  _sellerContactSection(isBooked),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                  // BOTTOM WIDGETS
                  buttonWidget(),
                ],
              ),
            ),

            // Optional bottom-center counter chip (align to header bottom)
          ],
        ),
      ),
    );
  }

// ---------- small widget functions (no classes) ----------

  Widget _headerMedia({required BuildContext context, required double height}) {
    final total = _pageCount;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          // Pager
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _pageIndex = i),
              itemCount: total,
              itemBuilder: (_, i) {
                final hasMedia = _mediaUrls.isNotEmpty;
                final url = hasMedia ? _mediaUrls[i] : null;
                final isVideo = (url ?? '').toLowerCase().endsWith('.mp4');

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    if (hasMedia && url!.isNotEmpty && !isVideo)
                      Image.network(url, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Image.asset('assets/images/product_image.png', fit: BoxFit.cover),
                      )
                    else if (hasMedia && isVideo)
                    // your video thumb + play overlay
                      Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset('assets/images/product_image.png', fit: BoxFit.cover),
                          const Center(child: Icon(Icons.play_circle_fill, size: 72, color: Colors.white)),
                        ],
                      )
                    else
                      Image.asset('assets/images/product_image.png', fit: BoxFit.cover),

                    // readability gradient
                    const Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [Color(0x66000000), Color(0x00000000)],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Top row: Back · Share · Like
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    _circleIcon(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    _circleIcon(
                      icon: Icons.ios_share_rounded,
                      onTap: () {

                      },
                    ),
                    const SizedBox(width: 8),
                    _circleIcon(
                      icon: _liked ? Icons.favorite : Icons.favorite_border,
                      onTap: () => setState(() => _liked = !_liked),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Dot indicators (centered near bottom)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: _pageIndicators(index: _pageIndex, total: total),
          ),

        ],
      ),
    );
  }

  Widget _pageIndicators({required int index, required int total}) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.40),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(total, (i) {
            final active = i == index;
            return GestureDetector(
              onTap: () => _pageController.animateToPage(
                  i, duration: const Duration(milliseconds: 250), curve: Curves.easeOut),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 6,
                width: active ? 16 : 6,
                decoration: BoxDecoration(
                  color: active ? Colors.white : Colors.white70,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

// full-screen image viewer (no extra packages)
  void _openImageViewer({required int startIndex}) {
    final total = _pageCount;
    if (total == 0) return;

    final ctrl = PageController(initialPage: startIndex);
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      barrierDismissible: true,
      pageBuilder: (_, __, ___) {
        return Stack(
          children: [
            PageView.builder(
              controller: ctrl,
              itemCount: total,
              itemBuilder: (_, i) {
                final url = _mediaUrls[i];
                return InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4,
                  child: Image.network(
                    url,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        Image.asset('assets/images/product_image.png', fit: BoxFit.contain),
                  ),
                );
              },
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

// stub for video (hook to a player route/package)
  void _playVideo(String url) {
    // TODO: push to a video player page (e.g., chewie/video_player)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Play video not implemented')),
    );
  }



  Widget _titlePriceSection(Map<String, dynamic>? product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         VerticalSpace(height: 10),
        customThemeText(product?['title'] ?? '—', 16,
            fontWeight: FontWeight.w700, color: AppColors.black),
         VerticalSpace(height: 10),
        customThemeText("₹${product?['price'] ?? '--'}", 14,
            fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget _detailsSection(Map<String, dynamic>? product) {
    final Map<String, dynamic> attrs =
        (product?['attributes'] as Map?)?.cast<String, dynamic>() ?? const {};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customThemeText("Details", 16, fontWeight: FontWeight.w700),
        SizeUtils.height10,
        if (attrs.isEmpty)
          customThemeText("—", 14)
        else
          _kvList(attrs),
      ],
    );
  }

// small widget function: key–value list
  Widget _kvList(Map<String, dynamic> attrs) {
    // sort keys for stable UI (optional)
    final entries = attrs.entries.toList()
      ..sort((a, b) => a.key.toLowerCase().compareTo(b.key.toLowerCase()));

    return Column(
      children: entries.map((e) {
        final key = e.key;
        final value = _attrValueToString(e.value);

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // key
              Expanded(
                flex: 4,
                child: customThemeText(
                  key,
                  14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black, // tweak if you have a subtle color
                ),
              ),
              const SizedBox(width: 8),
              // value
              Expanded(
                flex: 6,
                child: customThemeText(value, 14),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

// helper: stringify any dynamic value nicely (List/Map supported)
  String _attrValueToString(dynamic v) {
    if (v == null) return "—";
    if (v is num || v is bool) return v.toString();
    if (v is List) {
      return v.map((e) => e?.toString() ?? "").where((s) => s.isNotEmpty).join(", ");
    }
    if (v is Map) {
      // flatten simple map: key1=value1, key2=value2
      return v.entries
          .map((e) => "${e.key}=${e.value}")
          .join(", ");
    }
    return v.toString();
  }


  Widget _aboutSection(Map<String, dynamic>? product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customThemeText("About", 16, fontWeight: FontWeight.w600),
        SizeUtils.height10,
        customThemeText(
          product?['title'] ?? '—',
          14,
        ),
      ],
    );
  }

  Widget _reviewsSection({
    required bool isBooked,
    required List<Map<String, dynamic>> reviews,
    required VoidCallback onWrite,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customThemeText("Reviews", 16, fontWeight: FontWeight.w600),
        SizeUtils.height10,
        if (isBooked)
          ...reviews.map(
                (review) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: customThemeText(review['user'] ?? '', 14),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customThemeText(review['comment'] ?? '', 14),
                  ],
                ),
              ),
            ),
          ),
        isBooked
            ? ElevatedButton(
          onPressed: onWrite,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          child: customThemeText("Write a Review", 14),
        )
            : customThemeText(
            "You need to visit the place to submit a review.", 14),
      ],
    );
  }

  Widget _sellerContactSection(bool isBooked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customThemeText("Seller Contact", 16, fontWeight: FontWeight.w600),
        SizeUtils.height10,
        isBooked
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customThemeText("📞 +91 9876543210", 14),
            customThemeText("📧 vendor@example.com", 14),
          ],
        )
            : customThemeText(
            "Book an appointment to unlock seller details.", 14),
      ],
    );
  }



  //UI WIDGETS   -> We have to use custom components whatever we have in project.


  Widget _circleIcon({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.white.withOpacity(0.9),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Colors.black87),
        ),
      ),
    );
  }

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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) =>  BookVisitPage()),
      );
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

