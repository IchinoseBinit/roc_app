import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/constants/constants.dart';
import 'package:roc_app/models/educational_resources.dart';
import 'package:roc_app/screens/forms/add_educational_resources_screen.dart';
import 'package:roc_app/screens/resource_details_screen.dart';
import 'package:roc_app/utils/firebase_helper.dart';
import 'package:roc_app/utils/navigate.dart';
import 'package:roc_app/utils/util.dart';
import 'package:roc_app/widgets/general_elevated_button.dart';
import '/widgets/body_template.dart';
import '/widgets/header_template.dart';

class EducationalResourcesScreen extends StatelessWidget {
  const EducationalResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isAdmin(context)
          ? Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
              ),
              child: GeneralElevatedButton(
                onPressed: () =>
                    navigate(context, AddEducationalResourcesScreen()),
                title: "Add Educational Resources",
                marginH: 16,
              ),
            )
          : null,
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            children: [
              HeaderTemplate(
                headerText: "Educational Resources",
                needBackButton: false,
                fontSize: 24.sp,
              ),
              SizedBox(
                height: 24.h,
              ),
              StreamBuilder(
                  stream: FirebaseHelper().getStream(
                      collectionId: EducationalResourceConstant.resource),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    if (snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      final resourceList = snapshot.data!.docs
                          .map((e) =>
                              EducationalResource.fromMap(e.data(), e.id))
                          .toList();
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          mainAxisSpacing: 32.h,
                          mainAxisExtent: 200.h,
                          crossAxisSpacing: 16.w,
                        ),
                        itemCount: resourceList.length,
                        itemBuilder: (_, index) => Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0XFF4A9DBF).withOpacity(.5),
                              width: 4,
                            ),
                            color: const Color(0XFFF9EDD7),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                resourceList[index].title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: const Color(0XFF34809F),
                                    ),
                              ),
                              Flexible(
                                child: Text(
                                  resourceList[index].description,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.justify,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () => navigate(
                                    context,
                                    EducationalResourceDetailsScreen(
                                      resource: resourceList[index],
                                    ),
                                  ),
                                  child: const Text(
                                    "Read More >",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        shrinkWrap: true,
                        primary: false,
                      );
                    }
                    return const Text("No Educational Resources available");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
