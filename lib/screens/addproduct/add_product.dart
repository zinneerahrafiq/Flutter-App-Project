import 'dart:io';

import 'package:ecom/widgets/custom_app_bar.dart';
import 'package:ecom/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ecom/blocs/products/products_bloc.dart';
import 'package:ecom/models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/addproduct";

  @override
  _AddProductScreenState createState() => _AddProductScreenState();

  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => AddProductScreen(),
      );
}

class _AddProductScreenState extends State<AddProductScreen> {
  static const String routeName = "/addproduct";
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isRecommended = false;
  bool _isPopular = false;
  XFile? _imageFile;
  bool _isUploading = false;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      return;
    }
    setState(() {
      _isUploading = true;
    });
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('product_images/$fileName');
    final metadata =
        firebase_storage.SettableMetadata(contentType: 'image/jpeg');
    try {
      await ref.putFile(File(_imageFile!.path), metadata);
      final downloadUrl = await ref.getDownloadURL();
      setState(() {
        _imageUrlController.text = downloadUrl;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to upload image')));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ADD PRODUCT',
      ),
      bottomNavigationBar: CustomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              if (_imageFile != null)
                Column(
                  children: [
                    Image.file(File(_imageFile!.path)),
                    SizedBox(height: 8.0),
                    if (_isUploading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: _uploadImage,
                        child: Text('Upload Image'),
                      ),
                  ],
                )
              else
                FilledButton(
                  onPressed: _selectImage,
                  child: Text('Select Image'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.teal.shade800,
                  ),
                ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Text(
                    "Is Recommended?",
                    style: TextStyle(color: Colors.black),
                  ),
                  Checkbox(
                    value: _isRecommended,
                    onChanged: (value) {
                      setState(() {
                        _isRecommended = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Is Popular?",
                    style: TextStyle(color: Colors.black),
                  ),
                  Checkbox(
                    value: _isPopular,
                    onChanged: (value) {
                      setState(() {
                        _isPopular = value ?? false;
                      });
                    },
                  ),
                  Text('Popular'),
                ],
              ),
              SizedBox(height: 16.0),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.teal.shade800,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newProduct = Product(
                      name: _nameController.text,
                      category: _categoryController.text,
                      imageUrl: _imageUrlController.text,
                      price: double.parse(_priceController.text),
                      isRecommended: _isRecommended,
                      isPopular: _isPopular,
                    );
                    BlocProvider.of<ProductsBloc>(context)
                        .add(AddProduct(newProduct));
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
