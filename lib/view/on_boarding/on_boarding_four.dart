import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haffez/view/widgets/custom_text.dart';

class OnBoardingFour extends StatelessWidget {
  const OnBoardingFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CustomText(
                text:
                    " طيب أنت أخذت الكورس   \n \n ودك بطريقة تنظم فيها نفسك؟ ",
                textColor: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
          const CustomText(
            text: " أبشر ",
            fontSize: 60,
            textColor: Color(
                0xFFE6F1F3), 
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 50.h,
          ),
          CustomText(
            text: "وفرنا لك جدول أنبسط يا بطل",
            textColor: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}