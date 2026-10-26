import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';

/// Bottom input bar for the chat screen (provider side).
/// Supports sending text, images (camera / gallery), and any file type.
class ChatInputBar extends StatelessWidget {
  final TextEditingController messageController;
  final VoidCallback onSend;
  final VoidCallback onCustomOffer;
  final FocusNode? focusNode;
  final bool showOfferButton;
  final List<XFile> selectedFiles;
  final void Function(List<XFile>) onFilesAdded;
  final void Function(XFile) onRemoveFile;

  const ChatInputBar({
    super.key,
    required this.messageController,
    required this.onSend,
    required this.onCustomOffer,
    required this.selectedFiles,
    required this.onFilesAdded,
    required this.onRemoveFile,
    this.focusNode,
    this.showOfferButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // â”€â”€ Selected files preview strip â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            if (selectedFiles.isNotEmpty)
              _SelectedFilesStrip(
                files: selectedFiles,
                onRemove: onRemoveFile,
              ),
            // â”€â”€ Input row â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w10,
                vertical: ManagerHeight.h8,
              ),
              child: Row(
                children: [
                  // // Offer button (provider only)
                  // if (showOfferButton) ...[
                  //   GestureDetector(
                  //     onTap: onCustomOffer,
                  //     child: Container(
                  //       height: ManagerHeight.h34,
                  //       width: ManagerWidth.w34,
                  //       decoration: const BoxDecoration(
                  //         color: Color(0xFFF1F5F9),
                  //         shape: BoxShape.circle,
                  //       ),
                  //       child: const Icon(
                  //         Icons.local_offer_outlined,
                  //         color: ManagerColors.primaryColor,
                  //         size: 18,
                  //       ),
                  //     ),
                  //   ),
                  //   SizedBox(width: ManagerWidth.w8),
                  // ],
                  // Attachment button
                  GestureDetector(
                    onTap: () => _showAttachmentSheet(context),
                    child: Container(
                      height: ManagerHeight.h34,
                      width: ManagerWidth.w34,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF1F5F9), shape: BoxShape.circle),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ManagerWidth.w8,
                          vertical: ManagerHeight.h8,
                        ),
                        child: const CustomSvgImage(
                          path: ManagerIcons.attachmentIcon,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w8),
                  // Text input
                  Expanded(
                    child: Container(
                      constraints:
                          BoxConstraints(maxHeight: ManagerHeight.h100),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(ManagerRadius.r20),
                      ),
                      child: TextField(
                        controller: messageController,
                        focusNode: focusNode,
                        textAlign: TextAlign.right,
                        textDirection: Directionality.of(context),
                        maxLines: null,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s13,
                          color: ManagerColors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: ManagerStrings.chatWriteMessage,
                          hintStyle: getRegularTextStyle(
                            fontSize: ManagerFontSize.s13,
                            color: ManagerColors.greyWhiteColor,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w14,
                            vertical: ManagerHeight.h10,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w8),
                  // Send button
                  GestureDetector(
                    onTap: onSend,
                    child: Container(
                      width: ManagerWidth.w36,
                      height: ManagerHeight.h36,
                      decoration: const BoxDecoration(
                        color: ManagerColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send_rounded,
                        color: ManagerColors.white,
                        size: ManagerWidth.w18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAttachmentSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: ManagerColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ManagerRadius.r20),
        ),
      ),
      builder: (_) => _AttachmentSheet(onFilesAdded: onFilesAdded),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Attachment bottom sheet
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _AttachmentSheet extends StatelessWidget {
  final void Function(List<XFile>) onFilesAdded;
  const _AttachmentSheet({required this.onFilesAdded});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w24,
        vertical: ManagerHeight.h20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: ManagerWidth.w40,
            height: ManagerHeight.h4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(ManagerRadius.r4),
            ),
          ),
          SizedBox(height: ManagerHeight.h20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SheetOption(
                icon: Icons.camera_alt_outlined,
                label: ManagerStrings.chatAttachCamera,
                onTap: () async {
                  Navigator.pop(context);
                  final picked = await ImagePicker().pickImage(
                      source: ImageSource.camera, imageQuality: 85);
                  if (picked != null) onFilesAdded([picked]);
                },
              ),
              _SheetOption(
                icon: Icons.photo_library_outlined,
                label: ManagerStrings.chatAttachGallery,
                onTap: () async {
                  Navigator.pop(context);
                  final picked =
                      await ImagePicker().pickMultiImage(imageQuality: 85);
                  if (picked.isNotEmpty) onFilesAdded(picked);
                },
              ),
              _SheetOption(
                icon: Icons.insert_drive_file_outlined,
                label: ManagerStrings.chatAttachFile,
                onTap: () async {
                  Navigator.pop(context);
                  // Documents only via SAF — never broad media/storage permissions.
                  final result = await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                    type: FileType.custom,
                    allowedExtensions: const [
                      'pdf',
                      'doc',
                      'docx',
                      'txt',
                      'xls',
                      'xlsx',
                      'ppt',
                      'pptx',
                    ],
                  );
                  if (result != null) {
                    final files = result.paths
                        .whereType<String>()
                        .map((p) => XFile(p))
                        .toList();
                    if (files.isNotEmpty) onFilesAdded(files);
                  }
                },
              ),
            ],
          ),
          SizedBox(height: ManagerHeight.h10),
        ],
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SheetOption(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: ManagerWidth.w60,
            height: ManagerHeight.h60,
            decoration: BoxDecoration(
              color: ManagerColors.primaryColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: ManagerColors.primaryColor, size: 28),
          ),
          SizedBox(height: ManagerHeight.h8),
          Text(
            label,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Selected files preview strip
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _SelectedFilesStrip extends StatelessWidget {
  final List<XFile> files;
  final void Function(XFile) onRemove;
  const _SelectedFilesStrip({required this.files, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ManagerHeight.h80,
      padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w10, vertical: ManagerHeight.h6),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FE),
        border: Border(top: BorderSide(color: Color(0xFFE8ECF0))),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: files.length,
        separatorBuilder: (_, __) => SizedBox(width: ManagerWidth.w8),
        itemBuilder: (context, index) {
          final file = files[index];
          final isImage = _isImagePath(file.path);
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: ManagerWidth.w64,
                height: ManagerHeight.h64,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2F7),
                  borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  border: Border.all(color: const Color(0xFFDDE3EA)),
                ),
                child: isImage
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(ManagerRadius.r8),
                        child: Image.file(
                          File(file.path),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.image_outlined,
                            color: Color(0xFF999999),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.insert_drive_file_outlined,
                            color: ManagerColors.primaryColor,
                            size: 26,
                          ),
                          SizedBox(height: ManagerHeight.h4),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ManagerWidth.w4),
                            child: Text(
                              file.name,
                              style: getRegularTextStyle(
                                fontSize: ManagerFontSize.s9,
                                color: ManagerColors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
              ),
              Positioned(
                top: -6,
                right: -6,
                child: GestureDetector(
                  onTap: () => onRemove(file),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF4444),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close,
                        color: Colors.white, size: 12),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool _isImagePath(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.heic');
  }
}
