part of 'package:lnwCoin/view/trade/trade_view.dart';


class AppBarWithStar extends StatefulWidget {
  final String symbol;
  final String id;
  const AppBarWithStar({super.key, required this.symbol, required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _AppBarWithStarState createState() => _AppBarWithStarState();
}

class _AppBarWithStarState extends State<AppBarWithStar> {
  late bool _isStarred;

  @override
  void initState() {
    super.initState();
    _isStarred = watchListProvider().watchlist.contains(widget.id);
    print(_isStarred);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          Text(
            widget.symbol.toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _isStarred = !_isStarred;
                if(_isStarred){
                  watchListProvider().watchlist.add(widget.id);
                  print(watchListProvider().watchlist);
                } else {
                  watchListProvider().watchlist.remove(widget.id);
                  print(watchListProvider().watchlist);
                }
              });
            },
            child: Icon(
              _isStarred ? Iconsax.star1 : Iconsax.star,
              color: _isStarred ? Colors.orange : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}