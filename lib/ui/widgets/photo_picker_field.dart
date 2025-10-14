import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerField extends StatelessWidget {
  const PhotoPickerField({super.key, required this.onTap, this.selectedPhoto});
  final VoidCallback onTap;
  final XFile? selectedPhoto;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xffadadad).withOpacity(0.2)),
        ),
        child: Row(
          children: [
            SizedBox(width: 8),
            Container(
              height: 45,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xff666666),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Text(
                'Photo',
                style: TextTheme.of(
                  context,
                ).titleSmall?.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                selectedPhoto == null
                    ? 'No Photo Selected'
                    : selectedPhoto!.name,
                maxLines: 1,
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
