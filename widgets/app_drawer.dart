import 'package:flutter/material.dart'; // استيراد مكتبة Flutter الأساسية لعناصر Material Design
import '../screens/filters_screen.dart'; // استيراد شاشة الفلاتر
import '../screens/aboutUs.dart'; // استيراد شاشة "حول التطبيق" (تأكد من اسم الملف)

class AppDrawer extends StatelessWidget { // إنشاء قائمة جانبية Drawer كـ StatelessWidget
  const AppDrawer({Key? key}) : super(key: key); // الكونستركتور الأساسي مع مفتاح اختياري

  // دالة مساعدة لإنشاء عنصر قائمة (ListTile) قابل لإعادة الاستخدام
  Widget buildListTile(String title, IconData icon, VoidCallback onTapLink) {
    return ListTile(
      leading: Icon(icon, size: 30, color: Colors.blue), // الأيقونة على اليسار
      title: Text(
        title, // النص الرئيسي للعنصر
        style: const TextStyle(
          fontFamily: 'ElMessiri', // نوع الخط
          fontSize: 24, // حجم الخط
          fontWeight: FontWeight.bold, // سمك الخط
        ),
      ),
      onTap: onTapLink, // الدالة التي تنفذ عند الضغط على العنصر
    );
  }

  @override
  Widget build(BuildContext context) { // دالة بناء واجهة القائمة الجانبية
    return Drawer( // ويدجت Drawer من Flutter
      child: Column( // ترتيب العناصر عمودياً
        children: [
          Container( // رأس القائمة الجانبية
            height: 100, // ارتفاع الرأس
            width: double.infinity, // كامل عرض الشاشة
            padding: const EdgeInsets.only(top: 40), // مسافة من الأعلى
            alignment: Alignment.center, // محاذاة النص في الوسط
            color: Colors.blue, // خلفية زرقاء للرأس
            child: const Text(
              'دليلك السياحي', // عنوان الرأس
              style: TextStyle(
                color: Colors.white, // لون النص أبيض
                fontSize: 24, // حجم الخط
                fontWeight: FontWeight.bold, // سمك الخط
              ),
            ),
          ),
          const SizedBox(height: 20), // مسافة فارغة بين الرأس والعناصر

          // عنصر قائمة الرحلات
          buildListTile('الرحلات', Icons.card_travel, () {
            Navigator.of(context).pushReplacementNamed('/');
            // الانتقال للشاشة الرئيسية مع استبدال الشاشة الحالية
          }),

          // عنصر قائمة الفلترة
          buildListTile('الفلترة', Icons.filter_list, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.screenRoute);
            // الانتقال لشاشة الفلاتر
          }),

          // عنصر قائمة حول التطبيق
          buildListTile('حول التطبيق', Icons.info_outline, () {
            Navigator.of(context).pushReplacementNamed(AboutUsScreen.screenRoute);
            // الانتقال لشاشة "حول التطبيق"
          }),
        ],
      ),
    );
  }
}
