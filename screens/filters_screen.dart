import 'package:flutter/material.dart'; // استيراد مكتبة Flutter الأساسية لعناصر Material Design
import '../widgets/app_drawer.dart';   // استيراد Drawer مخصص للشاشة الجانبية

class FiltersScreen extends StatefulWidget { // تعريف شاشة جديدة StatefulWidget لأن البيانات تتغير
  static const screenRoute = '/filters';   // مسار ثابت لاستخدامه مع Navigator

  final Function saveFilters;              // دالة لإرسال القيم المختارة للشاشة السابقة
  final Map<String, bool> currentFilters; // القيم الحالية للفلاتر عند فتح الشاشة

  FiltersScreen(this.currentFilters, this.saveFilters); // الكونستركتور لتخزين القيم والدالة

  @override
  _FiltersScreenState createState() => _FiltersScreenState(); // إنشاء الحالة المرتبطة بالشاشة
}

class _FiltersScreenState extends State<FiltersScreen> { // تعريف الحالة State للشاشة
  var _summer = false; // متغير لتخزين حالة الفلتر الصيفي
  var _winter = false; // متغير لتخزين حالة الفلتر الشتوي
  var _family = false; // متغير لتخزين حالة فلتر العائلات

  @override
  initState() { // دالة دورة حياة initState() تُستدعى مرة واحدة عند إنشاء الشاشة
    _summer = widget.currentFilters['summer'] ?? false; // تهيئة قيمة الفلتر الصيفي
    _winter = widget.currentFilters['winter'] ?? false; // تهيئة قيمة الفلتر الشتوي
    _family = widget.currentFilters['family'] ?? false; // تهيئة قيمة فلتر العائلات
    super.initState(); // استدعاء initState() للأب لضمان التهيئة الداخلية
  }

  //هذا يسمح لعمل مفتاح مع عنوان، وصف، وحالة التشغيل، ودالة للتغيير بدون تكرار الكود لكل مفتاح.
  // دالة مساعدة لإنشاء SwitchListTile لأي مفتاح
  Widget buildSwitchListTile(
      String title,                 // عنوان المفتاح
      String subtitle,              // وصف المفتاح
      bool currentValue,            // القيمة الحالية (تشغيل/إيقاف)
      void Function(bool) updateValue // الدالة التي تتنفذ عند تغيير المفتاح
      ) {
    return SwitchListTile(
      title: Text(title),           // عرض العنوان
      subtitle: Text(subtitle),     // عرض الوصف
      value: currentValue,          // الحالة الحالية للمفتاح
      onChanged: updateValue,       // عند التغيير نفذ الدالة
    );
  }

  @override
  Widget build(BuildContext context) { // دالة بناء واجهة المستخدم
    return Scaffold( // الهيكل الأساسي للشاشة
      appBar: AppBar( // شريط أعلى الشاشة
        title: Text('الفلترة'), // عنوان الشريط
        actions: [ // عناصر الشريط الإضافية
          IconButton( // زر الحفظ
            icon: Icon(Icons.save), // أيقونة الحفظ
            onPressed: () { // عند الضغط على الزر
              final selectedFilters = { // إنشاء خريطة القيم المختارة
                'summer': _summer,
                'winter': _winter,
                'family': _family,
              };
              widget.saveFilters(selectedFilters); // إرسال القيم للشاشة السابقة
            },
          )
        ],
      ),
      drawer: AppDrawer(), // إضافة القائمة الجانبية المخصصة
      body: Column( // ترتيب المحتوى عموديًا
        children: [
          SizedBox(height: 50), // مسافة فارغة أعلى الشاشة
          Expanded( // لجعل القائمة تأخذ المساحة المتبقية
            child: ListView( // قائمة قابلة للتمرير
              children: [
                buildSwitchListTile( // مفتاح الرحلات الصيفية
                  'الرحلات الصيفية فقط',
                  'إظهار الرحلات في فصل الصيف فقط',
                  _summer, // القيمة الحالية
                      (newValue) { // الدالة عند تغيير المفتاح
                    setState(() {
                      _summer = newValue; // تحديث المتغير وإعادة البناء
                    });
                  },
                ),
                buildSwitchListTile( // مفتاح الرحلات الشتوية
                  'الرحلات الشتوية فقط',
                  'إظهار الرحلات في فصل الشتاء فقط',
                  _winter,
                      (newValue) {
                    setState(() {
                      _winter = newValue;
                    });
                  },
                ),
                buildSwitchListTile( // مفتاح الرحلات للعائلات
                  'للعائلات',
                  'إظهار الرحلات التي للعائلات فقط',
                  _family,
                      (newValue) {
                    setState(() {
                      _family = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
