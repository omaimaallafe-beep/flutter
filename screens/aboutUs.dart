import 'package:flutter/material.dart'; // استيراد مكتبة Flutter الأساسية

class AboutUsScreen extends StatelessWidget { // شاشة ثابتة لا تتغير State
  static const screenRoute = '/about-us'; // مسار الشاشة للاستخدام مع Navigator

  @override
  Widget build(BuildContext context) { // بناء واجهة المستخدم
    return Scaffold( // الهيكل الأساسي للشاشة
      appBar: AppBar( // شريط أعلى الشاشة
        title: const Text('حول التطبيق'), // عنوان AppBar
        centerTitle: true, // جعل النص في الوسط
      ),
      body: SingleChildScrollView( // لتتمكن من التمرير عند طول المحتوى
        child: Column( // ترتيب العناصر عموديًا
          children: [
            const SizedBox(height: 30), // مسافة فارغة أعلى الشاشة
            const Icon(Icons.school_outlined, size: 80, color: Colors.blue), // أيقونة تعبر عن مشروع جامعي
            const SizedBox(height: 20), // مسافة بين الأيقونة والنص
            const Text( // عنوان المشروع
              'مشروع مادة الـ Flutter',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'ElMessiri',
                color: Colors.blue,
              ),
            ),
            const Padding( // فقرة نصية مع حواف
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'تم تطوير تطبيق "ليبتيسنا" كمتطلب عملي لمادة برمجة تطبيقات الهواتف الذكية. يهدف المشروع إلى تسليط الضوء على المعالم السياحية في ليبيا باستخدام تقنيات Flutter الحديثة.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, height: 1.6, color: Colors.black87),
              ),
            ),

            const Divider(thickness: 1, indent: 40, endIndent: 40), // خط فاصل

            const SizedBox(height: 10), // مسافة قبل قسم الطالبات
            const Text( // عنوان قسم الطالبات
              'إعداد الطالبات:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            const SizedBox(height: 10), // مسافة صغيرة
            Card( // بطاقة تحتوي أسماء الطالبات
              margin: const EdgeInsets.symmetric(horizontal: 25),
              elevation: 4, // ظل خفيف
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // حواف مستديرة
              child: Column(
                children: const [
                  ListTile( // كل طالبة عنصر ListTile
                    leading: Icon(Icons.person_pin, color: Colors.blue),
                    title: Text('أية', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_pin, color: Colors.blue),
                    title: Text('ليبيا', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_pin, color: Colors.blue),
                    title: Text('أميمة', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30), // مسافة قبل قسم الإشراف
            const Text( // عنوان قسم الإشراف
              'تحت إشراف الدكتور:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5), // مسافة صغيرة
            const Text( // اسم المشرف
              'مصطفى قاباج',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri'
              ),
            ),

            const SizedBox(height: 40), // مسافة قبل الفصل الدراسي
            const Text( // السنة الدراسية
              'الفصل الدراسي 2025',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20), // مسافة نهائية أسفل الشاشة
          ],
        ),
      ),
    );
  }
}
