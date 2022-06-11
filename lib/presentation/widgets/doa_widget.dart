import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/model/doa_data.dart';

class DoaWidget extends StatelessWidget {
  const DoaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final Doa doa = doaData[index];
          return InkWell(
            onTap: () {},
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 4, right: 8, bottom: 4, left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            doa.title,
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(flex: 1, child: FavoriteButton()),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: doaData.length,
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.bookmark : Icons.bookmark_border,
        color: kSecondary,
        size: 32.0,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
