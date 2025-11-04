import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/core/design_system/widgets/buttons/float_button.dart';
import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';
import 'package:doctor_app/features/profile/presentation/widgets/document_box.dart';
import 'package:doctor_app/features/shared/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DocumentsPage extends StatefulWidget {
  DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final UserController userController = Get.find<UserController>();
  final CabinetController cabinetController = Get.find<CabinetController>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadingDocuments();
  }

  loadingDocuments() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "documents".tr,
              style: WorkSansStyle.titleLarge.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey.shade300,
              ),
            ),
          ),
          floatingActionButton: FloatButton(
            onClick: () => cabinetController.pickupDocuments(),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Obx(() {
                      if (userController.user.value!.documents!.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: Center(
                            child: Text(
                              "no_documents".tr,
                              style: WorkSansStyle.bodyLarge,
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            itemCount: userController.user.value!.documents!.length,
                            itemBuilder: (context, index) {
                              final documentUrl = userController.user.value!.documents![index];

                              return FutureBuilder<void>(
                                future: Future.delayed(Duration(milliseconds: 80 * index)),
                                builder: (context, snapshot) {
                                  final isVisible = snapshot.connectionState == ConnectionState.done;

                                  return AnimatedOpacity(
                                    opacity: isVisible ? 1 : 0,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeOut,
                                    child: AnimatedSlide(
                                      offset: isVisible ? Offset.zero : const Offset(0, 0.1),
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.easeOut,
                                      child: DocumentBox(
                                        name: documentUrl.name,
                                        url: documentUrl.url,
                                        onClick: () {
                                          Get.dialog(
                                            Dialog(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 15, vertical: 20),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text("delete_document_alert".tr,
                                                        style: WorkSansStyle.bodyLarge),
                                                    const SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        ShadButton.secondary(
                                                          decoration: ShadDecoration(
                                                            border: ShadBorder.all(
                                                              color: Colors.black,
                                                              width: 1.5,
                                                              radius: BorderRadius.circular(10),
                                                            ),
                                                          ),
                                                          onPressed: () =>
                                                              Navigator.of(context).pop(),
                                                          child: Text("cancel".tr,
                                                              style: WorkSansStyle.bodyLarge),
                                                        ),
                                                        PrimaryButton(
                                                          borderRadius: BorderRadius.circular(10),
                                                          bgColor: Colors.red,
                                                          onTap: () async {
                                                            cabinetController
                                                                .deleteDocument(documentUrl.id!);
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text("delete".tr,
                                                              style: WorkSansStyle.bodyLarge),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            separatorBuilder: (_, __) => const SizedBox(height: 15),
                          ),
                        );

                      }
                    }),
                  ],
                ),
        ),
        Obx(() {
          if (cabinetController.isDeleting.value ||
              cabinetController.isDocumentUploading.value) {
            return Container(
              color: Colors.black26,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return SizedBox.shrink();
        }),
      ],
    );
  }
}
