import 'dart:developer';
import 'dart:io';
import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/core/styles/text_styles.dart';
import 'package:car_club/core/widgets/custom_button.dart';
import 'package:car_club/core/widgets/custom_text_field.dart';
import 'package:car_club/features/admin/presentation/manager/admin_cubit/admin_cubit.dart';
import 'package:car_club/features/admin/presentation/views/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddCarsView extends StatefulWidget {
  const AddCarsView({super.key});
  static String id = 'AddCarsView';

  @override
  State<AddCarsView> createState() => _AddCarsViewState();
}

class _AddCarsViewState extends State<AddCarsView> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController brandController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  String? image, category;

  bool loaded = false;
  GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? uploadedImage = await BlocProvider.of<AdminCubit>(
        context,
      ).uploadImage(image: pickedFile);

      setState(() {
        _image = File(pickedFile.path);
        image = uploadedImage;
        loaded = true;
      });
    }
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
        brandController.dispose();

    colorController.dispose();

    super.dispose();
  }

  String? imageUrl;
  bool isUploading = false;
  @override
  Widget build(BuildContext context) {
    //  final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        
        title: Text(
          'Add Product',
          style: AppStyles.style32(context, Colors.black),
        ),
        elevation: 0,
     backgroundColor: Colors.pink[300],
      ),
      body: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminSuccess) {
            //     showSnackbar(context, s.add_new_product_done);
            clearFieldsMethod();
          } else if (state is AdminFailure) {
            //    showSnackbar(context, s.please_fill_all_fields);
          }
        },
        child: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.blueAccent,
          onRefresh: () async {
            // Replace this delay with the code to be executed during refresh
            // and return asynchronous code
            return Future<void>.delayed(const Duration(seconds: 3));
          },
          child: SingleChildScrollView(
            child: Form(
              key: fromKey,
              child: SafeArea(
                child: Column(
                  children: [
                    CustomTextFrom(
                      label: 'car Code',
                      hint: ' Enter Car Code',
                      controller: codeController,
                    ),
                    CustomTextFrom(
                      label: 'Car Name',
                      hint: ' Enter Car Name',
                      controller: nameController,
                    ),
                    CustomTextFrom(
                      label: 'Car Description',
                      hint: 'Enter Car Description',
                      controller: descriptionController,
                    ),
                    CustomTextFrom(
                      label: ' Car Price',
                      hint: 'Enter Car Price',
                      controller: priceController,
                    ),
                        CustomTextFrom(
                      label: ' Car Brand',
                      hint: 'Enter Car Brand',
                      controller: brandController,
                    ),
                        CustomTextFrom(
                      label: ' Car color',
                      hint: 'Enter Car color',
                      controller: colorController,
                    ),
                    const SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CustomDropDown(
                        //   menuList: categories,
                        //   onChanged: (selectedValue) {
                        //     categoryController.text = selectedValue!;
                        //   },
                        // ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Color.fromARGB(255, 110, 161, 228),
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                            child:
                                _image == null
                                    ? Icon(
                                      Icons.upload,
                                      size: 40,
                                      color: const Color.fromARGB(
                                        255,
                                        255,
                                        255,
                                        255,
                                      ),
                                    )
                                    : null,
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: Icon(Icons.image),
                          label: Text("Upload Image"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // IconButton(
                    //   onPressed: () async {
                    //     for (var pp in carModels) {
                    //         await BlocProvider.of<AdminCubit>(context)
                    //                 .addProduct(carModel: pp);

                    //     }
                    //     log('doonnne');
                    //   },
                    //   icon: Icon(
                    //     Icons.import_contacts,
                    //     size: 50,
                    //   ),
                    // ),
                    loaded
                        ? CustomButton(
                          title: 'Send',
                          color: Colors.blueAccent,
                          onTap: () async {
                            if (fromKey.currentState!.validate()) {
                              final price = int.tryParse(priceController.text);
                              await BlocProvider.of<AdminCubit>(
                                context,
                              ).addProduct(
                                carModel: CarModel(
                                  code: codeController.text,
                                  name: nameController.text,
                                  description: descriptionController.text,
                                  image: image!,
                                  price: price!,
                                  color: colorController.text,
                                  brand: brandController.text,
                                ),
                              );
                              log('send data Done');
                              loaded = false;
                              setState(() {});
                            }
                          },
                        )
                        : Text('Please  Upload the image'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearFieldsMethod() {
    codeController.clear();
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
  }

  // Future<void> addProductMethod() async {
  //   await FireBaseServices().addProduct(CarModel(
  //     code: codeController.text,
  //     parcode: codeController.text,
  //     title: titleController.text,
  //     price: priceController.text,
  //     description: descriptionController.text,
  //     category: categoryController.text,
  //     image: image!,
  //     size: sizeController.text,
  //     count: int.tryParse(countController.text) ?? 0,
  //     gender: genderController.text,
  //     cart: false,
  //     discount: double.tryParse(discountController.text) ?? 0,
  //   ));
  // }
}


List<CarModel> carModels = [
  CarModel(
    code: "10446", // Generation id for Cybercab concept
    brand: "Tesla",
    name: "Cybercab concept",
    color: "Unknown",
    description: "Electric vehicle by Tesla",
    price: 92000, // Randomly chosen within $30,000–$100,000
    image: "https://api.auto-data.net/images/f44/Tesla-Cybercab-concept_2.jpg",
  ),
  CarModel(
    code: "8588", // Generation id for Cybertruck
    brand: "Tesla",
    name: "Cybertruck",
    color: "Unknown",
    description: "Electric vehicle by Tesla",
    price: 78000, // Randomly chosen within $30,000–$100,000
    image: "https://api.auto-data.net/images/f130/Tesla-Cybertruck.jpg",
  ),
  CarModel(
    code: "10334", // Generation id for Enyaq Coupe (facelift 2025)
    brand: "Skoda",
    name: "Enyaq Coupe (facelift 2025)",
    color: "Unknown",
    description: "Electric vehicle by Skoda",
    price: 56000, // Randomly chosen within $30,000–$100,000
    image: "https://api.auto-data.net/images/f47/Skoda-Enyaq-Coupe-facelift-2025.jpg",
  ),
  CarModel(
    code: "10333", // Generation id for Enyaq (facelift 2025)
    brand: "Skoda",
    name: "Enyaq (facelift 2025)",
    color: "Unknown",
    description: "Electric vehicle by Skoda",
    price: 52000, // Randomly chosen within $30,000–$100,000
    image: "https://api.auto-data.net/images/f104/Skoda-Enyaq-facelift-2025_2.jpg",
  ),
  CarModel(
    code: "10188", // Generation id for Elroq
    brand: "Skoda",
    name: "Elroq",
    color: "Unknown",
    description: "Electric vehicle by Skoda",
    price: 48000, // Randomly chosen within $30,000–$100,000
    image: "https://api.auto-data.net/images/f104/Skoda-Elroq_4.jpg",
  ),
];