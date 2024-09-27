import 'package:dashboard/core/constant/constant.dart';
import 'package:dashboard/domain/entity/request/property_request.dart';
import 'package:dashboard/presentation/cubit/button_cubit/button_cubit.dart';
import 'package:dashboard/presentation/cubit/button_cubit/button_state.dart';
import 'package:dashboard/presentation/cubit/create_property_cubit/create_property_cubit.dart';
import 'package:dashboard/presentation/cubit/create_property_cubit/create_property_state.dart';
import 'package:dashboard/shared/widgets/button_widget.dart';
import 'package:dashboard/shared/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPropertyBottomSheet extends StatefulWidget {
  @override
  _AddPropertyBottomSheetState createState() => _AddPropertyBottomSheetState();
}

class _AddPropertyBottomSheetState extends State<AddPropertyBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _propertyNameController = TextEditingController();
  final _propertyTypeController = TextEditingController();
  final _locationController = TextEditingController();
  final _sizeSqFtController = TextEditingController();
  final _priceController = TextEditingController();
  final _noOfBedroomsController = TextEditingController();
  final _noOfBathroomsController = TextEditingController();

  bool isValidated = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text('Add New Property',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextFieldWidget(
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              textInputType: TextInputType.text,
              labelText: 'Property Name',
              textEditingController: _propertyNameController,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Property name is required';
                }
                return null;
              },
              onChanged: _onFieldChanged,
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              textInputType: TextInputType.text,
              labelText: 'Property Type',
              textEditingController: _propertyTypeController,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Property type is required';
                }
                return null;
              },
              onChanged: _onFieldChanged,
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
              labelText: 'Location',
              autofillHints: const [AutofillHints.name],
              textEditingController: _locationController,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Location is required';
                }
                return null;
              },
              onChanged: _onFieldChanged,
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              labelText: 'Size (sq ft)',
              autofillHints: const [AutofillHints.name],
              textEditingController: _sizeSqFtController,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Size is required';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onChanged: _onFieldChanged,
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              autofillHints: const [AutofillHints.name],
              labelText: 'Price',
              textEditingController: _priceController,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Price is required';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onChanged: _onFieldChanged,
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              textInputType: TextInputType.number,
              labelText: 'Number of Bedrooms',
              textEditingController: _noOfBedroomsController,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Number of bedrooms is required';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onChanged: _onFieldChanged,
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.number,
              labelText: 'Number of Bathrooms',
              textEditingController: _noOfBathroomsController,
              autofillHints: const [AutofillHints.name],
              onEditingComplete: () => _submitForm(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Number of bathrooms is required';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onChanged: _onFieldChanged,
            ),
            sbox20,
            BlocBuilder<CreatePropertyCubit, PropertyState>(
              builder: (context, state) {
                ButtonStatus buttonStatus;

                if (state is PropertyCreateLoading) {
                  buttonStatus = ButtonStatus.loading;
                } else if (state is PropertyCreateFailure) {
                  buttonStatus = ButtonStatus.error;
                } else {
                  buttonStatus = ButtonStatus.idle;
                }
                if (state is PropertyCreateSuccess) {
                  buttonStatus = ButtonStatus.idle;
                  Navigator.pop(context);
                }
                return ButtonWidget(
                  text: 'Submit',
                  buttonStatus: buttonStatus,
                  onPressed: () {
                    // isValidated ? _submitForm : null;
                    BlocProvider.of<CreatePropertyCubit>(context)
                        .createProperty(PropertyRequest(
                      propertyName: _propertyNameController.text,
                      propertyType: _propertyTypeController.text,
                      location: _locationController.text,
                      sizeSqFt: int.parse(_sizeSqFtController.text),
                      price: int.parse(_priceController.text),
                      noOfBedrooms: int.parse(_noOfBedroomsController.text),
                      noOfBathrooms: int.parse(_noOfBathroomsController.text),
                    ));
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _onFieldChanged(String value) {
    setState(() {
      isValidated = _formKey.currentState!.validate();
    });
    BlocProvider.of<ButtonCubit>(context).validateTextfield(isValidated);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create a new property object
      final newProperty = PropertyRequest(
        propertyName: _propertyNameController.text,
        propertyType: _propertyTypeController.text,
        location: _locationController.text,
        sizeSqFt: int.parse(_sizeSqFtController.text),
        price: int.parse(_priceController.text),
        noOfBedrooms: int.parse(_noOfBedroomsController.text),
        noOfBathrooms: int.parse(_noOfBathroomsController.text),
      );

      // Add the new property (you'll need to implement this method in your PropertyCubit)
      BlocProvider.of<CreatePropertyCubit>(context).createProperty(newProperty);

      // Close the bottom sheet
      // Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _propertyNameController.dispose();
    _propertyTypeController.dispose();
    _locationController.dispose();
    _sizeSqFtController.dispose();
    _priceController.dispose();
    _noOfBedroomsController.dispose();
    _noOfBathroomsController.dispose();
    super.dispose();
  }
}
