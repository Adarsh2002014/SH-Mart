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
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              Container(
                height: 700,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: theme.colorScheme.primary),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.item.length,
                    itemBuilder: (context, index) {
                      return Container();
                    }),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              // color: theme.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CusTextfield(
                  controller: nameSearchController,
                  hintText: enterItemName,
                  suffixIcon: IconButton(
                      onPressed: () => nameSearchController.clear(),
                      icon: const Icon(Icons.close_rounded)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CusTextfield(
                  controller: barcodeSearchController,
                  hintText: enterItemBarcode,
                  suffixIcon: IconButton(
                      onPressed: () => barcodeSearchController.clear(),
                      icon: const Icon(Icons.close_rounded)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text(search),
                    icon: const Icon(Icons.search_rounded),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text(scan),
                    icon: const Icon(Icons.scanner_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
