import 'package:get/get_navigation/get_navigation.dart';
import '../../modules/home/view/home_page.dart';
import '../../modules/todo/view/add_edit_todo_page.dart';

class RouteNames {
  static const String loginPage = "/login";
  static const String signupPage = "/signup";
  static const String homePage = "/home_page";
  static const String todoDetailPage = "/todo_detail";
  static const String addEditTodoPage = "/add_edit_todo";
}

final publicPages = [
  GetPage(name: '/', page: () => const HomePage()),
  GetPage(name: RouteNames.addEditTodoPage, page: () => const AddEditTodo()),
];

final authorizedPages = <GetPage<dynamic>>[
  // GetPage(name: RouteNames.homePage, page: () => const Welcome()),
];
