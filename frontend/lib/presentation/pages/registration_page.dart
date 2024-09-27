
// ignore: must_be_immutable
import 'package:dashboard/core/colors/colors.dart';
import 'package:dashboard/core/constant/constant.dart';
import 'package:dashboard/domain/entity/request/login_request.dart';
import 'package:dashboard/domain/entity/request/registration_request.dart';
import 'package:dashboard/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:dashboard/presentation/cubit/auth_cubit/auth_state.dart';
import 'package:dashboard/presentation/cubit/button_cubit/button_cubit.dart';
import 'package:dashboard/presentation/cubit/button_cubit/button_state.dart';
import 'package:dashboard/presentation/pages/home_page.dart';
import 'package:dashboard/shared/validation/textfield_validation.dart';
import 'package:dashboard/shared/widgets/button_widget.dart';
import 'package:dashboard/shared/widgets/colored_safearea.dart';
import 'package:dashboard/shared/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';



class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  late final GlobalKey<FormState> formKey;

  final firsttNameController = TextEditingController();
  final lastNamenameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final mobileNumberController = TextEditingController();

  final reEnterPasswordController = TextEditingController();

  // bool isEmail(String input) => EmailValidator.validate(input);
  bool isValidated = false;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredSafeArea(
      color: bggray,
      child: Scaffold(
        appBar:  PreferredSize(
            preferredSize: Size.fromHeight(70), child: AppBar(
              title: Text("Registration"),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  sbox20,
                  TextFieldWidget(
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    labelText: 'First Name',
                    textEditingController: firsttNameController,
                    autofillHints: const [AutofillHints.name],
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: (value) {
                      if (value != null && value.length < 2) {
                        return 'name is required';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (string) {
                      isValidated = formKey.currentState!.validate();
                      BlocProvider.of<ButtonCubit>(context)
                          .validateTextfield(isValidated);
                    },
                  ),
                   sbox20,
                  TextFieldWidget(
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    labelText: 'Last Name',
                    textEditingController: lastNamenameController,
                    autofillHints: const [AutofillHints.name],
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: (value) {
                      if (value != null && value.length < 2) {
                        return 'name is required';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (string) {
                      isValidated = formKey.currentState!.validate();
                      BlocProvider.of<ButtonCubit>(context)
                          .validateTextfield(isValidated);
                    },
                  ),
                  sbox,
                  TextFieldWidget(
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      labelText: 'Email',
                      textEditingController: emailController,
                      autofillHints: const [AutofillHints.email],
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      onChanged: (string) {
                        isValidated = formKey.currentState!.validate();
                        BlocProvider.of<ButtonCubit>(context)
                            .validateTextfield(isValidated);
                      },
                      validator: (email) {
                        if (!TextfieldValidation.isEmail(email!) &&
                            !TextfieldValidation.isPhone(email)) {
                          return 'Please enter a valid email or phone number';
                        }
                        return null;
                      }),
                  sbox,
                  TextFieldWidget(
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Mobile Number',
                    textEditingController: mobileNumberController,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    onChanged: (string) {
                      isValidated = formKey.currentState!.validate();
                      BlocProvider.of<ButtonCubit>(context)
                          .validateTextfield(isValidated);
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: (value) {
                      if (value != null && value.length < 10) {
                        return 'Phone Number minimum 10 char';
                      } else {
                        return null;
                      }
                    },
                  ),
                  sbox20,

                  TextFieldWidget(
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Password',
                    textEditingController: passwordController,
                    autofillHints: const [AutofillHints.newPassword],
                    onChanged: (string) {
                      isValidated = formKey.currentState!.validate(); 
                      BlocProvider.of<ButtonCubit>(context)
                          .validateTextfield(isValidated);
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: (value) {
                          // Check if the password is null or empty
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }

                        // Check length between 8 and 16 characters
                        if (value.length < 8 || value.length > 16) {
                          return 'Password must be between 8 and 16 characters';
                        }

                        // Check for at least one numeric character
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return 'Password must contain at least one numeric character';
                        }

                        // Check for at least one special character
                        if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                          return 'Password must contain at least one special character';
                        }

                        return null; // Return null if the password is valid
                    },
                  ),
                  sbox20,
                  TextFieldWidget(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Confirm Password',
                    textEditingController: reEnterPasswordController,
                    autofillHints: const [AutofillHints.password],
                    onChanged: (string) {
                      isValidated = formKey.currentState!.validate();
                      BlocProvider.of<ButtonCubit>(context)
                          .validateTextfield(isValidated);
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    validator: (value) {
                      if (value != null && value != passwordController.text) {
                        return 'password doesnt match';
                      } else {
                        return null;
                      }
                    },
                  ),
                 
                  sbox20,
                  
                  BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    ButtonStatus buttonStatus;

                    if (state is AuthLoading) {
                      buttonStatus = ButtonStatus.loading;
                    } else if (state is AuthFailure) {
                      buttonStatus = ButtonStatus.error;
                    } else {
                      buttonStatus = ButtonStatus.idle;
                    }
                    return ButtonWidget(
                      width: 100.w,
                      text: 'Register',
                      onPressed: () {
                        final registrationRequest = RegistraionRequest(
                          email: emailController.text,
                          password: passwordController.text,
                          mobileNumber: mobileNumberController.text
                        );
                        context.read<AuthCubit>().register(registrationRequest);
                      },
                      buttonStatus: buttonStatus,
                      // Add any other parameters you need
                    );
                  },)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
