import 'package:flutter/material.dart';
import 'dart:async'; // مكتبة خاصة بالـ Timers
import 'catogries_screen.dart';




// ====================================
// 1. تعريف StatefulWidget لشاشة البداية
// ====================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// ====================================
// 2. State الخاصة بالشاشة
// ====================================
class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0; // نسبة شريط التحميل

  // ====================================
  // 3. initState -> تعمل مرة واحدة عند إنشاء الشاشة
  // ====================================
  @override
  void initState() {
    super.initState();

    // --- شريط التحميل تدريجي ---
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.025; // زيادة 2.5%
        if (_progress >= 1.0) {
          _progress = 1.0;
          timer.cancel(); // إيقاف Timer عند اكتمال التحميل
        }
      });
    });

    // --- الانتقال للصفحة الرئيسية بعد 4 ثواني ---
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  // ====================================
  // 4. بناء واجهة المستخدم
  // ====================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // تغطي كامل الشاشة عرض
        height: double.infinity, // تغطي كامل الشاشة ارتفاع
        decoration: BoxDecoration(
          // --- خلفية متدرجة ---
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // توسيط عمودي
          children: [
            // --- شعار التطبيق ---
            Image.asset(
              'assests/images/LibyaMap.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),

            // --- اسم التطبيق ---
            const Text(
              'ليبتيسنا',
              style: TextStyle(
                fontFamily: 'ElMessiri',
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // --- نص صغير تحت العنوان ---
            const Text(
              'دليلك السياحي الليبي',
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 30),

            // --- شريط التحميل ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: LinearProgressIndicator(
                value: _progress, // نسبة التحميل
                backgroundColor: Colors.white24, // خلفية الشريط
                color: Colors.white, // لون الشريط
                minHeight: 5, // ارتفاع الشريط
              ),
            ),
            const SizedBox(height: 20),

            // --- نص الحقوق ---
            const Text(
              '© 2025 أية & ليبيا & اميمة',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
