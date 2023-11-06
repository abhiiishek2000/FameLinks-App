import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../util/config/color.dart';
import '../createjob/provider/jobcreateprovider.dart';
import '../createjob/provider/professionpro.dart';

class Profassion extends StatelessWidget {
  const Profassion({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(15),
          left: ScreenUtil().setWidth(17),
          right: ScreenUtil().setWidth(17)),
      child: Consumer<Professionpro>(
        builder: (context, profession, child) {
          return Column(
            children: [
              TextField(
                onChanged: (val) {
                  Future.delayed(Duration(milliseconds: 300), () {
                    profession.searchCategories(val, "crew");
                  });
                },
                onSubmitted: (_) {},
                //  controller: professionController,
                maxLines: 1,
                keyboardType: TextInputType.multiline,
                cursorColor: black,
                style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Color(0xff9B9B9B)),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                  hintText: 'Search Profession',
                  hintStyle: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(14),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff9B9B9B)),
                  suffixIcon: Image.asset("assets/icons/search.png",
                      color: Color(0xff9B9B9B)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: lightRed, width: 1)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(14)),
                child: Container(
                  // height: 260.h,
                  padding: EdgeInsets.only(right: 3.w),
                  child: GridView.builder(
                    padding: EdgeInsets.all(3.0),
                    primary: false,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 4.r,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: profession.categorybehind!.length,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: () {
                          if (profession.categorySelected.contains(profession.categorybehind![index].sId)) {
                            profession.categorybehind![index].isSelected = false;
                            profession.categorySelected.remove(profession.categorybehind![index].sId);
                          } else {
                            profession.categorySelected.clear();
                            profession.categorybehind![index].isSelected = true;
                            profession.categorySelected.add(profession.categorybehind![index].sId);
                          }
                          final pro = Provider.of<JobCreateprovider>(context, listen: false);
                          if (type == "crew") {
                            pro.categorySelected = profession.categorySelected;
                          } else {
                            pro.facesCategorySelected = profession.categorySelected;
                          }
                          profession.selectcategory(index);
                        },
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(15)),
                            border: Border.all(color: black),
                            color: profession.categorySelected.contains(
                                    profession.categorybehind![index].sId)
                                ? Color(0xff4B4E58)
                                : Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              profession.categorybehind![index].jobName!,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: profession.categorySelected.contains(
                                          profession.categorybehind![index].sId)
                                      ? white
                                      : black),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
