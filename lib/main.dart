import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/classes/cashe_helper.dart';
import 'package:flutter_application_1/features/configration/cubit/configration_cubit.dart';
import 'package:flutter_application_1/features/root/cubit/root_cubit.dart';
import 'package:flutter_application_1/features/wishlist/cubit/wishlist_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/classes/keys.dart';
import 'core/classes/notification.dart';
import 'core/constant/app_theme/app_theme.dart';
import 'core/ui/screens/splash_screen.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/brand/cubit/brand_cubit.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/home/cubit/cubit/home_cubit.dart';
import 'features/matrix/cubit/matrix_cubit.dart';
import 'features/notification/cubit/notification_cubit.dart';
import 'features/offer/cubit/offer_cubit.dart';
import 'features/orders/cubit/order_cubit.dart';
import 'features/product/cubit/product_cubit.dart';
import 'features/search/cubit/search_cubit.dart';
import 'features/sliderBanner/cubit/slider_banner_cubit.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/profile/cubit/profile_states.dart';
import 'features/shopping/cubit/shopping_cubit.dart';
import 'generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FireBaseNotification().initNotification();
  await CacheHelper.init();
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RootCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(),
        ),
        BlocProvider(
          create: (context) => ConfigrationCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => OfferCubit(),
        ),
        BlocProvider(
          create: (context) => ShoppingCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => SliderBannerCubit(),
        ),
        BlocProvider(
          create: (context) => BrandCubit(),
        ),
        BlocProvider(
          create: (context) => MatrixCubit(),
        ),
        BlocProvider(
          create: (context) => WishlistCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        splitScreenMode: false,
        builder: (BuildContext context, Widget? child) {
          return BlocBuilder<ProfileCubit, ProfileStates>(
            builder: (context, state) {
              return MaterialApp(
                locale: context.read<ProfileCubit>().initiallang,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                navigatorKey: Keys.navigatorKey,
                title: 'e-commerce',
                theme: appThemeData[AppTheme.light],
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
