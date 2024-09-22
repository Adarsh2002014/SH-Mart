import 'package:shmart/shmart.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          applicationName,
          style: theme.textTheme.displayMedium
              ?.copyWith(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      // backgroundColor: theme.colorScheme.primaryContainer,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: getColumnList(),
        ),
      ),
    );
  }

  List<Widget> getColumnList() {
    bool isAdmin = true;
    List<Widget> columnWidgetList = [];
    columnWidgetList.add(const SizedBox(
      height: 20,
    ));
    columnWidgetList.add(const MainContainer());
    columnWidgetList.add(const SizedBox(
      height: 20,
    ));
    columnWidgetList.add(const QuickNeedList());
    columnWidgetList.add(const SizedBox(
      height: 15,
    ));
    columnWidgetList.add(const HomeMenuTitle(title: labels));
    columnWidgetList.add(const SizedBox(
      height: 5,
    ));
    columnWidgetList.add(HomeMenuBlock(
      menu: Menu(
          menuTitle: barcodeList,
          menuIcon: Icons.barcode_reader,
          menuRoute: requestBarcodePage),
    ));
    columnWidgetList.add(const SizedBox(
      height: 12,
    ));
    columnWidgetList.add(HomeMenuBlock(
        menu: Menu(
            menuTitle: racklabelList,
            menuIcon: Icons.video_label_rounded,
            menuRoute: rackLabelPage)));
    columnWidgetList.add(const SizedBox(
      height: 20,
    ));

    if (isAdmin) {
      columnWidgetList.add(const HomeMenuTitle(title: placeOrder));
      columnWidgetList.add(const SizedBox(
        height: 5,
      ));
      columnWidgetList.add(HomeMenuBlock(
        menu: Menu(
            menuTitle: oilList,
            menuIcon: Icons.oil_barrel_rounded,
            menuRoute: oilPage),
      ));
      columnWidgetList.add(const SizedBox(
        height: 12,
      ));
      columnWidgetList.add(HomeMenuBlock(
        menu: Menu(
            menuTitle: orderList,
            menuIcon: Icons.list_alt_rounded,
            menuRoute: orderListPage),
      ));
      columnWidgetList.add(const SizedBox(
        height: 12,
      ));
      columnWidgetList.add(HomeMenuBlock(
          menu: Menu(
              menuTitle: dailyDairyOrder,
              menuIcon: Icons.water_drop_rounded,
              menuRoute: milkOrderPage)));
      columnWidgetList.add(const SizedBox(
        height: 20,
      ));
      columnWidgetList.add(const HomeMenuTitle(title: other));
      columnWidgetList.add(const SizedBox(
        height: 5,
      ));
      columnWidgetList.add(HomeMenuBlock(
        menu: Menu(
            menuTitle: goalTracker,
            menuIcon: Icons.track_changes_rounded,
            menuRoute: goalTrackerPage),
      ));
      columnWidgetList.add(const SizedBox(
        height: 12,
      ));
      columnWidgetList.add(HomeMenuBlock(
          menu: Menu(
              menuTitle: expiredItem,
              menuIcon: Icons.date_range_rounded,
              menuRoute: expiryPage)));
      columnWidgetList.add(const SizedBox(
        height: 12,
      ));
      columnWidgetList.add(HomeMenuBlock(
        menu: Menu(
            menuTitle: receivables,
            menuIcon: Icons.currency_rupee_rounded,
            menuRoute: receivablesPage),
      ));
      columnWidgetList.add(const SizedBox(
        height: 12,
      ));
      columnWidgetList.add(HomeMenuBlock(
        menu: Menu(
            menuTitle: settings,
            menuIcon: Icons.settings_rounded,
            menuRoute: receivablesPage),
      ));
      columnWidgetList.add(const SizedBox(
        height: 20,
      ));
    }
    return columnWidgetList;
  }
}
