import 'package:flutter/material.dart'; // استيراد مكتبة Flutter الأساسية (قد تُستخدم لاحقًا مع الواجهات)

enum Season{ // تعداد (Enum) لتحديد فصل الرحلة
  Winter, // فصل الشتاء
  Spring, // فصل الربيع
  Summer, // فصل الصيف
  Autumn, // فصل الخريف
}

enum TripType{ // تعداد (Enum) لتحديد نوع الرحلة
  Exploration, // رحلة استكشافية
  Recovery, // رحلة استجمام
  Activities, // رحلة نشاطات
  Therapy, // رحلة علاجية
  Cultural, // رحلة ثقافية
}

class Trip { // كلاس (Model) يمثل بيانات رحلة واحدة
  final String id; // معرّف فريد لكل رحلة
  final List<String> categories; // قائمة التصنيفات التي تنتمي لها الرحلة
  final String title; // عنوان / اسم الرحلة
  final String imageUrl; // رابط صورة الرحلة
  final List<String> activities; // قائمة الأنشطة داخل الرحلة
  final List<String> program; // برنامج الرحلة (تفاصيل الأيام)
  final int duration; // مدة الرحلة بالأيام
  final Season season; // فصل الرحلة (من enum Season)
  final TripType tripType; // نوع الرحلة (من enum TripType)
  final bool isInSummer; // هل الرحلة متاحة في الصيف
  final bool isInWinter; // هل الرحلة متاحة في الشتاء
  final bool isForFamilies; // هل الرحلة مناسبة للعائلات

  const Trip({ // constructor لإنشاء كائن رحلة مع إجبارية تمرير القيم
    required this.id, // تمرير معرّف الرحلة
    required this.categories, // تمرير التصنيفات
    required this.title, // تمرير عنوان الرحلة
    required this.imageUrl, // تمرير صورة الرحلة
    required this.activities, // تمرير الأنشطة
    required this.program, // تمرير برنامج الرحلة
    required this.duration, // تمرير مدة الرحلة
    required this.season, // تمرير فصل الرحلة
    required this.tripType, // تمرير نوع الرحلة
    required this.isInSummer, // تمرير هل هي صيفية
    required this.isInWinter, // تمرير هل هي شتوية
    required this.isForFamilies, // تمرير هل مناسبة للعائلات
  });
}
