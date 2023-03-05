import 'package:get/get.dart';

import '../modules/activity_log/bindings/activity_log_binding.dart';
import '../modules/activity_log/views/activity_log_view.dart';
import '../modules/add_cashier/bindings/add_cashier_binding.dart';
import '../modules/add_cashier/views/add_cashier_view.dart';
import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/admin_home/bindings/home_binding.dart';
import '../modules/admin_home/views/home_view.dart';
import '../modules/cashier_details/bindings/cashier_details_binding.dart';
import '../modules/cashier_details/views/cashier_details_view.dart';
import '../modules/cashier_home/bindings/cashier_home_binding.dart';
import '../modules/cashier_home/views/cashier_home_view.dart';
import '../modules/cashier_logs/bindings/cashier_logs_binding.dart';
import '../modules/cashier_logs/views/cashier_logs_view.dart';
import '../modules/cashier_transaction/bindings/cashier_transaction_binding.dart';
import '../modules/cashier_transaction/views/cashier_transaction_view.dart';
import '../modules/cashiers/bindings/cashiers_binding.dart';
import '../modules/cashiers/views/cashiers_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/owner_home/bindings/owner_home_binding.dart';
import '../modules/owner_home/views/owner_home_view.dart';
import '../modules/pick_order/bindings/pick_order_binding.dart';
import '../modules/pick_order/views/pick_order_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/views/products_view.dart';
import '../modules/products_detail/bindings/products_detail_binding.dart';
import '../modules/products_detail/views/products_detail_view.dart';
import '../modules/trans_log/bindings/trans_log_binding.dart';
import '../modules/trans_log/views/trans_log_view.dart';
import '../modules/trans_log_details/bindings/trans_log_details_binding.dart';
import '../modules/trans_log_details/views/trans_log_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.products,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.add_product,
      page: () => AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.products_detail,
      page: () => ProductsDetail(),
      binding: ProductsDetailBinding(),
    ),
    GetPage(
      name: _Paths.cashier_home,
      page: () => CashierHomeView(),
      binding: CashierHomeBinding(),
    ),
    GetPage(
      name: _Paths.owner_home,
      page: () => OwnerHomeView(),
      binding: OwnerHomeBinding(),
    ),
    GetPage(
      name: _Paths.add_cashier,
      page: () => AddCashierView(),
      binding: AddCashierBinding(),
    ),
    GetPage(
      name: _Paths.cashiers,
      page: () => CashiersView(),
      binding: CashiersBinding(),
    ),
    GetPage(
      name: _Paths.activity_log,
      page: () => ActivityLogView(),
      binding: ActivityLogBinding(),
    ),
    GetPage(
      name: _Paths.cashier_details,
      page: () => CashierDetailsView(),
      binding: CashierDetailsBinding(),
    ),
    GetPage(
      name: _Paths.cashier_transaction,
      page: () => CashierTransactionView(),
      binding: CashierTransactionBinding(),
    ),
    GetPage(
      name: _Paths.pick_order,
      page: () => const PickOrderView(),
      binding: PickOrderBinding(),
    ),
    GetPage(
      name: _Paths.trans_log,
      page: () => TransLogView(),
      binding: TransLogBinding(),
    ),
    GetPage(
      name: _Paths.cashier_logs,
      page: () => CashierLogsView(),
      binding: CashierLogsBinding(),
    ),
    GetPage(
      name: _Paths.trans_log_details,
      page: () => TransLogDetailsView(),
      binding: TransLogDetailsBinding(),
    ),
  ];
}
