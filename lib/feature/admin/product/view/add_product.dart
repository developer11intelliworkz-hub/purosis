import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_drop_down.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../utils/commmon_function.dart';
import '../../../../widget/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<PlatformFile> selectedImages = [];
  Color selectedColor = Color(0xFF000000);

  void addImages() async {
    final images = await CommonFunction.pickMultipleImages(alreadySelected: selectedImages.length,maxLimit: 6);
    setState(() {
      selectedImages.addAll(images);
    });
  }

  void removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonWidget.AppAppBar(title: "Add New Product"),body: SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        AppTextField(labelText: "Product Name",),
        SizedBox(height: 10,),
        AppDropDown(label: 'Category', items: (data,value) => [],compareFn: (p0, p1) => p0==p1,),
        SizedBox(height: 10,),
        AppTextField(labelText: "Description",),
        SizedBox(height: 10,),
        Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(8)),
            child: Row(children: [
              AppText(text: "Mate Black"),
              Spacer(),
              IconButton(onPressed: () {

              }, icon: Icon(Icons.close))
            ],),
          )
        ],),
        AppText(text: "Product Image",fontSize: 15,fontWeight: FontWeight.w600,),
        SizedBox(height: 5,),
        ImagePicker(
          images: selectedImages,
          onAdd: addImages,
          onRemove: removeImage,
        ),
          SizedBox(height: 5,),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Pick a color"),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: selectedColor,
                        onColorChanged: (color) {
                          setState(() => selectedColor = color);
                        },
                        showLabel: true,
                        pickerAreaHeightPercent: 0.8,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Done"),
                      )
                    ],
                  ),
                );
              },
                child: Container(width: 50,height: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(color: selectedColor)),padding: EdgeInsets.all(3),child: Container(decoration: BoxDecoration(color: selectedColor,borderRadius: BorderRadius.circular(8)),),)),
            SizedBox(width: 5,),
            Expanded(flex:4,child: AppTextField(labelText: "Color Name",)),
            SizedBox(width: 5,),
            Expanded(child: AppButton(text: "Add",color: Color(0xFF8EBF1F),))
          ],
        ),
        SizedBox(height: 10,),
        Row(children: [
          Expanded(child: AppTextField(labelText: "Unit per Box",)),
          SizedBox(width: 3,),
          Expanded(child: AppTextField(labelText: "Weight per Box (kg)",))
        ],),
        SizedBox(height: 10,),
        AppText(text: "Dimensions (cm) - for CBM calculation",fontSize: 15,fontWeight: FontWeight.w600,),
        SizedBox(height: 5,),
        Row(children: [
          Expanded(child: AppTextField(labelText: "Length",)),
          SizedBox(width: 3,),
          Expanded(child: AppTextField(labelText: "Width",)),
          SizedBox(width: 3,),
          Expanded(child: AppTextField(labelText: "Height",)),
        ],),
        SizedBox(height: 10,),
        AppTextField(labelText: "Technical Video URL",),
        SizedBox(height: 10,),
        AppButton(text: "Add Product",color: Color(0xFF8EBF1F),),
          SizedBox(height: 10,),
      ],),
    ),);
  }
}
