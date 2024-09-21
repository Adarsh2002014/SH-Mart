import 'package:shmart/shmart.dart';

const loginPage = "/login";
const homePage = "/home";

const quickSearchPage = "/quickSearchPage";
const storedSearchPage = "/storedSearchPage";
const requestBarcodePage = "/requestBarcode";
const oilPage = "/oil";
const milkOrderPage = "/milkOrder";
const orderListPage = "/orderList";
const expiryPage = "/expiry";
const generateOrderPage = "/generateOrder";
const goalTrackerPage = "/goalTracker";
const goalDetailPage = "/goalDetail";
const rackLabelPage = "/rackLabel";
const receivablesPage = "/receivables";

Map<String, Widget Function(BuildContext)> getRouteObject(
    BuildContext context) {
  return {
    loginPage: (context) => const Login(),
    homePage: (context) => const Home(),
    quickSearchPage: (context) => const QuickSearch(),
    milkOrderPage: (context) => const MilkOrder(),
  };
}
