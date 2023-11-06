import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../../models/LocationResponse.dart';

import '../../../../networking/config.dart';
import '../../../../util/config/color.dart';
import '../../hiringprofile/provider/hiring_profile_provider.dart';
import '../../hiringprofile/provider/locationprovider.dart';

class SearchLocationjob extends StatelessWidget {
  SearchLocationjob({
    super.key,
    required this.locationcon,
  });

  final TextEditingController locationcon;

  @override
  Widget build(BuildContext context) {
    return Consumer<Locationpro>(
      builder: (context, locationpro, child) {
        final pro = Provider.of<HiringProfileProvider>(context, listen: false);

        return Column(
          //overflow: Overflow.visible,
          children: <Widget>[
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: locationpro.getLocationList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            debugPrint(
                                "123-123-123-123-123-123 Location 123-123-123-123-");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(
                              right: 30.0,
                              left: 5.0,
                            ),
                            width: ScreenUtil().screenWidth,
                            child: InkWell(
                              onTap: () {
                                print("===========");
                                locationpro.changeLocationDistrict(locationpro
                                    .getLocationList[index].district
                                    .toString());
                                locationpro.changeLocationState(locationpro
                                    .getLocationList[index].state
                                    .toString());
                                locationpro.changeLocationCountry(locationpro
                                    .getLocationList[index].country
                                    .toString());
                                Map lo = {
                                  "district": locationpro
                                      .getLocationList[index].district,
                                  "state":
                                      locationpro.getLocationList[index].state,
                                  "country": locationpro
                                      .getLocationList[index].country,
                                };

                                locationcon.text =
                                    '${locationpro.getLocationList[index].district},${locationpro.getLocationList[index].state},${locationpro.getLocationList[index].country}';

                                locationpro.placeController.clear();

                                locationpro.changeIsShowDropDown(false);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${locationpro.getLocationList[index].district},${locationpro.getLocationList[index].state},${locationpro.getLocationList[index].country}'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: TextFormField(
                controller: locationcon,
                style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(14),
                    color: black,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  suffixIcon: Image.asset("assets/icons/search.png",
                      color: Color(0xff9B9B9B)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor("#9B9B9B"),
                        width: ScreenUtil().radius(1)),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().radius(5))),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor("#9B9B9B"),
                        width: ScreenUtil().radius(1)),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().radius(5))),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor("#9B9B9B"),
                        width: ScreenUtil().radius(1)),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().radius(5))),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red, width: ScreenUtil().radius(1)),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().radius(5))),
                  ),
                  contentPadding:
                      EdgeInsets.only(left: ScreenUtil().setWidth(13.73)),
                  hintText: 'Interested Location',
                  hintStyle: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(14),
                      color: lightGray,
                      fontWeight: FontWeight.w400),
                ),
                onChanged: (value) {
                  if (value.toString().isNotEmpty &&
                      value.toString().trim().length != 0 &&
                      value.toString().isNotEmpty) {
                    locationpro.changeIsShowDropDown(true);
                    List<AddressLocation> locationList = <AddressLocation>[];
                    locationpro.changeLocationList(locationList);
                    locationpro.getLocation(value.toString());
                  } else {
                    locationpro.changeIsShowDropDown(false);
                  }
                },
              ),
            ),
            // Column(
            //   children: type == "crew"
            //       ? pro.locationlist.map((e) {
            //           return Text(
            //               "${e["district"]},${e["state"]},${e["country"]}");
            //         }).toList()
            //       : pro.locationlistface.map((e) {
            //           return Text(
            //               "${e["district"]},${e["state"]},${e["country"]}");
            //         }).toList(),
            // )
          ],
        );
      },
    );
  }

  show(BuildContext context, Locationpro locationpro) {
    showDialog(
      context: context,
      builder: (context) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Title of Dialog"),
              content: Text(contentText),
              actions: <Widget>[],
            );
          },
        );
      },
    );
  }
}
