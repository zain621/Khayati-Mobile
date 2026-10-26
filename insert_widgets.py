import sys

file_path = r'd:\flutterprojects\khayati\lib\features\user\loyalty\presentation\pages\loyalty_points_screen.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

new_widgets = r"""
// ──────────────────────────────────────────────────────────────────────────────
// Unused Code Card Widget
// ──────────────────────────────────────────────────────────────────────────────
class _UnusedCodeCard extends StatelessWidget {
  final UnusedLoyaltyCodeModel item;

  const _UnusedCodeCard({required this.item});

  void _copyCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: item.code));
    HapticFeedback.selectionClick();
    AppSnackbar.success(
      ManagerStrings.loyaltyUnusedCodeCopied,
      englishMessage: ManagerStrings.loyaltyUnusedCodeCopiedEn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String discountLabel = item.discountType == 'percentage'
        ? '${ManagerStrings.loyaltyDiscountPercent} ${item.discountValue.toStringAsFixed(0)}'
        : '${ManagerStrings.loyaltyDiscountFixed} ${item.discountValue.toStringAsFixed(0)} ${ManagerStrings.loyaltyUnusedCodesCurrency}';

    String formattedDate = item.createdAt;
    try {
      formattedDate = DateFormat('yyyy/MM/dd')
          .format(DateTime.parse(item.createdAt).toLocal());
    } catch (_) {}

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.rewardTitleAr,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w8,
                    vertical: ManagerHeight.h3,
                  ),
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(ManagerRadius.r6),
                  ),
                  child: Text(
                    discountLabel,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: ManagerHeight.h8),

            GestureDetector(
              onTap: () => _copyCode(context),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w12,
                  vertical: ManagerHeight.h10,
                ),
                decoration: BoxDecoration(
                  color: ManagerColors.primaryColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  border: Border.all(
                    color: ManagerColors.primaryColor.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.code,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                    const Icon(
                      Icons.copy_rounded,
                      color: ManagerColors.primaryColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: ManagerHeight.h6),

            Text(
              formattedDate,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Empty unused codes state
// ──────────────────────────────────────────────────────────────────────────────
class _EmptyUnusedCodesWidget extends StatelessWidget {
  const _EmptyUnusedCodesWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ManagerHeight.h32,
        horizontal: ManagerWidth.w24,
      ),
      child: Column(
        children: [
          Icon(
            Icons.confirmation_number_outlined,
            size: ManagerHeight.h48,
            color: ManagerColors.greyWhiteColor,
          ),
          SizedBox(height: ManagerHeight.h10),
          Text(
            ManagerStrings.loyaltyUnusedCodesEmpty,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.greyWhiteColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ManagerHeight.h4),
          Text(
            ManagerStrings.loyaltyUnusedCodesEmptySub,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
"""

# Find the marker: "// Shimmer colours" - insert before the line with the box drawing chars above it
lines = content.split('\n')
insert_idx = None
for i, line in enumerate(lines):
    if '// Shimmer colours' in line:
        # Insert before the box-drawing line that precedes this (2 lines before)
        insert_idx = i - 1
        break

if insert_idx is None:
    print("ERROR: Could not find insertion point")
    sys.exit(1)

print(f"Inserting before line {insert_idx}: {repr(lines[insert_idx][:60])}")

new_lines = lines[:insert_idx] + new_widgets.split('\n') + lines[insert_idx:]
new_content = '\n'.join(new_lines)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print(f"Done. Total lines: {len(new_lines)}")
