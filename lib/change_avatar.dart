import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/providers/settings_provider.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/constants/constants.dart';

class ChangeAvatarScreen extends ConsumerWidget {
  const ChangeAvatarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var avatar = ref.watch(avatarProvider);
    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: double.infinity,
                  child: Stack(fit: StackFit.expand, children: [
                    Image.asset(
                      allAvatars[avatar],
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              "Change Avatar",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.70,
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
                      Flexible(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 20,
                            crossAxisCount: 3,
                          ),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: allAvatars.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                ref.read(avatarProvider.notifier).state =
                                    index;
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    border: avatar == index ? Border.all(
                                      width: 4,
                                      color: AppColors.primaryColor,
                                    ) : null,
                                    shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                      allAvatars[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
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
                          child: const Text('Update Avatar'),
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
