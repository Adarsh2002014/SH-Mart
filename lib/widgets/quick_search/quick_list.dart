import 'package:shmart/shmart.dart';

class QuickList extends StatefulWidget {
  const QuickList({super.key});

  @override
  State<QuickList> createState() => _QuickListState();
}

class _QuickListState extends State<QuickList> {
  late ThemeData theme;
  ProductController controller = Get.find();
  
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 300,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.65,
                ),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: theme.colorScheme.primary),
                child: Obx(
                  ()=> ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.storedItem.length,
                      itemBuilder: (context, index) {
                        return ItemBox(name: controller.storedItem[index].name, priceSale: controller.storedItem[index].priceSale.toString(), priceMrp: controller.storedItem[index].priceMrp.toString(), stockAvailable: controller.storedItem[index].stockAvailable.toString());
                      }),
                ),

              ),
            ],
          ),
        );
  }
}