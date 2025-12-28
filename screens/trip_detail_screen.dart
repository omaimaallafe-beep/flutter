import 'package:flutter/material.dart'; // استيراد مكتبة Flutter الأساسية
import '/app_data.dart'; // استيراد ملف البيانات (الرحلات)

class TripDetailScreen extends StatelessWidget { // شاشة تفاصيل الرحلة (ثابتة لا تتغير حالتها)
  static const screenRoute = '/trip-detail'; // اسم الـ route لهذه الشاشة

  //final تعني أن قيمة المتغير لا يمكن تغييرها بعد تعيينها لأول مرة.
  final Function manageFavorite; // دالة لإضافة/إزالة الرحلة من المفضلة
  final Function isFavorite; // دالة للتحقق هل الرحلة مفضلة أم لا

  TripDetailScreen(this.manageFavorite, this.isFavorite); // constructor لاستقبال الدوال

  // ===== دالة لبناء عنوان القسم (تحسين وتنظيم للكود) =====
  Widget buildSectionTitle(BuildContext context, String titleText) {
    return Container( // حاوية للعنوان
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10), // مسافة خارجية
      alignment: Alignment.topRight, // محاذاة النص لليمين
      child: Text( // نص العنوان
        titleText, // النص القادم للدالة
        style: Theme.of(context).textTheme.headlineSmall, // تنسيق من الثيم
      ),
    );
  }




  // ===== دالة لبناء كونتينر يحتوي ListView =====
  Widget buildListViewContainer(Widget child) { // تستقبل ويدجت
    return Container( // حاوية
      decoration: BoxDecoration(
        color: Colors.white, // لون الخلفية أبيض
        border: Border.all(color: Colors.grey), // إطار رمادي
        borderRadius: BorderRadius.circular(10), // حواف دائرية
      ),
      height: 200, // ارتفاع ثابت
      padding: EdgeInsets.all(10), // مسافة داخلية
      margin: EdgeInsets.symmetric(horizontal: 15), // مسافة خارجية
      child: child, // الويدجت المرسلة (ListView)
    );
  }

  @override
  Widget build(BuildContext context) { // دالة بناء واجهة الشاشة

    final tripId =
    ModalRoute.of(context)!.settings.arguments as String;
    // استلام id الرحلة من الشاشة السابقة

    final selectedTrip =
    Trips_data.firstWhere((trip) => trip.id == tripId);
    // جلب الرحلة التي id متاعها يساوي tripId

    return Scaffold( // الهيكل العام للشاشة
      appBar: AppBar( // شريط العنوان
        title: Text('${selectedTrip.title}'), // عرض اسم الرحلة
        actions: [ // أيقونات في يمين AppBar
          IconButton(
            icon: const Icon(Icons.share), // أيقونة مشاركة
            onPressed: () { // عند الضغط
              ScaffoldMessenger.of(context).showSnackBar( // عرض رسالة
                SnackBar(  // رسالة تطلع اسفل الشاشة
                  content: const Text(
                    'تم نسخ رابط الرحلة لمشاركتها!', // نص الرسالة
                    textAlign: TextAlign.center, // توسيط النص
                    style: TextStyle(fontFamily: 'ElMessiri'), // نوع الخط
                  ),
                  backgroundColor: Colors.orange, // لون الخلفية
                  duration: const Duration(seconds: 2), // مدة الظهور
                  behavior: SnackBarBehavior.floating, // تطفو فوق الشاشة
                  margin: const EdgeInsets.all(20), // مسافة من الحواف
                  shape: RoundedRectangleBorder( // شكل الرسالة
                    borderRadius: BorderRadius.circular(10), // حواف دائرية
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView( // يسمح بالتمرير
        child: Column( // ترتيب العناصر عموديًا
          children: [
            Container( // حاوية الصورة
              height: 300, // ارتفاع الصورة
              width: double.infinity, // عرض كامل الشاشة
              child: Image.network(
                selectedTrip.imageUrl, // رابط الصورة
                fit: BoxFit.cover, // الصورة تغطي المساحة
              ),
            ),

            SizedBox(height: 10), // مسافة عمودية

            buildSectionTitle(context, 'الأنشطة'), // عنوان قسم الأنشطة

            buildListViewContainer( // حاوية قائمة الأنشطة
              ListView.builder(
                itemCount: selectedTrip.activities.length, // عدد الأنشطة
                itemBuilder: (ctx, index) => Card( // بطاقة لكل نشاط
                  elevation: 0.3, // ظل خفيف
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedTrip.activities[index], // نص النشاط
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10), // مسافة

            buildSectionTitle(context, 'البرنامج اليومي'), // عنوان البرنامج

            buildListViewContainer( // حاوية البرنامج
              ListView.builder(
                itemCount: selectedTrip.program.length, // عدد الأيام
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile( // عنصر قائمة
                      leading: CircleAvatar( // دائرة اليوم
                        backgroundColor: Colors.orange, // لون الدائرة
                        foregroundColor: Colors.black, // لون النص
                        child: Text('يوم ${index + 1}'), // رقم اليوم
                      ),
                      title: Text(
                        selectedTrip.program[index], // برنامج اليوم
                      ),
                    ),
                    Divider(), // خط فاصل
                  ],
                ),
              ),
            ),

            SizedBox(height: 100), // مسافة أسفل الصفحة
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton( // زر عائم
        backgroundColor: Colors.orange, // لون الزر
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // شكل دائري
        ),
        foregroundColor: Colors.black, // لون الأيقونة
        child: Icon(
          isFavorite(tripId)
              ? Icons.star // نجمة مملوءة إذا مفضلة
              : Icons.star_border, // نجمة فارغة إذا لا
        ),
        onPressed: () => manageFavorite(tripId), // إضافة/إزالة من المفضلة
      ),
    );
  }
}
