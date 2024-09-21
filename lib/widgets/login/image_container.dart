import 'package:shmart/shmart.dart';

class ImageContainer extends StatefulWidget {


  const ImageContainer({super.key});

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xffFFF1D7),
      color: const Color(0xffff7a40),
      height: 360,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: FadeInUp(
                child: Center(
              child: Stack(
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Color(0xfffffbf0),
                      borderRadius: BorderRadius.all(Radius.circular(120.0)),
                    ),
                  ),
                  // Positioned(
                  //   top: 0, // Adjust for vertical centering (modify if needed)
                  //   left:
                  //       5, // Adjust for horizontal centering (modify if needed)
                  //   right: 0,
                  //   bottom: 0,
                  //   child: Image.asset(
                  //     'assets/login-logo.png',
                  //     fit: BoxFit
                  //         .cover, // Maintains aspect ratio, covering container
                  //   ),
                  // ),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
