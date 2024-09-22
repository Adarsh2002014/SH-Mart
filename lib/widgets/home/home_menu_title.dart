import 'package:shmart/shmart.dart';

class HomeMenuTitle extends StatefulWidget {

  final String title;
  const HomeMenuTitle({super.key, required this.title});

  @override
  State<HomeMenuTitle> createState() => _HomeMenuTitleState();
}

class _HomeMenuTitleState extends State<HomeMenuTitle> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
      child: Text(
        widget.title,
        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
