import 'package:flutter/material.dart'; // استيراد مكتبة Flutter الأساسية لعناصر Material Design
import '../models/trip.dart'; // استيراد نموذج بيانات الرحلات
import '../screens/trip_detail_screen.dart'; // استيراد شاشة تفاصيل الرحلة

class TripItem extends StatelessWidget { // ويدجت بطاقة الرحلة (Stateless لأنه لا يتغير داخليًا)
  final String id; // معرف الرحلة
  final String title; // عنوان الرحلة
  final String imageUrl; // رابط الصورة
  final int duration; // مدة الرحلة بالأيام
  final TripType tripType; // نوع الرحلة (enum)
  final Season season; // الموسم (enum)

  const TripItem({ // الكونستركتور لتخزين القيم عند إنشاء البطاقة
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.tripType,
    required this.season,
  }) : super(key: key);

  // دالة لتحويل الموسم إلى نص عربي
  String get seasonText {
    switch (season) {
      case Season.Winter:
        return 'شتاء';
      case Season.Spring:
        return 'ربيع';
      case Season.Summer:
        return 'صيف';
      case Season.Autumn:
        return 'خريف';
    }
  }

  // دالة لتحويل نوع الرحلة إلى نص عربي
  String get tripTypeText {
    switch (tripType) {
      case TripType.Exploration:
        return 'استكشاف';
      case TripType.Recovery:
        return 'نقاهة';
      case TripType.Activities:
        return 'أنشطة';
      case TripType.Therapy:
        return 'معالجة';
      case TripType.Cultural:
        return 'عادات';
    }
  }

  // دالة تنقل إلى شاشة تفاصيل الرحلة عند الضغط
  void selectTrip(BuildContext context) {
    Navigator.of(context).pushNamed(
      TripDetailScreen.screenRoute, // مسار شاشة التفاصيل
      arguments:id, // إرسال معرف الرحلة للشاشة الجديدة
    );
  }

  @override
  Widget build(BuildContext context) { // بناء واجهة البطاقة
    return InkWell( // لجعل البطاقة قابلة للضغط
      onTap: () => selectTrip(context), // عند الضغط نفذ دالة الانتقال
      child: Card( // بطاقة تحتوي كل محتوى الرحلة
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // حواف دائرية للبطاقة
        ),
        elevation: 7, // ارتفاع البطاقة عن الخلفية لإعطاء عمق
        margin: const EdgeInsets.all(10), // مسافة خارجية حول البطاقة
        child: SingleChildScrollView( // يسمح بالتمرير إذا المحتوى طويل
          child: Column( // ترتيب المحتوى عمودياً
            children: [
              Stack( // لعرض الصورة والنص فوقها
                children: [
                  ClipRRect( // لتطبيق الحواف الدائرية على الصورة فقط
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      imageUrl, // تحميل الصورة من الرابط
                      height: 250, // ارتفاع الصورة
                      width: double.infinity, // تغطي كامل العرض
                      fit: BoxFit.cover, // الصورة تغطي المساحة بالكامل
                    ),
                  ),
                  Container( // طبقة نص فوق الصورة
                    height: 250,
                    alignment: Alignment.bottomRight, // محاذاة النص لليمين والأسفل
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration( // تدرج لوني لتوضيح النص
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0), // شفاف من الأعلى
                          Colors.black.withOpacity(0.9), // أسود من الأسفل
                        ],
                        stops: const [0.6, 1], // تحديد مكان بداية التدرج
                      ),
                    ),
                    child: Text(
                      title, // نص عنوان الرحلة
                      style:Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.fade, // لو النص طويل يختفي تدريجيًا
                    ),
                  ),
                ],
              ),
              Padding( // مسافة داخلية للمعلومات أسفل الصورة
                padding: const EdgeInsets.all(20.0),
                child: Row( // ترتيب المعلومات أفقياً
                  mainAxisAlignment: MainAxisAlignment.spaceAround, // توزيع متساوي
                  children: [
                    Row( // مدة الرحلة
                      children: [
                        const Icon(
                          Icons.today, // أيقونة يوم
                          color: Colors.yellow,
                        ),
                        const SizedBox(width: 6), // مسافة صغيرة
                        Text(
                          '$duration أيام', // نص المدة
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Row( // الموسم
                      children: [
                        const Icon(
                          Icons.wb_sunny, // أيقونة الشمس
                          color: Colors.yellow,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          seasonText, // نص الموسم
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Row( // نوع الرحلة
                      children: [
                        const Icon(
                          Icons.family_restroom, // أيقونة العائلة
                          color: Colors.yellow,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          tripTypeText, // نص نوع الرحلة
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
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
