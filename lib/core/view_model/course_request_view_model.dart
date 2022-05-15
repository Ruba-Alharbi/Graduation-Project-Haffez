import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haffez/core/service/firestore_course_request.dart';
import 'package:haffez/core/service/firestore_user.dart';
import 'package:haffez/model/course_request.dart';
import 'package:haffez/utils/enums/status.dart';
import 'package:haffez/utils/extenstion.dart';
import 'package:haffez/utils/user_profile.dart';
import 'package:haffez/view/widgets/custom_alert_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CourseRequestViewModel extends GetxController {
  String? uidCourse;
  List<CourseRequestModel> items = [];

  Future<void> joinRequestCourse({
    required String uidCourse,
    required String uidMotivator,
  }) async {
    Get.customLoader();

    CourseRequestModel object = CourseRequestModel(
      uid: "",
      uidTrainingCourse: uidCourse,
      uidOwner: UserProfile.shared.currentUser?.uid,
      status: Status.inReview,
      createdDate: DateTime.now().toString(),
      uidMotivator: uidMotivator,
    );

    try {
      await FirestoreCourseRequest.shared
          .addCourseRequest(courseRequest: object);
      Future.delayed(const Duration(), () {
        Get.back();
        Get.customSnackbar(
          title: "تم بنجاح",
          message: "تم طلب الإنضمام بنجاح",
        );
      });
    } catch (e) {
      Get.customSnackbar(
        title: "خطأ",
        message: e.toString(),
        isError: true,
      );
    } finally {
      Get.customLoader(isShowLoader: false);
    }
  }

  void getRequestTrainingCourseByStatus({
    required String uid,
  }) async {
    items.clear();

    var tempItems =
        await FirestoreCourseRequest.shared.getRequestTrainingCourse(uid: uid);

    tempItems.where((item) => item.status != Status.reject);

    for (var item in tempItems) {
      item.owner =
          await FirestoreUser.shared.getUserByUid(uid: item.uidOwner ?? "");
      items.add(item);
    }

    update();
  }

  void updateRequestStatus(
      {required CourseRequestModel requestCourse, required Status status}) {
    customAlertDialog(
      title: "تأكيد العملية",
      message: "هل أنت متأكد إتمام العملية؟",
      alertType: AlertType.warning,
      titleBtnOne: "أكيد",
      backgroundButtonOne: Colors.green,
      actionBtnOne: () async {
        FirestoreCourseRequest.shared
            .updateRequestStatus(uid: requestCourse.uid ?? "", status: status);


        Future.delayed(const Duration(milliseconds: 500), () {
          getRequestTrainingCourseByStatus(
            uid: uidCourse ?? "",
          );
        });

        Get.customSnackbar(
          title: "تم بنجاح",
          message: "تم بنجاح",
          isError: false,
        );
      },
      actionBtnTwo: () {},
    );
  }
}
