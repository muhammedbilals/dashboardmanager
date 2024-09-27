import 'package:dashboard/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:dashboard/presentation/cubit/button_cubit/button_cubit.dart';
import 'package:dashboard/presentation/cubit/create_property_cubit/create_property_cubit.dart';
import 'package:dashboard/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:dashboard/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  localDb = await SharedPreferences.getInstance();

  runApp(const MyApp());
}
late SharedPreferences localDb;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ButtonCubit()),
        BlocProvider(create: (_) => di.sl<AuthCubit>()),
        BlocProvider(create: (_) => di.sl<PropertyCubit>()),
        BlocProvider(create: (_) => di.sl<CreatePropertyCubit>()),


      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashPage(),
        );}
      ),
    );
  }
}