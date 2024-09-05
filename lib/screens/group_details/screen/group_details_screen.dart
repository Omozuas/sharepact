import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/api/riverPod/getjoinRequest.dart';
import 'package:sharepact_app/api/riverPod/groupDetailsProvider.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/screens/home/controllerNav.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';
import 'package:sharepact_app/widgets/group_member_widget.dart';
import 'package:sharepact_app/widgets/member_request_card.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class GroupDetailsScreen extends ConsumerStatefulWidget {
  const GroupDetailsScreen({super.key, this.id});
  final String? id;
  @override
  ConsumerState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends ConsumerState<GroupDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => getGroupDetails());
  }

  Future<void> getGroupDetails() async {
    await ref
        .read(groupdetailsprovider.notifier)
        .getGroupDetailsById(id: '66d6da40712d196a6a915636');
    await ref
        .read(groupJoinRequestprovider.notifier)
        .getGroupJoinRequestById(id: '66d6da40712d196a6a915636');
    // final res = ref.watch(groupdetailsprovider).value;
    // print(res?.data?.joinRequests?[0]);
  }

  Future<void> _leaveGroup({required String roomId}) async {
    try {
      await ref.read(profileProvider.notifier).leaveGroup(roomId: roomId);

      final pUpdater = ref.read(profileProvider).leaveGroup;
      // Navigate to home screen if login is successful

      if (mounted) {
        if (pUpdater.value != null) {
          // Safely access message
          final message = pUpdater.value?.message;
          // Check if the response code is 200
          if (pUpdater.value!.code == 200) {
            // Navigate to homescreen if signin is successful
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ControllerNavScreen(
                        initialIndex: 2,
                      )),
            );
            showSuccess(message: message!, context: context);
          } else {
            showErrorPopup(message: message, context: context);
          }
        }
      }
    } catch (e) {
      // Show error if login fails
      if (mounted) {
        showErrorPopup(
            message: e.toString().replaceAll('Exception: ', ''),
            context: context);
      }
    }
  }

  Future<void> _acceptOrReject(
      {required String groupId,
      required String userId,
      required bool approve}) async {
    try {
      await ref.read(profileProvider.notifier).acceptOrRejectInviteGroup(
          groupId: groupId, userId: userId, approve: approve);

      final pUpdater = ref.read(profileProvider).acceptOrRejectInviteGroup;
      // Navigate to home screen if login is successful

      if (mounted) {
        if (pUpdater.value != null) {
          // Safely access message
          final message = pUpdater.value?.message;
          // Check if the response code is 200
          if (pUpdater.value!.code == 200) {
            // Navigate to homescreen if signin is successful
            await ref
                .refresh(groupdetailsprovider.notifier)
                .getGroupDetailsById(id: '66d6da40712d196a6a915636');
            await ref
                .refresh(groupJoinRequestprovider.notifier)
                .getGroupJoinRequestById(id: '66d6da40712d196a6a915636');
            showSuccess(message: message!, context: context);
          } else {
            showErrorPopup(message: message, context: context);
          }
        }
      }
    } catch (e) {
      // Show error if login fails
      if (mounted) {
        showErrorPopup(
            message: e.toString().replaceAll('Exception: ', ''),
            context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(groupdetailsprovider);
    final res1 = ref.watch(groupJoinRequestprovider);
    final isLoading = ref.watch(groupdetailsprovider).isLoading;
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
          isLoading ? "....." : res.value?.data?.groupName ?? '',
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
              res.when(
                  skipLoadingOnRefresh: true,
                  data: (res) {
                    if (res?.data != null) {
                      return Center(
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
                                child: Image.network(
                                  '${res?.data?.serviceLogo}',
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Shimmer.fromColors(
                      baseColor: AppColors.accent,
                      highlightColor: AppColors.primaryColor,
                      child: Center(
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
                    );
                  },
                  error: (
                    e,
                    stackTrace,
                  ) {
                    return Shimmer.fromColors(
                      baseColor: AppColors.accent,
                      highlightColor: AppColors.primaryColor,
                      child: Center(
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
                    );
                  },
                  loading: () => Shimmer.fromColors(
                        baseColor: AppColors.accent,
                        highlightColor: AppColors.primaryColor,
                        child: Center(
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
                      )),
              const SizedBox(height: 16.0),
              res.when(
                skipLoadingOnRefresh: true,
                data: (data) {
                  if (data?.data != null) {
                    return Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              data!.data!.admin!.avatarUrl!,
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
                              data.data!.admin!.username!,
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
                            InkWell(
                                onTap: () {
                                  Share.share(data.data!.groupCode!);
                                },
                                child: SvgPicture.asset(AppImages.shareIcon)),
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
                    );
                  }
                  return Row(
                    children: [
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppColors.accent,
                            highlightColor: AppColors.primaryColor,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  AppImages.avatarImage5,
                                  width: 32,
                                  height: 32,
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
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
                  );
                },
                loading: () => Row(
                  children: [
                    Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppColors.accent,
                          highlightColor: AppColors.primaryColor,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                AppImages.avatarImage5,
                                width: 32,
                                height: 32,
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '',
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
                error: (error, stackTrace) => Row(
                  children: [
                    Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppColors.accent,
                          highlightColor: AppColors.primaryColor,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                AppImages.avatarImage5,
                                width: 32,
                                height: 32,
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '',
                              style: GoogleFonts.lato(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '',
                              style: GoogleFonts.lato(
                                color: AppColors.textColor01,
                                fontSize: 12,
                              ),
                            ),
                          ],
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
              ),
              const SizedBox(height: 15.0),
              const Divider(),
              RichText(
                text: TextSpan(
                  text: isLoading
                      ? 'Group Members :'
                      : 'Group Members : ${res.value?.data?.members?.length ?? 0}',
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
                      text: isLoading
                          ? '0'
                          : " ${res.value?.data?.numberOfMembers ?? 0} ",
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
              res.when(
                  skipLoadingOnRefresh: true,
                  data: (data) {
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data?.data?.members?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = data?.data?.members?[index];
                          return GroupMemberWidget1(
                            image: item!.user!.avatarUrl!,
                            name: item.user!.username!,
                            isActive: item.subscriptionStatus == 'active'
                                ? true
                                : false,
                          );
                        });
                  },
                  error: (error, stackTrace) {
                    return Shimmer.fromColors(
                        baseColor: AppColors.accent,
                        highlightColor: AppColors.primaryColor,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return const GroupMemberWidget(
                                image: AppImages.avatarImage5,
                                name: "",
                                isActive: true,
                              );
                            }));
                  },
                  loading: () => Shimmer.fromColors(
                      baseColor: AppColors.accent,
                      highlightColor: AppColors.primaryColor,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return const GroupMemberWidget(
                              image: AppImages.avatarImage5,
                              name: " ",
                              isActive: true,
                            );
                          }))),
              const SizedBox(
                height: 10,
              ),
              if (res1.value?.message !=
                  'Only the group admin can view join requests')
                SizedBox(
                    height: 250,
                    child: res1.when(
                        skipLoadingOnRefresh: true,
                        data: (data) {
                          final dataItem = data?.data;
                          if (dataItem != null && dataItem.isNotEmpty) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data?.data?.length,
                                itemBuilder: (context, index) {
                                  final item = dataItem[index];
                                  return MemberRequestCard1(
                                    img: item.user?.avatarUrl,
                                    name: item.user?.username,
                                    message: item.message,
                                    textAccept: const Text("Accept"),
                                    textReject: Text(
                                      "Decline",
                                      style: GoogleFonts.lato(
                                        color: AppColors.primaryColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    accept: () {
                                      _acceptOrReject(
                                          groupId: '66d6da40712d196a6a915636',
                                          userId: item.user!.id!,
                                          approve: true);
                                    },
                                    reject: () {
                                      _acceptOrReject(
                                          groupId: '66d6da40712d196a6a915636',
                                          userId: item.user!.id!,
                                          approve: false);
                                    },
                                  );
                                });
                          }
                          return const Center(
                            child: Text('No Active Request'),
                          );
                        },
                        error: (e, s) {
                          return Shimmer.fromColors(
                              baseColor: AppColors.accent,
                              highlightColor: AppColors.primaryColor,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return const MemberRequestCard();
                                  }));
                        },
                        loading: () => Shimmer.fromColors(
                              baseColor: AppColors.accent,
                              highlightColor: AppColors.primaryColor,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return const MemberRequestCard();
                                  }),
                            ))),
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
                          text: 'Service Description',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    isLoading
                        ? const Text('')
                        : Text(res.value?.data?.serviceDescription ?? ''),
                    // const CheckListWidget(
                    //   text: "Ad-free music listening",
                    // ),
                    // const CheckListWidget(
                    //   text: "Offline playback",
                    // ),
                    // const CheckListWidget(
                    //   text:
                    //       "Access to over 70 million songs and 2.2 million podcasts",
                    // ),
                    // const CheckListWidget(
                    //   text:
                    //       "Six individual accounts for family members under one plan",
                    // ),
                    // const CheckListWidget(
                    //   text:
                    //       "Family Mix: Shared playlist based on everyone’s listening",
                    // ),
                    // const CheckListWidget(
                    //   text: "Spotify Kids: Special app for kids",
                    // ),

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
                          'SubScriptionCost',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: isLoading
                                ? ''
                                : '${res.value?.data?.subscriptionCost ?? 0} NGN',
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
                            text: isLoading
                                ? ''
                                : '${res.value?.data?.handlingFee ?? 0} NGN',
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
                            text: isLoading
                                ? ''
                                : '${(res.value?.data?.individualShare)?.round() ?? 0} NGN',
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
              // const Divider(),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   'Payment Details',
              //   style: GoogleFonts.lato(
              //     color: AppColors.textColor,
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Next payment deadline',
              //       style: GoogleFonts.lato(
              //         color: AppColors.textColor,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //     Text(
              //       isLoading
              //           ? ''
              //           : res.value?.data?.nextSubscriptionDate != null
              //               ? DateFormat('dd MMMM yyyy, hh:mm a')
              //                   .format(res.value!.data!.nextSubscriptionDate!)
              //               : 'No Date Available',
              //       style: GoogleFonts.lato(
              //         color: AppColors.textColor,
              //         fontSize: 14,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Amount',
              //       style: GoogleFonts.lato(
              //         color: AppColors.textColor,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //     Text(
              //       "1000 NGN",
              //       style: GoogleFonts.lato(
              //         color: AppColors.primaryColor,
              //         fontWeight: FontWeight.w600,
              //         fontSize: 14,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   'Upcoming Payments',
              //   style: GoogleFonts.lato(
              //     color: AppColors.textColor,
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'August 15, 2024',
              //       style: GoogleFonts.lato(
              //         color: AppColors.textColor,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //     Text(
              //       "1000 NGN",
              //       style: GoogleFonts.lato(
              //         color: AppColors.primaryColor,
              //         fontWeight: FontWeight.w600,
              //         fontSize: 14,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'September 15, 2024',
              //       style: GoogleFonts.lato(
              //         color: AppColors.textColor,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //     Text(
              //       "1000 NGN",
              //       style: GoogleFonts.lato(
              //         color: AppColors.primaryColor,
              //         fontWeight: FontWeight.w600,
              //         fontSize: 14,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'October 15, 2024',
              //       style: GoogleFonts.lato(
              //         color: AppColors.textColor,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //     Text(
              //       "1000 NGN",
              //       style: GoogleFonts.lato(
              //         color: AppColors.primaryColor,
              //         fontWeight: FontWeight.w600,
              //         fontSize: 14,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  _leaveGroup(roomId: widget.id!);
                },
                child: Row(
                  children: [
                    // SvgPicture.asset(AppImages.exitIcon),
                    Text(
                      'Exit Group',
                      style: GoogleFonts.lato(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
