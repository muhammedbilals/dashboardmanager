
// // ignore: must_be_immutable
// import 'package:dashboard/core/colors/colors.dart';
// import 'package:dashboard/core/constant/constant.dart';
// import 'package:dashboard/presentation/cubit/button_cubit/button_cubit.dart';
// import 'package:dashboard/presentation/cubit/button_cubit/button_state.dart';
// import 'package:dashboard/presentation/pages/home_page.dart';
// import 'package:dashboard/shared/validation/textfield_validation.dart';
// import 'package:dashboard/shared/widgets/button_widget.dart';
// import 'package:dashboard/shared/widgets/colored_safearea.dart';
// import 'package:dashboard/shared/widgets/text_field_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:bloc/bloc.dart';

// class CreateAccountPage extends StatefulWidget {
//   const CreateAccountPage({super.key});

//   @override
//   State<CreateAccountPage> createState() => _CreateAccountPageState();
// }

// class _CreateAccountPageState extends State<CreateAccountPage> {
//   late final GlobalKey<FormState> formKey;

//   final nameController = TextEditingController();

//   final emailController = TextEditingController();

//   final passwordController = TextEditingController();

//   final reEnterPasswordController = TextEditingController();

//   // bool isEmail(String input) => EmailValidator.validate(input);
//   bool isValidated = false;

//   @override
//   void initState() {
//     formKey = GlobalKey<FormState>();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ColoredSafeArea(
//       color: bggray,
//       child: Scaffold(
//         appBar: const PreferredSize(
//             preferredSize: Size.fromHeight(70), child: AppBarWidget()),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: padding20),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
              
//                   sbox20,
//                   TextFieldWidget(
//                     textInputAction: TextInputAction.next,
//                     textInputType: TextInputType.name,
//                     labelText: 'Full Name',
//                     textEditingController: nameController,
//                     autofillHints: const [AutofillHints.name],
//                     onEditingComplete: () => FocusScope.of(context).nextFocus(),
//                     validator: (value) {
//                       if (value != null && value.length < 2) {
//                         return 'name is required';
//                       } else {
//                         return null;
//                       }
//                     },
//                     onChanged: (string) {
//                       isValidated = formKey.currentState!.validate();
//                       BlocProvider.of<ButtonCubit>(context)
//                           .validateTextfield(isValidated);
//                     },
//                   ),
//                   sbox,
//                   TextFieldWidget(
//                       textInputAction: TextInputAction.next,
//                       textInputType: TextInputType.emailAddress,
//                       labelText: 'Email',
//                       textEditingController: emailController,
//                       autofillHints: const [AutofillHints.email],
//                       onEditingComplete: () =>
//                           FocusScope.of(context).nextFocus(),
//                       onChanged: (string) {
//                         isValidated = formKey.currentState!.validate();
//                         BlocProvider.of<ButtonCubit>(context)
//                             .validateTextfield(isValidated);
//                       },
//                       validator: (email) {
//                         if (!TextfieldValidation.isEmail(email!) &&
//                             !TextfieldValidation.isPhone(email)) {
//                           return 'Please enter a valid email or phone number';
//                         }
//                         return null;
//                       }),
//                   sbox,
//                   TextFieldWidget(
//                     textInputAction: TextInputAction.next,
//                     obscureText: true,
//                     textInputType: TextInputType.visiblePassword,
//                     labelText: 'Create Password',
//                     textEditingController: passwordController,
//                     autofillHints: const [AutofillHints.newPassword],
//                     onChanged: (string) {
//                       isValidated = formKey.currentState!.validate();
//                       BlocProvider.of<ButtonCubit>(context)
//                           .validateTextfield(isValidated);
//                     },
//                     onEditingComplete: () => FocusScope.of(context).nextFocus(),
//                     validator: (value) {
//                       if (value != null && value.length < 7) {
//                         return 'password min 7 char';
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),
//                   sbox,
//                   TextFieldWidget(
//                     textInputAction: TextInputAction.done,
//                     obscureText: true,
//                     textInputType: TextInputType.visiblePassword,
//                     labelText: 'Re-enter Password',
//                     textEditingController: reEnterPasswordController,
//                     autofillHints: const [AutofillHints.password],
//                     onChanged: (string) {
//                       isValidated = formKey.currentState!.validate();
//                       BlocProvider.of<ButtonCubit>(context)
//                           .validateTextfield(isValidated);
//                     },
//                     onEditingComplete: () => FocusScope.of(context).nextFocus(),
//                     validator: (value) {
//                       if (value != null && value != passwordController.text) {
//                         return 'password doesnt match';
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),
//                   sbox20,
//                   BlocListener<AuthBloc, AuthBlocState>(
//                     listener: (context, state) {
//                       if (state is SignUpAuthLoading) {
//                         BlocProvider.of<ButtonCubit>(context)
//                             .setLoading(ButtonStatus.loading);
//                       } else if (state is SignUpAuthFailed) {
//                         BlocProvider.of<ButtonCubit>(context)
//                             .setLoading(ButtonStatus.error);
//                         Utils.showSnackbar(state.message);
//                       } else if (state is SignUpAuthSuccess) {
//                         BlocProvider.of<ButtonCubit>(context)
//                             .setLoading(ButtonStatus.idle);

//                         if (state.authEntity.successStatus == true) {
//                           Utils.showSnackbar(
//                               'Account Created with ${state.authEntity.data.email}');
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const HomePage(
                                
//                               ),
//                             ),
//                           );
//                         }
//                       }
//                     },
//                     child: BlocBuilder<ButtonCubit, ButtonState>(
//                       builder: (context, state) {
//                         return ButtonWidget(
//                           text: 'Create account',
//                           // navigation: const CreateAccountOtp(),
//                           width: 100.w,
//                           formKey: formKey,
//                           buttonStatus: state.buttonStatus,

//                           color: (state is ButtonValidated && state.isValidated)
//                               ? colorred
//                               : colorgrey,
//                           onPressed: () {
//                             if (state is ButtonValidated && state.isValidated) {
//                               context.read<AuthBloc>().add(
//                                   CreateAccountwithAuth(
//                                       fullName: nameController.text,
//                                       emailOrPhoneNumber: emailController.text,
//                                       password: passwordController.text));
//                             } else {
//                               null;
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ),
                  
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 const HomePage(),
//                           ));
//                     },
//                     child: const Center(
//                       child: Text(
//                         "I will create my account later",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: Color.fromARGB(255, 3, 17, 31),
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Row(
//                   //   children: [
//                   //     const Spacer(),
//                   //     Padding(
//                   //       padding: const EdgeInsets.all(padding),
//                   //       child: GestureDetector(
//                   //         onTap: () {
//                   //           Navigator.push(
//                   //               context,
//                   //               MaterialPageRoute(
//                   //                 builder: (context) => const MyAccountPage2(),
//                   //               ));
//                   //         },
//                   //       ),
//                   //     ),
//                   //   ],
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
