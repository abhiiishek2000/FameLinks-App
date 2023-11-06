import 'package:famelink/ui/joblinks/createjob/widget/behindjob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../util/config/color.dart';
import '../models/joblinkfeedmodel.dart';
import 'provider/jobcreateprovider.dart';
import 'provider/professionpro.dart';
import 'widget/frontjobs.dart';

class CreateJob extends StatefulWidget {
  CreateJob({this.alldata, this.allmap});

  final YourJobsModel? alldata;
  final Map? allmap;

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  Professionpro? jobCreateprovider;

  String? fid;
  String? bid;

  @override
  void initState() {
    final jobCreate = Provider.of<JobCreateprovider>(context, listen: false);
    jobCreate.clearData();
    final prof = Provider.of<Professionpro>(context, listen: false);
    prof.categorySelected.clear();
    if (widget.alldata != null) {
      var data = widget.alldata;
      if (widget.alldata!.jobType == "faces") {
        fid = data!.id;
        jobCreate.index = 0;
        jobCreate.facetitleController.text = data.title.toString();
        jobCreate.facedescriptionController.text = data.description.toString();
        DateTime startDate = DateTime.parse(data.startDate!);
        DateTime endDate = DateTime.parse(data.endDate!);
        jobCreate.facesstartController.text =
            DateFormat('dd-MM-yyyy').format(startDate);
        jobCreate.facesendController.text =
            DateFormat('dd-MM-yyyy').format(endDate);
        jobCreate.facesdeadlineController.text =
            DateFormat('dd-MM-yyyy').format(DateTime.parse(data.deadline!));
        jobCreate.facestotalController.text =
            endDate.difference(startDate).inDays.toString();
        jobCreate.famelocationController.text =
            "${data.jobLocation!.district}, ${data.jobLocation!.state}, ${data.jobLocation!.country}";
        // jobCreate.ftController.text = data!.height!.foot.toString();
        jobCreate.sFoot = data.height!.foot.toString();
        jobCreate.sInch = data.height!.inch.toString();
        // jobCreate.inController.text = data!.height!.inch.toString();
        jobCreate.genderIndex = data.gender == "male" ? 0 : 1;

        //     jobCreate.changeage(jobCreate.ageGroup1[0][data.ageGroup].toString());

        data.jobDetails!.forEach((element) {
          prof.categorySelected.add(element['_id']);
        });
        jobCreate.ageSelected =
            jobCreate.ageGroup1[0][data.ageGroup].toString();
        print(" facecotg ${jobCreate.categorySelected}");
      } else {
        bid = data!.id;
        jobCreate.index = 1;
        jobCreate.titleController.text = data.title.toString();
        jobCreate.locationController.text =
            "${data.jobLocation!.district}, ${data.jobLocation!.state}, ${data.jobLocation!.country}";
        jobCreate.descriptionController.text = data.description.toString();
        jobCreate.experienceIndex =
            data.experienceLevel == "experienced" ? 1 : 0;
        DateTime startDate = DateTime.parse(data.startDate!);
        DateTime endDate = DateTime.parse(data.endDate!);
        jobCreate.startController.text =
            DateFormat('dd-MM-yyyy').format(startDate);
        jobCreate.endController.text = DateFormat('dd-MM-yyyy').format(endDate);
        jobCreate.deadlineController.text =
            DateFormat('dd-MM-yyyy').format(DateTime.parse(data.deadline!));
        jobCreate.totalController.text =
            endDate.difference(startDate).inDays.toString();
        data.jobDetails!.forEach((element) {
          prof.categorySelected.add(element['_id']);
        });
      }

      print(data.id);
    } else if (widget.allmap != null) {
      if (widget.allmap!['jobType'] == "faces") {
        jobCreate.index = 0;
        jobCreate.facetitleController.text = widget.allmap!['title'].toString();
        jobCreate.facedescriptionController.text =
            widget.allmap!['description'].toString();
        jobCreate.famelocationController.text =
            widget.allmap!['jobLocation'].toString();
      } else if (widget.allmap!['jobType'] == "crew") {
        jobCreate.index = 1;
        jobCreate.titleController.text = widget.allmap!['title'].toString();
        jobCreate.locationController.text =
            widget.allmap!['jobLocation'].toString();
        jobCreate.descriptionController.text = widget.allmap!['description'];
        jobCreate.experienceIndex =
            widget.allmap!['experienceLevel'] == "experienced" ? 1 : 0;
      }
    }
    jobCreateprovider = Provider.of<Professionpro>(context, listen: false);
    super.initState();
    jobCreateprovider!.getCategories();
  }

  // Future<List<AddressLocation>?>

  //
  // Future<List<JobCategories>>

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<JobCreateprovider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(16),
                      top: ScreenUtil().setHeight(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: black,
                            size: ScreenUtil().radius(20),
                          )),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "Create ",
                                style: GoogleFonts.roboto(
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    height: 0.25,
                                    color: black),
                              ),
                              TextSpan(
                                text: "Job",
                                style: GoogleFonts.roboto(
                                  fontSize: ScreenUtil().setSp(18),
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  height: 0.25,
                                  color: orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_back_ios_rounded,
                        color: white,
                        size: ScreenUtil().radius(20),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(40),
                      right: ScreenUtil().setWidth(16),
                      top: ScreenUtil().setHeight(25)),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (provider.index == 1) {
                            setState(() {
                              provider.index = 0;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              provider.index == 0
                                  ? "assets/icons/selectedRadio.png"
                                  : "assets/icons/radioCircle.png",
                              height: ScreenUtil().setHeight(14),
                              width: ScreenUtil().setWidth(14),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(7.5),
                                  left: ScreenUtil().setWidth(6)),
                              child: Text(
                                "Front Faces",
                                style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: provider.index == 0
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  height: 0.16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          if (provider.index == 0) {
                            setState(() {
                              provider.index = 1;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              provider.index == 1
                                  ? "assets/icons/selectedRadio.png"
                                  : "assets/icons/radioCircle.png",
                              height: ScreenUtil().setHeight(14),
                              width: ScreenUtil().setWidth(14),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(7.5),
                                  left: ScreenUtil().setWidth(6)),
                              child: Text(
                                "Behind the Scenes",
                                style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: provider.index == 1
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  height: 0.16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                provider.index == 1
                    ? BehindJob(
                        id: bid,
                      )
                    : FrontJob(
                        id: fid,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
