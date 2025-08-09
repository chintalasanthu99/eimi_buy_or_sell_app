import 'dart:convert';
import 'dart:io';
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:eimi_buy_or_sell_app/vendor/vendor_home/vendor_home_bloc/vendor_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'models/FieldConfig.dart';




class ProductUploadScreen extends StatefulWidget {
  const ProductUploadScreen({super.key});

  @override
  State<ProductUploadScreen> createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final VendorHomeBloc _bloc = VendorHomeBloc();
  final ScrollController _scrollController = ScrollController();

  List<FieldConfig>? fields;
  bool _isLoading = true;
  String? _error;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _values = {};

  final List<File> _mediaFiles = [];
  final picker = ImagePicker();
  final int _maxFileSizeMB = 5;
  _ProductUploadScreenState();

  @override
  void initState() {
    initPlatformState();
    _loadFieldConfigs();
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
    return BlocListener<VendorHomeBloc, BaseState>(listener: (context, state) async {
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
    }, child: BlocBuilder<VendorHomeBloc, BaseState>(
      bloc: _bloc,
      builder: (context, state) {
        return Center(
          child: buildUI(state,context),
        );
      },
    ));
  }

  Widget buildUI(state, context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        top: true,
        child: Stack(
          children: <Widget>[
            Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //APP BAR
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          HorizontalSpace(),
                          customThemeText("Post Your Property", 18,fontWeight: FontWeight.w700,color: AppColors.black),

                        ],
                      ),
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
                              if(fields!=null && fields!.isNotEmpty)
                                for (var fc in fields!) _buildField(fc),
                              const SizedBox(height: 20),
                              _buildImageUploadSection(),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //BOTTOM WIDGETS

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  //UI WIDGETS   -> We have to use custom components whatever we have in project.
  Widget _buildField(FieldConfig fc) {
    final isDropdown = fc.type == 'dropdown';
    final isChip = fc.type == 'select';
    final isCheckbox = fc.type == 'checkbox';
    final isRequired = fc.required ?? false;
    final label = isRequired ? "${fc.label}" : fc.label;

    if (isChip) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                customThemeText(label, 16, fontWeight: FontWeight.w700, color: AppColors.black),
                customThemeText(isRequired?"*":"", 16, fontWeight: FontWeight.w700, color: AppColors.danger),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (fc.options ?? []).map((option) {
                final isSelected = _values[fc.label] == option;
                return ChoiceChip(
                  label: customThemeText(option, 14, fontWeight: FontWeight.w500),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _values[fc.label!] = selected ? option : null;
                    });
                  },
                  selectedColor: AppColors.green1,
                  backgroundColor: AppColors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.vendorPrimary : AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isSelected ? AppColors.vendorPrimary : AppColors.black1,
                      width: 1,
                    ),
                  ),
                );
              }).toList(),
            )


          ],
        ),
      );
    }




    if (isDropdown) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                customThemeText(
                  label,
                  16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                customThemeText(isRequired?"*":"", 16, fontWeight: FontWeight.w700, color: AppColors.danger),
              ],
            ),
            VerticalSpace(height: 10,),

            GestureDetector(
              onTap: () async {
                final currentValue = _values[fc.label] as String?;

                final result = await showModalBottomSheet<String>(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) {
                    return ListView(
                      shrinkWrap: true,
                      children: (fc.options ?? []).map((opt) {
                        final isSelected = opt == currentValue;
                        return ListTile(
                          title: customThemeText(
                            opt,14,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? AppColors.vendorPrimary : AppColors.black,

                          ),
                          trailing: isSelected
                              ? Icon(Icons.check, color: AppColors.vendorPrimary)
                              : null,
                          onTap: () => Navigator.pop(context, opt),
                        );
                      }).toList(),
                    );
                  },
                );

                if (result != null) {
                  setState(() {
                    _values[fc.label!] = result;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _values[fc.label] != null
                        ? AppColors.vendorPrimary
                        : AppColors.black2,
                    width: 0.8,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _values[fc.label] as String? ?? "Select $label",
                      style: TextStyle(
                        fontSize: 14,
                        color: _values[fc.label] != null
                            ? AppColors.black
                            : Colors.grey,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, size: 20),
                  ],
                ),
              ),
            ),

            // Error text for required
            if (isRequired && (_values[fc.label] == null))
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  'Required',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
      );
    }


    if (isCheckbox) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: _values[fc.label] ?? false,
              activeColor: AppColors.vendorPrimary,
              visualDensity: VisualDensity.compact, // smaller size
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // no min height
              onChanged: (value) {
                setState(() {
                  _values[fc.label!] = value;
                });
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: customThemeText(
                label,
                16,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      );
    }




    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8), // smaller vertical gap
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              customThemeText(
                label,
                16,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
              customThemeText(isRequired?"*":"", 16, fontWeight: FontWeight.w700, color: AppColors.danger),
            ],
          ),
          const SizedBox(height: 8), // smaller spacing before input
          TextFormField(
            cursorColor: AppColors.vendorPrimary,
            decoration: InputDecoration(
              isDense: true, // compact height
              labelText: "",
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10, // reduced from 16 → tighter box
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 0.5, color: AppColors.black2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 0.5, color: AppColors.black2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 1, color: AppColors.vendorPrimary),
              ),
              // errorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: BorderSide(width: 0.8, color: Colors.red),
              // ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 1.2, color: AppColors.vendorPrimary),
              ),
            ),
            maxLines: fc.type == 'textarea' ? 10 : 1,
            keyboardType:
            fc.type == 'number' ? TextInputType.number : TextInputType.text,
            onSaved: (v) => _values[fc.label!] = v,
            validator: isRequired
                ? (v) => (v ?? '').isEmpty ? 'Required' : null
                : null,
          ),
        ],
      ),
    );

  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Upload up to 3 Images", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(3, (index) {
            final file = _imageFiles[index];
            return GestureDetector(
              onTap: () => _pickImage(index),
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade100,
                      image: file != null
                          ? DecorationImage(image: FileImage(file), fit: BoxFit.cover)
                          : null,
                    ),
                    child: file == null
                        ? const Icon(Icons.add_photo_alternate, size: 40, color: Colors.grey)
                        : null,
                  ),
                  if (file != null)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(Icons.close, size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }


  Future<ImageSource?> _showImageSourceSheet(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      isScrollControlled: true, // allow custom height
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              // grab handle
              Container(
                height: 4,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 18),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _PickerTile(
                      icon: Icons.photo_camera_outlined,
                      label: 'Camera',
                      onTap: () => Navigator.pop(sheetContext, ImageSource.camera),
                    ),
                    _PickerTile(
                      icon: Icons.photo_library_outlined,
                      label: 'Gallery',
                      onTap: () => Navigator.pop(sheetContext, ImageSource.gallery),
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }




  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final uploadedImages = _imageFiles.where((f) => f != null).toList();

      if (uploadedImages.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please upload at least one image"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      _values['images'] = uploadedImages.map((f) => f!.path).toList();

      debugPrint("Form Values: $_values");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product submitted successfully"), backgroundColor: Colors.green),
      );
    }
  }

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

  Future<void> _loadFieldConfigs() async {
    try {
      print("eoorooo");
      final jsonStr = await DefaultAssetBundle.of(context)
          .loadString("assets/jsons/field_config.json");
      print("eoorooo-1");

      final List<dynamic> jsonList = json.decode(jsonStr);
      print("eoorooo-2");
      final allFields = jsonList.map((j) => FieldConfig.fromJson(j)).toList();
      print("eoorooo-3");

      final filteredFields = allFields.where((f) {
        return f.category?["name"]?.toLowerCase() == "Properties".toLowerCase() &&
            f.subCategory?["name"]?.toLowerCase() ==  "Lands & Plots".toLowerCase();
      }).toList();


      setState(() {
        fields = filteredFields;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Failed to load form fields.";
        _isLoading = false;
      });
    }
  }


  final List<File?> _imageFiles = [null, null, null];


  // Call this from your tile tap
  Future<void> _pickImage(int slotIndex) async {
    final source = await _showImageSourceSheet(context);
    if (source == null) return;

    final picker = ImagePicker();
    final XFile? xfile = await picker.pickImage(
      source: source,
      imageQuality: 85, // smaller size, decent quality
      maxWidth: 1920,
    );
    if (xfile == null) return;

    setState(() {
      _imageFiles[slotIndex] = File(xfile.path);
    });
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles[index] = null;
    });
  }

  //API CALLS
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }


}

class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickerTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: 140, // bigger hit area
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 1,
              color: Colors.black12,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // icon bubble
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Icon(icon, size: 36, color: AppColors.black),
              ),
               VerticalSpace(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16, // larger title
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

