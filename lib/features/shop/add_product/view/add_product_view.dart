import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/common/app_colors.dart';
import 'package:trainee_restaurantapp/core/common/validators.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/localization/language_helper.dart';
import 'package:trainee_restaurantapp/core/ui/loader.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_button.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/core/models/categories_model.dart';
import 'package:trainee_restaurantapp/features/shop/add_product/controller/add_product_cubit.dart';

import '../../../../core/common/style/dimens.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';

class AddProductView extends StatefulWidget {
  AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  uploadSignUpFile(
      {required void Function()? onTap, required String text, File? file}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 120.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.hGap20,
              CustomText(
                  text: text,
                  fontSize: AppConstants.textSize18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentColorLight),
              Gaps.hGap12,
              DottedBorder(
                color: AppColors.white,
                dashPattern: const [10, 3],
                radius: const Radius.circular(10),
                borderType: BorderType.Rect,
                strokeWidth: 3,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((Dimens.dp12))),
                  height: Dimens.dp80.h,
                  width: double.infinity,
                  child: Center(
                    child: file == null
                        ? const Center(
                            child: FaIcon(
                              FontAwesomeIcons.upload,
                              color: AppColors.accentColorLight,
                              size: Dimens.dp40,
                            ),
                          )
                        : Image.file(file),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var tr = LanguageHelper.getTranslation(context);
    return BlocProvider(
      create: (context) => AddProductCubit()..getCategories(),
      child: BlocBuilder<AddProductCubit, AddProductState>(
        buildWhen: (previous, current) =>
            previous != current || current is UploadSignUpFileState,
        builder: (context, state) {
          return Scaffold(
            body: state is GetCategoryLoading
                ? const Loader()
                : SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: AddProductCubit.of(context).formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: tr.add_Product,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: AppConstants.textSize18,
                              ),
                              Gaps.vGap16,
                              EmailTextField(
                                text: tr.product_Name_Arabic,
                                validator: (input) =>
                                    !Validators.isArabic(input!)
                                        ? tr.enter_at_letters
                                        : null,
                                onFiledSubmitted: () {
                                  // FocusScope.of(context).requestFocus(passwordFocusNode);
                                },
                                textInputAction: TextInputAction.next,
                                controller: AddProductCubit.of(context)
                                    .nameArProductController,
                                focusNode:
                                    AddProductCubit.of(context).nameArProduct,
                              ),
                              Gaps.vGap16,
                              EmailTextField(
                                text: tr.product_Name_English,
                                validator: (input) =>
                                    !Validators.isEnglish(input!)
                                        ? tr.enter_eng_letters
                                        : null,
                                onFiledSubmitted: () {
                                  // FocusScope.of(context).requestFocus(passwordFocusNode);
                                },
                                textInputAction: TextInputAction.next,
                                controller: AddProductCubit.of(context)
                                    .nameEnProductController,
                                focusNode:
                                    AddProductCubit.of(context).nameEnProduct,
                              ),
                              Gaps.vGap16,
                              uploadSignUpFile(
                                text: tr.attach_Image_Product,
                                file: AddProductCubit.of(context).file,
                                onTap: () async =>
                                    await AddProductCubit.of(context)
                                        .getProductImage(),
                              ),
                              Gaps.vGap16,
                              DropdownButton<Items>(
                                value: AddProductCubit.of(context)
                                    .dropdownValueCate,
                                hint: Text(
                                  tr.choose_category,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                dropdownColor: Colors.grey,
                                underline: Container(
                                  height: 2,
                                  color: Colors.white,
                                ),
                                onChanged: (Items? value) {
                                  setState(() {
                                    AddProductCubit.of(context)
                                        .dropdownValueCate = value!;
                                  });
                                },
                                items: AddProductCubit.of(context)
                                    .listOfCates
                                    .map<DropdownMenuItem<Items>>(
                                        (Items value) {
                                  return DropdownMenuItem<Items>(
                                    value: value,
                                    child: Text(
                                      value.name ?? '',
                                    ),
                                  );
                                }).toList(),
                              ),
                              Gaps.vGap16,
                              EmailTextField(
                                keboardType: TextInputType.number,
                                validator: (input) =>
                                    Validators.isNumber(input!, context),
                                text: tr.product_price,
                                onFiledSubmitted: () {
                                  // FocusScope.of(context).requestFocus(passwordFocusNode);
                                },
                                textInputAction: TextInputAction.next,
                                controller: AddProductCubit.of(context)
                                    .priceProductController,
                                focusNode:
                                    AddProductCubit.of(context).pricePlate,
                              ),
                              Gaps.vGap16,
                              EmailTextField(
                                validator: (input) =>
                                    !Validators.isArabic(input!)
                                        ? tr.enter_at_letters
                                        : null,
                                text: tr.product_ingred_ar,
                                onFiledSubmitted: () {
                                  // FocusScope.of(context).requestFocus(passwordFocusNode);
                                },
                                textInputAction: TextInputAction.next,
                                controller: AddProductCubit.of(context)
                                    .componentsArProductController,
                                focusNode:
                                    AddProductCubit.of(context).comArPlate,
                              ),
                              Gaps.vGap16,
                              EmailTextField(
                                validator: (input) =>
                                    !Validators.isEnglish(input!)
                                        ? tr.enter_eng_letters
                                        : null,
                                text: tr.product_ingred_en,
                                onFiledSubmitted: () {
                                  // FocusScope.of(context).requestFocus(passwordFocusNode);
                                },
                                textInputAction: TextInputAction.next,
                                controller: AddProductCubit.of(context)
                                    .componentsEnProductController,
                                focusNode:
                                    AddProductCubit.of(context).comEnPlate,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 45.0, horizontal: 20),
                                  child: state is UploadImageLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : CustomElevatedButton(
                                          borderRadius: 12,
                                          onTap: () =>
                                              AddProductCubit.of(context)
                                                  .createProducr(context),
                                          text: tr.add,
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
