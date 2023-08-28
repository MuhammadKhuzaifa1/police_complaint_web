import 'package:police_complaint_web/controllers/signup_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'signin_controller.dart';

List<SingleChildWidget> providersController = [
  ChangeNotifierProvider.value(value: SignInController()),
  ChangeNotifierProvider.value(value: SignupController()),
];