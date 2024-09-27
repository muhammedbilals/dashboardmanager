import 'package:dashboard/domain/entity/request/property_request.dart';
import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:dashboard/presentation/cubit/button_cubit/button_cubit.dart';
import 'package:dashboard/presentation/cubit/button_cubit/button_state.dart';
import 'package:dashboard/presentation/cubit/property_cubit/property_cubit.dart';

import 'package:dashboard/presentation/cubit/update_property_cubit/update_property_cubit.dart';
import 'package:dashboard/presentation/cubit/update_property_cubit/update_property_state.dart';
import 'package:dashboard/presentation/widgets/button_widget.dart';
import 'package:dashboard/presentation/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePropertyPage extends StatefulWidget {
  final Property property;

  const UpdatePropertyPage({super.key, required this.property});
  @override
  UpdatePropertyPageState createState() => UpdatePropertyPageState();
}

class UpdatePropertyPageState extends State<UpdatePropertyPage> {
  final _formKey = GlobalKey<FormState>();
  late final _propertyNameController;
  late final _propertyTypeController;
  late final _locationController;
  late final _sizeSqFtController;
  late final _priceController;
  late final _noOfBedroomsController;
  late final _noOfBathroomsController;

  bool isValidated = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with values from the property if available
    _propertyNameController =
        TextEditingController(text: widget.property.propertyName);
    _propertyTypeController =
        TextEditingController(text: widget.property.propertyType);
    _locationController = TextEditingController(text: widget.property.location);
    _sizeSqFtController =
        TextEditingController(text: widget.property.sizeSqFt.toString());
    _priceController =
        TextEditingController(text: widget.property.price.toString());
    _noOfBedroomsController =
        TextEditingController(text: widget.property.noOfBedrooms.toString());
    _noOfBathroomsController =
        TextEditingController(text: widget.property.noOfBathrooms.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Property'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
              const SizedBox(height: 20),
              BlocBuilder<UpdatePropertyCubit, PropertyState>(
                builder: (context, state) {
                  ButtonStatus buttonStatus;

                  if (state is PropertyUpdateLoading) {
                    buttonStatus = ButtonStatus.loading;
                  } else if (state is PropertyUpdateFailure) {
                    buttonStatus = ButtonStatus.error;
                  } else {
                    buttonStatus = ButtonStatus.idle;
                  }

                  if (state is PropertyUpdateSuccess) {
                    buttonStatus = ButtonStatus.idle;
                    context.read<PropertyCubit>().fetchProperties();
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        Navigator.pop(context);
                      },
                    );
                  }

                  return ButtonWidget(
                    text: 'Update',
                    buttonStatus: buttonStatus,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<UpdatePropertyCubit>(context)
                            .updateProperty(
                          widget.property.id,
                          PropertyRequest(
                            propertyName: _propertyNameController.text,
                            propertyType: _propertyTypeController.text,
                            location: _locationController.text,
                            sizeSqFt: int.parse(_sizeSqFtController.text),
                            price: int.parse(_priceController.text),
                            noOfBedrooms:
                                int.parse(_noOfBedroomsController.text),
                            noOfBathrooms:
                                int.parse(_noOfBathroomsController.text),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
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
    if (_formKey.currentState!.validate()) {}
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
