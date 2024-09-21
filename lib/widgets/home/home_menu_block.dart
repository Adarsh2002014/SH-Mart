import 'package:shmart/shmart.dart';

class HomeMenuBlock extends StatefulWidget {

  final Menu menu;
  const HomeMenuBlock({super.key, required this.menu});

  @override
  State<HomeMenuBlock> createState() => _HomeMenuBlockState();
}

class _HomeMenuBlockState extends State<HomeMenuBlock> {
  late ThemeData theme;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          if(widget.menu.menuRoute != null && widget.menu.menuRoute != ""){
            Navigator.pushNamed(context,widget.menu.menuRoute!);
          }
        },
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(widget.menu.menuIcon, color: theme.colorScheme.primary,),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.menu.menuTitle!,
                    style: theme.textTheme.labelLarge,
                  ),
                ])),
      ),
    );
  }
}
