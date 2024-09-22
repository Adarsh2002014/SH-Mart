import 'package:shmart/shmart.dart';

class SearchForm extends StatefulWidget {
  final TextEditingController nameSearchController;
  final TextEditingController barcodeSearchController;
  final Function() onSearch;
  final Function() onScan;
  const SearchForm({super.key, required this.nameSearchController, required this.barcodeSearchController, required this.onSearch, required this.onScan});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
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
                  controller: widget.nameSearchController,
                  hintText: enterItemName,
                  suffixIcon: IconButton(
                      onPressed: () => widget.nameSearchController.clear(),
                      icon: const Icon(Icons.close_rounded)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CusTextfield(
                  controller: widget.barcodeSearchController,
                  hintText: enterItemBarcode,
                  suffixIcon: IconButton(
                      onPressed: () => widget.barcodeSearchController.clear(),
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
                    onPressed: () => widget.onSearch(),
                    label: const Text(search),
                    icon: const Icon(Icons.search_rounded),

                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () => widget.onScan(),
                    label: const Text(scan),
                    icon: const Icon(Icons.scanner_rounded),

                  ),
                ],
              ),
            ],
          ),
        );
  }
}