import 'package:flutter/material.dart';

import '../../../../config/constants/app_constants.dart';
import '../../data/models/order_model.dart';
import 'form_field.dart';

/// Address form widget for checkout
class AddressForm extends StatefulWidget {
  final ShippingAddress? initialAddress;
  final Function(ShippingAddress) onAddressChanged;

  const AddressForm({Key? key, this.initialAddress, required this.onAddressChanged}) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  late TextEditingController _fullNameController;
  late TextEditingController _addressLine1Controller;
  late TextEditingController _addressLine2Controller;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipCodeController;
  late TextEditingController _countryController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _fullNameController = TextEditingController(text: widget.initialAddress?.fullName ?? '');
    _addressLine1Controller = TextEditingController(text: widget.initialAddress?.addressLine1 ?? '');
    _addressLine2Controller = TextEditingController(text: widget.initialAddress?.addressLine2 ?? '');
    _cityController = TextEditingController(text: widget.initialAddress?.city ?? '');
    _stateController = TextEditingController(text: widget.initialAddress?.state ?? '');
    _zipCodeController = TextEditingController(text: widget.initialAddress?.zipCode ?? '');
    _countryController = TextEditingController(text: widget.initialAddress?.country ?? '');
    _phoneNumberController = TextEditingController(text: widget.initialAddress?.phoneNumber ?? '');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _updateAddress() {
    final address = ShippingAddress(
      fullName: _fullNameController.text,
      addressLine1: _addressLine1Controller.text,
      addressLine2: _addressLine2Controller.text,
      city: _cityController.text,
      state: _stateController.text,
      zipCode: _zipCodeController.text,
      country: _countryController.text,
      phoneNumber: _phoneNumberController.text,
    );
    widget.onAddressChanged(address);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Full Name
        CustomFormField(
          label: 'Full Name',
          hintText: 'Your name',
          controller: _fullNameController,
          required: true,
          onChanged: (_) => _updateAddress(),
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // Address Line 1
        CustomFormField(
          label: 'Address Line 1',
          hintText: '123 Main Street',
          controller: _addressLine1Controller,
          required: true,
          onChanged: (_) => _updateAddress(),
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // Address Line 2
        CustomFormField(
          label: 'Address Line 2',
          hintText: 'Apartment, suite, etc.',
          controller: _addressLine2Controller,
          onChanged: (_) => _updateAddress(),
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // City and State
        Row(
          children: [
            Expanded(
              child: CustomFormField(
                label: 'City',
                hintText: 'New York',
                controller: _cityController,
                required: true,
                onChanged: (_) => _updateAddress(),
              ),
            ),
            const SizedBox(width: AppConstants.spacingMd),
            Expanded(
              child: CustomFormField(
                label: 'State',
                hintText: 'NY',
                controller: _stateController,
                required: true,
                onChanged: (_) => _updateAddress(),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // ZIP Code and Country
        Row(
          children: [
            Expanded(
              child: CustomFormField(
                label: 'ZIP Code',
                hintText: '10001',
                controller: _zipCodeController,
                required: true,
                onChanged: (_) => _updateAddress(),
              ),
            ),
            const SizedBox(width: AppConstants.spacingMd),
            Expanded(
              child: CustomFormField(
                label: 'Country',
                hintText: 'Bangladesh',
                controller: _countryController,
                required: true,
                onChanged: (_) => _updateAddress(),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // Phone Number
        CustomFormField(
          label: 'Phone Number',
          hintText: '+88017xxxxxxxx',
          controller: _phoneNumberController,
          keyboardType: TextInputType.phone,
          required: true,
          onChanged: (_) => _updateAddress(),
        ),
      ],
    );
  }
}
