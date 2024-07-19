import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/change_avatar.dart';
import 'package:sharepact_app/providers/settings_provider.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';
import 'package:sharepact_app/utils/constants/constants.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  final TextEditingController usernameController =
      TextEditingController(text: "Jane Doe1");
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var avatar = ref.watch(avatarProvider);
    return Scaffold(
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
                      const Icon(Icons.arrow_back_ios),
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
                        builder: (context) => ChangeAvatarScreen(),
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
                          child: Image.asset(
                            allAvatars[avatar],
                            fit: BoxFit.cover,
                          ),
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
                  "Janedoe@gmail.com",
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
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Janedoe@gmail.com',
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                          onPressed: () {},
                          child: const Text('Save Changes'),
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
    );
  }
}
