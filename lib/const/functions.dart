import 'package:shmart/shmart.dart';

void showNonDismisableDialog(BuildContext context) {


  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(const Size.square(30)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: mainSeedColor,
                            )
                            // Lottie.asset(
                            //     "assets/lottie/loadingAnimation.json")
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Loading",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

double getScreenHeight({required BuildContext context,required double percent}){
  return MediaQuery.of(context).size.height * percent;
}

double getScreenWidth({required BuildContext context,required double percent}){
  return MediaQuery.of(context).size.width * percent;
}
