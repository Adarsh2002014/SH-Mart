import 'package:shmart/shmart.dart';

class QuickSearch extends StatefulWidget {
  const QuickSearch({super.key});

  @override
  State<QuickSearch> createState() => _QuickSearchState();
}

class _QuickSearchState extends State<QuickSearch> {
  late ThemeData theme;
  ProductController controller = Get.find();
  TextEditingController nameSearchController = TextEditingController();
  TextEditingController barcodeSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(quickSearch),
        centerTitle: true,
      ),
      body: Stack(children: [
        const QuickList(),
        SearchForm(
          nameSearchController: nameSearchController,
          barcodeSearchController: barcodeSearchController,
          onSearch: () {
            if (nameSearchController.text.isNotEmpty ||
                barcodeSearchController.text.isNotEmpty) {
              controller.getItems(
                  itemName: nameSearchController.text,
                  barcode: barcodeSearchController.text,
                  context: context);
            }
          },
          onScan: () async {
            try {
              barcodeSearchController.text =
                  await FlutterBarcodeScanner.scanBarcode(
                      mainSeedColor.toString(), cancel, false, ScanMode.BARCODE);
              if (barcodeSearchController.text.isNotEmpty) {
                controller.getItems(
                    itemName: nameSearchController.text,
                    barcode: barcodeSearchController.text,
                    context: context);
              }
            } catch (e) {
              print(e);
            }
          },
        ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.quickItem.clear();
  }
}
