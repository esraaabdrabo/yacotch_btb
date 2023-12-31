import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainee_restaurantapp/core/appStorage/app_storage.dart';
import 'package:trainee_restaurantapp/core/common/style/dimens.dart';
import 'package:trainee_restaurantapp/core/constants/app/app_constants.dart';
import 'package:trainee_restaurantapp/core/localization/language_helper.dart';
import 'package:trainee_restaurantapp/core/navigation/helper.dart';
import 'package:trainee_restaurantapp/core/navigation/route_generator.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/custom_text.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/most_wanted_product/list.dart';
import 'package:trainee_restaurantapp/core/ui/widgets/most_wanted_product/product_entity.dart';
import 'package:trainee_restaurantapp/features/restaurant/home_restaurant/controller/home_restaurant_cubit.dart';
import 'package:trainee_restaurantapp/features/restaurant/my_plates/view/all_plates_screen.dart';
import 'package:trainee_restaurantapp/features/restaurant/restaurant_profile/rest_profile_controller/rest_profile_cubit.dart';
import '../../../../core/common/app_colors.dart';
import '../../../../core/common/style/gaps.dart';
import '../../../../core/ui/loader.dart';
import '../../../../core/ui/widgets/blur_widget.dart';
import '../../../../core/ui/widgets/title_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../trainer/subscription/presentation/view/subscription_screen.dart';
import '../../../trainer/trainee/presentation/view/trainee_profile_view.dart';
import '../../my_plates/view/plate_setails_view.dart';
import '../data/models/dish_model.dart';
import '../data/models/recent_dishes_model.dart';

class HomeRestaurantScreen extends StatefulWidget {
  const HomeRestaurantScreen({Key? key, required this.typeUser})
      : super(key: key);

  final int typeUser;

  @override
  State<HomeRestaurantScreen> createState() => _HomeRestaurantScreenState();
}

class _HomeRestaurantScreenState extends State<HomeRestaurantScreen> {
  Widget restaurantProfile() {
    return Container(
      height: 192.h,
      decoration: const BoxDecoration(
        color: AppColors.darkBrownColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimens.dp10),
            bottomRight: Radius.circular(Dimens.dp10)),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Image.network(''),
            ),
            const Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(bottom: 23.0, left: 23, right: 23),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "مصطفي محمد",
                      fontSize: Dimens.dp20,
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: "الذهبيه",
                      fontSize: Dimens.dp20,
                      color: AppColors.accentColorLight,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.solidBell,
                    color: AppColors.white,
                    size: 30,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMyCourseItemWidget(Items item) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyPlateDetails(
                  dishId: item.id!,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius12),
            image: DecorationImage(
              image:
                  NetworkImage(item.images!.isEmpty ? '' : item.images!.first),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 90.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: BlurWidget(
                      blurColor: AppColors.grey.withOpacity(0.5),
                      height: 100.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 8.w, right: 8.w, top: 14.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: item.name ?? '',
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                  fontSize: AppConstants.textSize14,
                                ),
                                Gaps.hGap4,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.cube,
                                      size: 16,
                                      color: AppColors.accentColorLight,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      child: CustomText(
                                        text: "${item.orderCount} طلب",
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppConstants.textSize12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8.w, 0, 0, 0),
                            child: CustomText(
                              text: "${item.price ?? ''} ريال سعودي",
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentColorLight,
                              fontSize: AppConstants.textSize12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 300.h,
        child: Column(
          children: [
            TitleWidget(
              title: "المتدربين الجدد",
              subtitleColorTapped: () {
                Navigator.pushNamed(context, Routes.traineeScreen);
              },
              subtitle: Translation.of(context).see_all,
              titleColor: AppColors.accentColorLight,
            ),
            Gaps.vGap14,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // widgets.length > 0
                        //     ?
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // widgets.length > 1
                              //     ?
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  // onItemSelected(1);
                                },
                                child: imageWithNameTrainee(),
                              )),
                              // : const SizedBox.shrink(),
                              SizedBox(
                                height: 8.w,
                              ),
                              // widgets.length > 2
                              //     ?
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  //  onItemSelected(2);
                                },
                                child: imageWithNameTrainee(),
                              ))
                              // : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),

                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                                onTap: () {
                                  // onItemSelected(0);
                                },
                                child: imageWithNameTrainee())),
                        //: const SizedBox.shrink(),
                      ],
                    ),
                  ),

                  // widgets.length > 3
                  //     ?
                  // : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWithNameTrainee() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius10),
        image: const DecorationImage(
          image: AssetImage(AppConstants.COACH2_IMAGE),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 35.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              BlurWidget(
                height: 100.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: CustomText(
                        text: "مصطفي محمد",
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                        fontSize: AppConstants.textSize16,
                      ),
                    ),
                    Gaps.hGap4,
                    Container(
                      color: AppColors.accentColorLight,
                      height: 7.h,
                      width: 101.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPlate() {
    return BlocBuilder<HomeRestaurantCubit, HomeRestaurantState>(
      builder: (context, state) {
        List<RecentDishes> listOfRecentDishes =
            HomeRestaurantCubit.of(context).listOfRecentDishes;
        if (state is GetRecentOrderedDishesLoading) {
          return const Loader();
        } else {
          if (listOfRecentDishes.isNotEmpty) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TitleWidget(
                    title: "أحدث الأطباق",
                    subtitleColorTapped: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AllPlatesScreen()));
                    },
                    subtitle: Translation.of(context).see_all,
                    titleColor: AppColors.accentColorLight,
                  ),
                ),
                Gaps.vGap16,
                Container(
                    height: 400.h,
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.2,
                                crossAxisSpacing: 10),
                        itemCount: listOfRecentDishes.length,
                        itemBuilder: (context, v) {
                          return DishesView(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AllPlatesScreen()));
                            },
                            restaurantName:
                                listOfRecentDishes[v].category!.text ?? '',
                            price:
                                (listOfRecentDishes[v].price ?? 0).toString(),
                            imagePlate: listOfRecentDishes[v].images!.first,
                            plateName: listOfRecentDishes[v].name ?? '',
                          );
                        })),
              ],
            );
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }

  Widget restaurantBouquet() {
    return BlocBuilder<RestProfileCubit, RestProfileState>(
        builder: (context, state) {
      if (state is GetRestProfileLoading) {
        return const Loader();
      } else {
        var restaurantsModel = RestProfileCubit.of(context).restaurantsModel;
        return restaurantsModel!.subscription != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100.h,
                  child: Column(
                    children: [
                      TitleWidget(
                        title: LanguageHelper.getTranslation(context)
                            .subscription_plan,
                        subtitleColorTapped: () {},
                        subtitle: "",
                        titleColor: AppColors.accentColorLight,
                      ),
                      Gaps.vGap14,
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            AppConstants.borderRadius10)),
                                    gradient: const LinearGradient(colors: [
                                      AppColors.lightColor,
                                      AppColors.accentColorLight
                                    ])),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: restaurantsModel!
                                                .subscription!.name ??
                                            '',
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white,
                                        fontSize: AppConstants.textSize16,
                                      ),
                                      CustomText(
                                        text:
                                            "${restaurantsModel.subscription!.fee ?? 0} ${LanguageHelper.getTranslation(context).saudi_riyal}",
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white,
                                        fontSize: AppConstants.textSize16,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Gaps.hGap16,
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.transparent
                                            .withOpacity(0.2)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            AppConstants.blurDegree10)),
                                    gradient: LinearGradient(colors: [
                                      AppColors.transparent.withOpacity(0.0),
                                      AppColors.transparent.withOpacity(0.5)
                                    ])),
                                child: Center(
                                  child: MaterialButton(
                                    onPressed: () {
                                      NavigationHelper.goto(
                                          screen: SubscriptionScreen(
                                              typeUser: widget.typeUser),
                                          context: context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox();
      }
    });
  }

  Widget _buildSubscriptionWidget() {
    return BlocBuilder<RestProfileCubit, RestProfileState>(
      // buildWhen: (previous, current) =>
      //     previous != current ||
      //     current is GetRestProfileLoaded ||
      //     current is GetRestProfileLoading,
      builder: (context, state) {
        if (state is GetRestProfileLoading) {
          return const Loader();
        } else {
          var restaurantsModel = RestProfileCubit.of(context).restaurantsModel;
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          gradient: LinearGradient(colors: [
                            AppColors.grey.withOpacity(0.9),
                            AppColors.grey.withOpacity(1),
                          ]),
                          borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius10)),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: restaurantsModel?.logo == null
                                    ? const DecorationImage(
                                        image:
                                            AssetImage(AppConstants.AVATER_IMG),
                                        fit: BoxFit.fill)
                                    : DecorationImage(
                                        image: NetworkImage(
                                            restaurantsModel?.logo ?? ''),
                                        fit: BoxFit.fill),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomText(
                                      text: restaurantsModel?.name ?? "",
                                      color: AppColors.white,
                                      fontSize: AppConstants.textSize14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    CustomText(
                                      text: restaurantsModel
                                              ?.subscription?.name ??
                                          LanguageHelper.getTranslation(context)
                                              .free_susbcription,
                                      color: AppColors.accentColorLight,
                                      fontSize: AppConstants.textSize14,
                                      fontWeight: FontWeight.w600,
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  void initState() {
    RestProfileCubit.of(context).getRestaurantProfile(context);
    HomeRestaurantCubit.of(context).getAllDishMostOrderedHome();
    HomeRestaurantCubit.of(context).getRecentOrderedDishes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestProfileCubit, RestProfileState>(
      builder: (context, state) {
        var restaurantsModel = RestProfileCubit.of(context).restaurantsModel;
        return restaurantsModel == null
            ? const SizedBox()
            : SafeArea(
                child: CustomScrollView(slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: CustomSliverDelegate(
                      latitude: restaurantsModel.latitude ?? 30.033333,
                      longitude: restaurantsModel.longitude ?? 31.233334,
                      expandedHeight: 230.h,
                      child: _buildSubscriptionWidget(),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          BlocBuilder<HomeRestaurantCubit, HomeRestaurantState>(
                            builder: (context, state) {
                              if (state is GetAllDishMostOrderedHomeLoading) {
                                return const SizedBox(
                                  height: 350,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return const _WantedPlates();
                            },
                          ),
                          Gaps.vGap16,
                          // getPlate(),
                          restaurantBouquet(),
                          Gaps.vGap60,
                        ],
                      ),
                    ),
                  ),
                ]),
              );
      },
    );
  }
}

class _WantedPlates extends StatelessWidget {
  const _WantedPlates();

  @override
  Widget build(BuildContext context) {
    return MostWantedProducts(
        getDeatilsScreen: (index) => MyPlateDetails(
            dishId: HomeRestaurantCubit.of(context).listOfDishs[index].id!),
        title: LanguageHelper.getTranslation(context).dishsMostOrder,
        allProductsScreen: const AllPlatesScreen(),
        HomeRestaurantCubit.of(context)
            .listOfDishs
            .map((e) => ProductEntity(
                id: e.id,
                images: e.images,
                name: e.name,
                numOfOrders: e.orderCount,
                price: e.price))
            .toList());
  }
}

class DishesView extends StatelessWidget {
  final String restaurantName;
  final String plateName;
  final String? imagePlate;
  final String price;
  final void Function()? onTap;

  const DishesView({
    Key? key,
    required this.price,
    required this.imagePlate,
    required this.restaurantName,
    required this.plateName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plateName,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: AppConstants.textSize14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            child: Text(
                              restaurantName,
                              style: const TextStyle(
                                  color: Colors.yellow, fontSize: 11),
                            ),
                          ),
                          Text(
                            "$price ${LanguageHelper.getTranslation(context).saudi_riyal}",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        imagePlate ??
                            "https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
                      ),
                      fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
