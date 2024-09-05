import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/api/model/user/user_model.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/riverPod/userProvider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/change_avatar.dart';
import 'package:sharepact_app/screens/authScreen/login.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';
import 'package:shimmer/shimmer.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => EditProfileState();
}

class EditProfileState extends ConsumerState<EditProfile> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Future<void> update() async {
    if (usernameController.text.isEmpty) {
      showErrorPopup(context: context, message: 'userName Required');
    }
    if (emailController.text.isEmpty) {
      showErrorPopup(context: context, message: 'email Required');
    }
    await ref.read(profileProvider.notifier).getToken();
    final myToken = ref.read(profileProvider).getToken.value;
    await ref.read(profileProvider.notifier).checkTokenStatus(token: myToken!);
    final isTokenValid = ref.read(profileProvider).checkTokenstatus.value;
    if (isTokenValid!.code == 401) {
      _handleSessionExpired();
      return;
    }
    try {
      await ref.read(profileProvider.notifier).updatUserNameAndEmail(
          email: emailController.text, userName: usernameController.text);

      final pUpdater = ref.read(profileProvider).updateUserNameAndEmail;
      if (mounted) {
        if (pUpdater.value != null) {
          // Safely access message
          final message = pUpdater.value?.message;
          // Check if the response code is 200
          if (pUpdater.value!.code == 200) {
            showSuccess(message: message!, context: context);
            await ref.read(userProvider.notifier).getUserDetails();
          } else {
            showErrorPopup(message: message, context: context);
          }
        }
      }
    } catch (er) {
      // Show error if login fails
      if (mounted) {
        showErrorPopup(
            message: er.toString().replaceAll('Exception: ', ''),
            context: context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Future.microtask(() => _fetchUserData());
  }

  UserModel? _userModel;
  Future<void> _fetchUserData() async {
    await ref.read(profileProvider.notifier).getToken();
    final myToken = ref.read(profileProvider).getToken.value;
    await ref.read(profileProvider.notifier).checkTokenStatus(token: myToken!);
    final isTokenValid = ref.read(profileProvider).checkTokenstatus.value;

    if (isTokenValid!.code != 200) {
      _handleSessionExpired();
      return;
    }

    await ref.read(userProvider.notifier).getUserDetails();
    final ayncUser = ref.watch(userProvider);
    if (ayncUser.hasError) {
      final el = ayncUser.error as UserResponseModel;
      _handleError(el.message.toString());
      return;
    }
    if (ayncUser.hasValue) {
      setState(() {
        _userModel = ayncUser.value;
        // Populate the controllers with the fetched user data
        emailController.text = _userModel?.email ?? '';
        usernameController.text = _userModel?.username ?? '';
      });
      return;
    }
  }

  void _handleError([
    String? message,
  ]) {
    showErrorPopup(context: context, message: message);
    return;
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

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(userProvider).isLoading;
    final isLoading1 =
        ref.watch(profileProvider).updateUserNameAndEmail.isLoading;
    final userDetails = ref.watch(userProvider);
    return RefreshIndicator(
      onRefresh: () async {
        _fetchUserData();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffE6F2FF),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios)),
                        Text(
                          "Edit Profile",
                          style: GoogleFonts.lato(
                            color: const Color(0xff343A40),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ChangeAvatarScreen(),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color: AppColors.primaryColor,
                              ),
                              shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: userDetails.when(
                                skipLoadingOnReload: true,
                                data: (userDetails) {
                                  if (userDetails?.avatarUrl == null) {
                                    return Shimmer.fromColors(
                                      baseColor: AppColors.accent,
                                      highlightColor: AppColors.primaryColor,
                                      child: Image.asset(
                                        'assets/avatars/image4.png',
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }
                                  return Image.network(
                                    "${userDetails?.avatarUrl}",
                                    fit: BoxFit.cover,
                                  );
                                },
                                error: (e, st) {
                                  return Shimmer.fromColors(
                                    baseColor: AppColors.accent,
                                    highlightColor: AppColors.primaryColor,
                                    child: Image.asset(
                                      'assets/avatars/image4.png',
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                loading: () => Shimmer.fromColors(
                                      baseColor: AppColors.accent,
                                      highlightColor: AppColors.primaryColor,
                                      child: Image.asset(
                                        'assets/avatars/image4.png',
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: SvgPicture.asset(AppImages.editIcon)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Edit Profile",
                    style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    isLoading
                        ? "Janedoe@gmail.com"
                        : "${_userModel?.email ?? 'loading...'} ",
                    style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(64),
                        topRight: Radius.circular(64),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Text(
                              'Username',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const Text(
                              '*',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: const Color(0xff5D6166),
                                ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color(0xffBBC0C3), width: 1),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Email Address',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: isLoading
                                ? 'Janedoe@gmail.com'
                                : "${_userModel?.email ?? 'loading...'} ",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: const Color(0xff5D6166),
                                ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 59,
                          child: ElevatedButton(
                            onPressed: isLoading1 ? () {} : update,
                            child: isLoading1
                                ? const CircularProgressIndicator()
                                : const Text('Save Changes'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
