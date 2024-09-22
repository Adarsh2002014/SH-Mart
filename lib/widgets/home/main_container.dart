import 'package:flutter/material.dart';
import 'package:shmart/const/_const.dart';

class MainContainer extends StatefulWidget {

  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container1(
              title: "Quick Search",
              icon: Icons.search_rounded,
              route: quickSearchPage),
          SizedBox(
            width: 10,
          ),
          Container1(
              title: "Stored Search",
              icon: Icons.storefront_rounded,
              route: storedSearchPage),
        ],
      ),
    );
  }
}

class Container1 extends StatefulWidget {
  final String title;
  final IconData icon;
  final String route;
  const Container1(
      {super.key,
      required this.title,
      required this.icon,
      required this.route});

  @override
  State<Container1> createState() => Container1State();
}

class Container1State extends State<Container1> {
  late ThemeData theme;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, widget.route);
        },
        child: SizedBox(
            child: Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: mainSeedColor,
                ),
                width: getScreenWidth(context: context, percent: 0.3),
                height: 183,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.onPrimary,
              ),
              width: 200,
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    size: 70,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        widget.title,
                        softWrap: true,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
