import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeedLoadingView extends StatelessWidget {
  const FeedLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    const _shimmerGradient = LinearGradient(
      colors: [
        Color(0xFF1E2331),
        Color(0xFF1E2331),
        Colors.grey
      ],
      stops: [
        0.1,
        0.3,
        0.4,
      ],
      begin: Alignment(-1.0, -0.5),
      end: Alignment(1.0, 0.5),
      tileMode: TileMode.repeated,
    );
    return SafeArea(
      child: Shimmer(
        child: Container(
          height: h,
          width: w,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),

                    ),
                  )
                ],),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: h * 0.15,
                          width: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      height: 24,
                      width: w,

                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      height: 24,
                      width: w,

                    )
                  ],
                )
              ],
            ),
          ),
        ),
        gradient: _shimmerGradient,
      ),
    );
  }
}
