import 'package:flutter/material.dart';
import 'package:shmart/const/_const.dart';

class QuickNeedList extends StatefulWidget {
  const QuickNeedList({super.key});


  @override
  State<QuickNeedList> createState() => _QuickNeedListState();
}

class _QuickNeedListState extends State<QuickNeedList> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: getScreenHeight(context: context, percent: 0.33),
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text("Here goes title"),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text(add),
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "$index. This works..",
                                  style: theme.textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w300),
                                  softWrap: true,
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0, right: 10.0, bottom: 5.0),
                                  child: InkWell(
                                      onTap: () {},
                                      child: const Icon(Icons.delete)),
                                ),
                              ],
                            ),
                            const Divider()
                          ],
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
