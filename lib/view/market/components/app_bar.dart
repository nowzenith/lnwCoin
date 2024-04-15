part of 'package:lnwCoin/view/market/market_view.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min, // Ensures the content is centered
        children: [
          Image.asset(
            "assets/icon/960x960.png", // Path to your logo image
            height: 30.0, // Set an appropriate height for the logo
          ),
          SizedBox(width: 8), // Provides spacing between logo and text
          GradientText(
            "lnwCoin",
            colors: const [
              Colors.white,
              Color.fromARGB(255, 212, 57, 83),
              Color.fromARGB(255, 170, 0, 28),
            ],
            style: const TextStyle(fontSize: 26),
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
