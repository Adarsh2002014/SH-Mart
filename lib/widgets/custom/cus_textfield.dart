import 'package:shmart/shmart.dart';

class CusTextfield extends StatefulWidget {

  final TextEditingController controller;
  final String? hintText;
  final bool? enable;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  const CusTextfield(
      {super.key,
      required this.controller,
      this.hintText,
      this.enable,
      this.prefixIcon,
      this.suffixIcon});

  @override
  State<CusTextfield> createState() => _CusTextfieldState();
}

class _CusTextfieldState extends State<CusTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        filled: true,
        hintText: widget.hintText ?? "",
        enabled: widget.enable ?? true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        border: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.transparent, width: 0)),
        enabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.transparent, width: 0)),
        focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.transparent, width: 0)),
        fillColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
