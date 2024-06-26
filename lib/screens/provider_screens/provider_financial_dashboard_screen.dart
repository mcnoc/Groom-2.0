
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class ProviderFinancialDashboard extends StatefulWidget {
  const ProviderFinancialDashboard({super.key});

  @override
  State<ProviderFinancialDashboard> createState() =>
      _ProviderFinancialDashboardState();
}

class _ProviderFinancialDashboardState
    extends State<ProviderFinancialDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Financial Dashboard",
          style: GoogleFonts.workSans(
              color: mainBtnColor, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/c2.png",
              height: 300,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/d.png",
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "\$6.564,34",
                        style: GoogleFonts.inter(
                            color: Color(0xff1F2C35), fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Income",
                        style: GoogleFonts.inter(
                            color: Color(0xff1F2C35), fontSize: 16),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Color(0xffE3E9ED))),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 120,
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/b2.png",
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "\$4.764,35",
                        style: GoogleFonts.inter(
                            color: Color(0xff1F2C35), fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Withdraw",
                        style: GoogleFonts.inter(
                            color: Color(0xff1F2C35), fontSize: 16),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Color(0xffE3E9ED))),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Recent transaction",
              style: GoogleFonts.inter(
                  color: Color(0xff1F2C35),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 190,
            child: ListView.builder(itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/girl.png"),
                ),
                title: Text(
                  "Tiana Saris",
                  style: GoogleFonts.inter(
                      color: Color(0xff1F2C35),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  "BCA • 2468 3545 ****",
                  style: GoogleFonts.inter(
                      color: Color(0xff9CA4AB),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                trailing: Text(
                  "\$433,00",
                  style: GoogleFonts.inter(
                      color: Color(0xff9CA4AB),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
