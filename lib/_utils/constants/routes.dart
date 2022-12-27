import 'package:get/get_navigation/get_navigation.dart';
import '../../modules/home/view/home_page.dart';
import '../../modules/loggy_demo/loggy_counter.dart';
import '../../modules/todo/view/add_edit_todo_page.dart';

class RouteNames {
  static const String loginPage = "/login";
  static const String signupPage = "/signup";
  static const String homePage = "/home_page";
  static const String todoDetailPage = "/todo_detail";
  static const String addEditTodoPage = "/add_edit_todo";
  static const String loggyCounterExample = "/loggy_counter_example";
}

final publicPages = [
  GetPage(name: '/', page: () => const LoggyCounterExample()),
  GetPage(name: RouteNames.addEditTodoPage, page: () => const AddEditTodo()),
  GetPage(
      name: RouteNames.loggyCounterExample,
      page: () => const LoggyCounterExample()),
];

final authorizedPages = <GetPage<dynamic>>[
  // GetPage(name: RouteNames.homePage, page: () => const Welcome()),
];
