import 'package:dashboard/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:dashboard/presentation/cubit/button_cubit/button_cubit.dart';
import 'package:dashboard/presentation/pages/home_page.dart';
import 'package:dashboard/presentation/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
                BlocProvider(create: (context) => ButtonCubit()),
                        BlocProvider(create: (_) => di.sl<AuthCubit>()),



      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
          
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const RegistrationPage(),
        );}
      ),
    );
  }
}