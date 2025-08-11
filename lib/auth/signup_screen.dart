
import 'package:eimi_buy_or_sell_app/user_main_home_screen.dart';
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_bloc.dart';
import 'package:eimi_buy_or_sell_app/utils/base_bloc/base_state.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:eimi_buy_or_sell_app/vendor_main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;


enum Gender { male, female, other }

class SignUpScreen extends StatefulWidget {
  final String? role;
  const SignUpScreen({super.key,this.role});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final BaseBloc _bloc = BaseBloc();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  Gender _selectedGender = Gender.male;
  DateTime? _dob;
  bool _loading = false;
  Position? _lastPickedPosition;
  _SignUpScreenState();

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
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 10,right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back)),
                        InkWell(
                          onTap: (){
                            if( widget.role == "buyer"){
                              _navigateToHome();
                            }else if(widget.role == "seller"){
                              _navigateToVendorHome();
                            }
                          },
                          child: customThemeText(
                              "Skip",16,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.right

                          ),
                        )

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
                                  VerticalSpace(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(width: 0.5,color: AppColors.black)
                                        ),
                                        height: deviceHeight(context)*0.056,
                                        padding: EdgeInsets.only(left: 10,top: 10,right: 10),
                                        child: customThemeText("+91", 14,textAlign: TextAlign.center,fontWeight: FontWeight.w700),
                                      ),
                                      HorizontalSpace(),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _mobileController,
                                          style: TextStyle(color: AppColors.black),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                                            hintText: "Enter your mobile number",
                                            hintStyle: TextStyle(color: AppColors.grey9,fontSize: 16),
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: AppColors.black2),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: AppColors.primary, width: 1),
                                            ),
                                          ),
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalSpace(height: 20,),
                                  TextField(
                                    obscureText: true,
                                    controller: _passwordController,
                                    style: TextStyle(color: AppColors.black),

                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 6),
                                      hintText: "Enter your password",
                                      hintStyle: TextStyle(color: AppColors.grey9,fontSize: 16),
                                      suffixIcon: Icon(Icons.visibility, color: AppColors.primary),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.black2,width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.primary, width: 0.5),
                                      ),
                                    ),
                                  ),
                                  VerticalSpace(height: 20,),
                                  TextField(
                                    obscureText: true,
                                    controller: _confirmPasswordController,
                                    style: TextStyle(color: AppColors.black),

                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 6),
                                      hintText: "Confrim your password",
                                      hintStyle: TextStyle(color: AppColors.grey9,fontSize: 16),
                                      suffixIcon: Icon(Icons.visibility, color: AppColors.primary),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.black2,width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.primary, width: 0.5),
                                      ),
                                    ),
                                  ),
                                  VerticalSpace(height: 20,),
                                  TextField(
                                    controller: _nameController,
                                    style: TextStyle(color: AppColors.black),

                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 6),
                                      hintText: "Enter your name",
                                      hintStyle: TextStyle(color: AppColors.grey9,fontSize: 16),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.black2,width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.primary, width: 0.5),
                                      ),
                                    ),
                                  ),

                                  VerticalSpace(height: 20,),
                                  TextField(
                                    controller: _emailController,
                                    style: TextStyle(color: AppColors.black),

                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 6),
                                      hintText: "Enter your email",
                                      hintStyle: TextStyle(color: AppColors.grey9,fontSize: 16),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.black2,width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.primary, width: 0.5),
                                      ),
                                    ),
                                  ),
                                  VerticalSpace(height: 20,),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 8,
                                    children: [
                                      chip(Gender.male, "Male", Icons.male),
                                      chip(Gender.female, "Female", Icons.female),
                                      chip(Gender.other, "Other", Icons.transgender),
                                    ],
                                  ),
                                  VerticalSpace(height: 20,),
                                  TextField(
                                    controller: _dateOfBirthController,
                                    style: TextStyle(color: AppColors.black),
                                    onTap: _pickDob,

                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 6),
                                      hintText: "Select your date of birth",
                                      hintStyle: TextStyle(color: AppColors.grey9,fontSize: 16),
                                      suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.black2,width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.primary, width: 0.5),
                                      ),
                                    ),
                                  ),

                                  VerticalSpace(height: 20,),
                                  TextFormField(
                                    controller: _locationController,
                                    readOnly: true,
                                    onTap: _fillCurrentLocation, // tap anywhere to fetch location
                                    style: TextStyle(color: AppColors.black),
                                    decoration: InputDecoration(
                                      hintText: "Use current location",
                                      hintStyle: TextStyle(color: AppColors.grey9, fontSize: 16),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.black2, width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: AppColors.primary, width: 0.5),
                                      ),
                                      suffixIcon: _loading
                                          ? const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: SizedBox(
                                          width: 18, height: 18,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        ),
                                      )
                                          : IconButton(
                                        icon: const Icon(Icons.my_location),
                                        color: AppColors.primary,
                                        onPressed: _fillCurrentLocation,
                                      ),
                                    ),
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
            "Sign Up",16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            textAlign: TextAlign.center
        )
    ).onTap((){
      if( widget.role == "buyer"){
        _navigateToHome();
      }else if(widget.role == "seller"){
        _navigateToVendorHome();
      }
    });
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


  Future<void> _pickDob() async {
    final now = DateTime.now();
    final initial = DateTime(now.year - 18, now.month, now.day); // default: 18yo
    final first = DateTime(1900);
    final last = now;

    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? initial,
      firstDate: first,
      lastDate: last,
      helpText: 'Select Date of Birth',
    );
    if (picked != null) {
      setState(() {
        _dob = picked;
        _dateOfBirthController.text = "${picked.year}-${picked.month.toString().padLeft(2,'0')}-${picked.day.toString().padLeft(2,'0')}";
      });
    }
  }
  Widget chip(Gender g, String label, IconData icon) {
    final selected = _selectedGender == g;
    return ChoiceChip(
      showCheckmark:false,
      label: customThemeText(label,14,fontWeight: FontWeight.w500,color: selected?AppColors.white:AppColors.black),
      selected: selected,
      onSelected:(v){
        setState(() {
          _selectedGender = g;
        });
      },
      selectedColor:AppColors.primary ,
      disabledColor:AppColors.white ,
        backgroundColor:AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
  Future<bool> _ensurePermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      _showSnackBar("Please enable location services.");
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _showSnackBar("Location permission is required.");
      return false;
    }
    return true;
  }

  Future<void> _fillCurrentLocation() async {
    if (_loading) return;
    setState(() => _loading = true);

    try {
      if (!await _ensurePermission()) {
        if (mounted) setState(() => _loading = false);
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      // Reverse-geocode (fallback to lat,lng)
      String text;
      try {
        final list = await geocoding.placemarkFromCoordinates(
          pos.latitude, pos.longitude,
        );
        final p = list.first;
        text = [
          p.name,
          p.subLocality,
          p.locality,
          p.administrativeArea,
          p.country
        ].where((e) => (e ?? '').toString().trim().isNotEmpty).join(', ');
        if (text.trim().isEmpty) {
          text = "${pos.latitude.toStringAsFixed(6)}, ${pos.longitude.toStringAsFixed(6)}";
        }
      } catch (_) {
        text = "${pos.latitude.toStringAsFixed(6)}, ${pos.longitude.toStringAsFixed(6)}";
      }

      if (!mounted) return;
      _lastPickedPosition = pos;          // keep if you need raw coords
      _locationController.text = text;    // fill the field
    } catch (e) {
      _showSnackBar("Could not get location.");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }


  void _navigateToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainHomeScreen()));
  }
  void _navigateToVendorHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const VendorMainHomeScreen()));

  }


  //API CALLS
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }




}





