import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/riverPod/chat2_provider.dart';
import 'package:sharepact_app/api/riverPod/chat_provider.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/screens/services_screen/create_group.dart';
import 'package:sharepact_app/screens/authScreen/login.dart';
import 'package:sharepact_app/screens/home/controllerNav.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';
import 'package:sharepact_app/widgets/popup_content.dart';
import 'package:sharepact_app/widgets/popup_input_widget.dart';
import 'package:shimmer/shimmer.dart';

class NetflixDetailsScreen extends ConsumerStatefulWidget {
  const NetflixDetailsScreen({super.key, this.id});
  final String? id;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NetflixDetailsScreenState();
}

class _NetflixDetailsScreenState extends ConsumerState<NetflixDetailsScreen> {
  final TextEditingController messageController = TextEditingController();

  final TextEditingController codeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() => getserviceById());
  }

  Future<void> getserviceById() async {
    try {
      await ref.read(profileProvider.notifier).validateToken();
      final isTokenValid = ref.read(profileProvider).isTokenValid.value;
      if (isTokenValid == false) {
        _handleSessionExpired();
        return;
      }
      await ref.read(profileProvider.notifier).getServiceById(id: widget.id!);
    } catch (e) {
      if (mounted) {
        showErrorPopup(context: context, message: e.toString());
      }
    }
  }

  void _handleSessionExpired() {
    if (mounted) {
      showErrorPopup(context: context, message: 'Session Expired');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      return;
    }
  }

  Future<void> _isGroupExisting({required String roomId}) async {
    try {
      await ref.read(profileProvider.notifier).getGroupByCode(groupId: roomId);

      final pUpdater = ref.read(profileProvider).getGroupbyCode;
      // Navigate to home screen if login is successful

      if (mounted) {
        if (pUpdater.value != null) {
          // Safely access message
          // final message = pUpdater.value?.message;
          // Check if the response code is 200
          if (pUpdater.value!.code == 200) {
            // Navigate to homescreen if signin is successful

            _showJoinGroupDialogPass(context, ref);
          } else {
            _showJoinGroupDialogFailed(context);
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

  Future<void> _joinGroup(
      {required String roomId, required String message}) async {
    try {
      await ref.read(profileProvider.notifier).validateToken();
      final isTokenValid = ref.read(profileProvider).isTokenValid.value;
      if (isTokenValid == false) {
        _handleSessionExpired();
        return;
      }

      await ref
          .read(profileProvider.notifier)
          .joinAGroup(groupCode: roomId, message: message);

      final pUpdater = ref.read(profileProvider).joinGroup;
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
            _showJoinGroupDialogPassMessage(context);
            codeController.clear();
            messageController.clear();
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
    final services = ref.watch(profileProvider).getServiceById;
    ref.watch(chatStateProvider);
    ref.watch(chatProvider1);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button action
              Navigator.pop(context);
            },
          ),
          title: Text(services.hasValue
              ? services.value?.data?.serviceName ?? ''
              : 'loadind....'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              services.when(
                  data: (services) {
                    final item = services?.data;
                    if (item != null) {
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
                                  item.logoUrl!,
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return const Text('No Data');
                  },
                  error: (
                    e,
                    stackTrace,
                  ) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Error loading subscriptions: $e'),
                          ElevatedButton(
                            onPressed: () {
                              // Add retry logic here
                              ref
                                  .read(profileProvider.notifier)
                                  .getServiceById(id: widget.id!);
                            },
                            child: const Text('Retry'),
                          ),
                        ],
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
              services.when(
                  data: (services) {
                    return SizedBox(
                      width: double.infinity,
                      child: Text(
                        services?.data?.serviceDescription ?? '',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  },
                  error: (
                    e,
                    stackTrace,
                  ) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Error loading subscriptions: $e'),
                          ElevatedButton(
                            onPressed: () {
                              // Add retry logic here
                              ref
                                  .read(profileProvider.notifier)
                                  .getServiceById(id: widget.id!);
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () => Shimmer.fromColors(
                      baseColor: AppColors.accent,
                      highlightColor: AppColors.primaryColor,
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'For families and enthusiasts, the Premium Plan provides Ultra HD quality on up to four screens simultaneously. Enjoy unlimited access to movies, TV shows, and original content with the flexibility to cancel anytime.',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ))),
              const SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 49,
                      color: const Color(0xFF007BFF),
                    ),
                    const SizedBox(width: 10.0),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Sharepact Handling Fee: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text: services.hasValue
                                ? '${services.value?.data?.handlingFees} NGN/ month'
                                : '000 NGN/ month',
                            style: const TextStyle(
                              color: Color(0xFF007BFF),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        _showJoinGroupDialog(context, ref);
                      },
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size(339, 59),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 16.0),
                        side: const BorderSide(color: Color(0xFF007BFF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text(
                        'Join A Group',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF007BFF),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateGroupScreen(
                              id: widget.id,
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size(339, 59),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 16.0),
                        side: const BorderSide(color: Color(0xFF007BFF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text(
                        'Create A Group',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF007BFF),
                          fontWeight: FontWeight.w400,
                        ),
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

  void _showJoinGroupDialog(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(profileProvider).getGroupbyCode.isLoading;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: PopupInputWidget(
            textController: codeController,
            title: "Group Code",
            subtext:
                "Please enter the group code provided by the group creator to join the subscription group",
            hintText: 'Enter code',
            btnText: isLoading ? 'proceeding...' : 'Proceed',
            onPressed: isLoading
                ? () {}
                : () {
                    _isGroupExisting(roomId: codeController.text);
                    Navigator.pop(context);
                  },
          ),
        );
      },
    );
  }

  void _showJoinGroupDialogPass(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(profileProvider).joinGroup.isLoading;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              // contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: PopupInputWidget(
                  title: "Message",
                  subtext:
                      "Please send a message to the group creator about your intention to join the group",
                  minLines: 5,
                  btnText: isLoading ? 'sending...' : 'Send Message',
                  textController: messageController,
                  height: 320,
                  hintText:
                      'Hi creator, I’d like to become a member of this group ',
                  onPressed: () {
                    _joinGroup(
                        roomId: codeController.text,
                        message: messageController.text);
                    Navigator.pop(context);
                  }));
        });
  }

  void _showJoinGroupDialogFailed(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: PopupContentWidget(
              icon: AppImages.invalidIcon,
              title: "Invalid Group Code!",
              subtext:
                  "The group code you entered is incorrect. Please try again or reach out to the group creator if you believe the code provided is incorrect",
              actionBtnText: "Try Again",
              buttonColor: AppColors.primaryColor,
              onPressed: () {
                Navigator.pop(context);
                _showJoinGroupDialog(context, ref);
              },
            ),
          );
        });
  }

  void _showJoinGroupDialogPassMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              // contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: PopupContentWidget(
                icon: AppImages.successIcon,
                title: "Request Sent!",
                subtext:
                    "Your request to join the group has been sent successfully",
                actionBtnText: "Join More Groups",
                buttonColor: AppColors.primaryColor,
                closeBtnText: 'Close',
                onPressed: () {
                  Navigator.pop(context);
                  _showJoinGroupDialog(context, ref);
                },
              ));
        });
  }
}

class PlanCard extends StatelessWidget {
  final String planName;
  final String price;
  final List<String> features;

  const PlanCard(
      {super.key,
      required this.planName,
      required this.price,
      required this.features});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      planName,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: price.split('/')[0],
                            style: const TextStyle(
                              color: Color(0xFF007BFF),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' /${price.split('/')[1]}',
                            style: const TextStyle(
                              color: Color(0xFF5D6166),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: features
                    .map((feature) => FeatureItem(text: feature))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String text;

  const FeatureItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.blue,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
