import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_test/data/constants/data.dart';

class BodyShopUi extends StatelessWidget {
  const BodyShopUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              Material(
                color: Colors.black.withOpacity(0.7),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Text(
                        'Los Santos Works',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: GoogleFonts.norican().fontFamily,
                        ),
                      ),
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 50,
                      height: 1,
                      thickness: 1,
                      color: Colors.white38,
                    ),
                    ListView.builder(
                      itemCount: LocalData.vehicalList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => InkWell(
                        hoverColor: Colors.green,
                        highlightColor: Colors.lightGreen,
                        child: Container(
                          height: 35,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            LocalData.vehicalList[index].toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: GoogleFonts.alata().fontFamily,
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 300,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  border: Border.all(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
