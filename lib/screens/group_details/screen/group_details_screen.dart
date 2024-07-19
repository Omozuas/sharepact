import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';
import 'package:sharepact_app/widgets/checklist_widget.dart';
import 'package:sharepact_app/widgets/group_member_widget.dart';
import 'package:sharepact_app/widgets/member_request_card.dart';

class GroupDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Netflix Family",
          style: GoogleFonts.lato(
            color: AppColors.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 343,
                  height: 178,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: ClipOval(
                      child: Container(
                        color: Colors.black,
                        child: Image.asset(
                          'assets/netflix.png',
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        AppImages.avatarImage5,
                        width: 32,
                        height: 32,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'JohnDoe1',
                        style: GoogleFonts.lato(
                          color: AppColors.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Creator',
                        style: GoogleFonts.lato(
                          color: AppColors.textColor01,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      SvgPicture.asset(AppImages.shareIcon),
                      Text(
                        'Share Group',
                        style: GoogleFonts.lato(
                          color: AppColors.textColor01,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Divider(),
              RichText(
                text: TextSpan(
                  text: 'Group Members : 5',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: " out of ",
                      style: GoogleFonts.lato(
                        color: AppColors.textColor,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: " of ",
                      style: GoogleFonts.lato(
                        color: AppColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const GroupMemberWidget(
                image: AppImages.avatarImage5,
                name: "JohnDoe1",
                isActive: true,
              ),
              const GroupMemberWidget(
                image: AppImages.avatarImage1,
                name: "JohnDoe1",
                isActive: false,
              ),
              const GroupMemberWidget(
                image: AppImages.avatarImage2,
                name: "JohnDoe1",
                isActive: false,
              ),
              const GroupMemberWidget(
                image: AppImages.avatarImage3,
                name: "JohnDoe1",
                isActive: true,
              ),
              const GroupMemberWidget(
                image: AppImages.avatarImage4,
                name: "JohnDoe1",
                isActive: true,
              ),
              const Divider(),
              Text(
                "Pending Requests : 4",
                style: GoogleFonts.lato(
                  color: AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const MemberRequestCard();
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mark Group as Ready',
                            style: GoogleFonts.lato(
                              color: AppColors.textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'This toggle can only be activated once every group member has made their payment',
                            style: GoogleFonts.lato(
                              color: AppColors.textColor02,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CupertinoSwitch(value: false, onChanged: (value) {})
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Subscription Details',
                style: GoogleFonts.lato(
                  color: AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.borderColor01,
                    ),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColors.lightBlue01,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          )),
                      child: RichText(
                        text: TextSpan(
                          text: 'Netflix Family Plan',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: " (Monthly)",
                              style: GoogleFonts.lato(
                                color: AppColors.textColor02,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const CheckListWidget(
                      text: "Ad-free music listening",
                    ),
                    const CheckListWidget(
                      text: "Offline playback",
                    ),
                    const CheckListWidget(
                      text:
                          "Access to over 70 million songs and 2.2 million podcasts",
                    ),
                    const CheckListWidget(
                      text:
                          "Six individual accounts for family members under one plan",
                    ),
                    const CheckListWidget(
                      text:
                          "Family Mix: Shared playlist based on everyone’s listening",
                    ),
                    const CheckListWidget(
                      text: "Spotify Kids: Special app for kids",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cost Breakdown',
                      style: GoogleFonts.lato(
                        color: AppColors.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '5,000 NGN',
                            style: GoogleFonts.lato(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "/month",
                                style: GoogleFonts.lato(
                                  color: AppColors.textColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Handling Fee',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '500 NGN',
                            style: GoogleFonts.lato(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "/month",
                                style: GoogleFonts.lato(
                                  color: AppColors.textColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Individual Share',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '1,000 NGN',
                            style: GoogleFonts.lato(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "/month",
                                style: GoogleFonts.lato(
                                  color: AppColors.textColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Payment Details',
                style: GoogleFonts.lato(
                  color: AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Next payment deadline',
                    style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "July 15, 2024",
                    style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount',
                    style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "1000 NGN",
                    style: GoogleFonts.lato(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Upcoming Payments',
                style: GoogleFonts.lato(
                  color: AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'August 15, 2024',
                    style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "1000 NGN",
                    style: GoogleFonts.lato(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'September 15, 2024',
                    style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "1000 NGN",
                    style: GoogleFonts.lato(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'October 15, 2024',
                    style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "1000 NGN",
                    style: GoogleFonts.lato(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
// SvgPicture.asset(AppImages.exitIcon),
 Text(
                    'Exit Group',
                    style: GoogleFonts.lato(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],),
            ],
          ),
        ),
      ),
    );
  }
}
