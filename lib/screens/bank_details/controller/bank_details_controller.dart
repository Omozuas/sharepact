import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BankDetailsController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController accountNumberController =
      TextEditingController();

  bool bankDetails = false;
  bool get showBankDetails => bankDetails;
  set showBankDetails(value) {
    bankDetails = value;
    notifyListeners();
  }
}


final bankDetailsProvider = ChangeNotifierProvider<BankDetailsController>((ref)=> BankDetailsController());