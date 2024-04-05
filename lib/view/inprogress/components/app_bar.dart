part of 'package:lnwCoin/view/inprogress/Future.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: GradientText(
        "lnwCoin",
        colors: [
          Colors.white,
          Colors.greenAccent,
          Colors.green.shade400,
        ],
        style: const TextStyle(fontSize: 26),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
