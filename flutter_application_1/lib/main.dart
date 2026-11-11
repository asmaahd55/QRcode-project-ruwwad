import 'package:flutter/material.dart';

import 'dart:async';

void main() {
  runApp(const MindGuideApp());
}

class MindGuideApp extends StatelessWidget {
  const MindGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'دليلك للتوازن النفسي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF8F5F0),
        primaryColor: const Color(0xFF5A8F76),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5A8F76),
          secondary: const Color(0xFF8BB19E),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: WelcomeNameScreen(),
      ),
    );
  }
}

class DirectionalityScaffold extends StatelessWidget {
  final Widget child;
  const DirectionalityScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: child);
  }
}

// =============================================================================
// 🏁 0. شاشة إدخال الاسم الأولية
// =============================================================================
class WelcomeNameScreen extends StatefulWidget {
  const WelcomeNameScreen({super.key});

  @override
  State<WelcomeNameScreen> createState() => _WelcomeNameScreenState();
}

class _WelcomeNameScreenState extends State<WelcomeNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submitName() {
    if (_formKey.currentState!.validate()) {
      String userName = _nameController.text.trim();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DirectionalityScaffold(
            child: MainNavigationScreen(userName: userName),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F0EA),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.eco,
                      size: 60,
                      color: Color(0xFF5A8F76),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    "أهلاً بك في مساحتك الآمنة 🌿",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E35),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "قبل الدخول لمساحتك الهادئة، ما هو الاسم الذي تحب أن نناديك به؟",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "يرجى كتابة اسمك أولاً للدخول";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "اكتب اسمك هنا...",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color(0xFF5A8F76),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A8F76),
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 2,
                    ),
                    onPressed: _submitName,
                    child: const Text(
                      "ادخل لمساحتك الآمنة ➔",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 🧭 حاوية التنقل الرئيسية (أزرار السفلي المعدلة خصيصاً لتجربة QR سريعة ومفيدة)
// =============================================================================
class MainNavigationScreen extends StatefulWidget {
  final String userName;
  const MainNavigationScreen({super.key, required this.userName});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(userName: widget.userName),
      const QuickTipsPage(), // زر إضافي: رسائل سريعة وإيجابية لليافع
      const CalmMomentsPage(), // زر إضافي: لحظات هدوء وتأمل قصيرة
      const AboutSpacePage(), // زر إضافي: دليل عن التطبيق وفكرته
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF5A8F76),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'رسائل إيجابية',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: 'تأمل سريع'),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'عن التطبيق',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 📱 1. الصفحة الرئيسية (تحديث الغيوم الكثيرة، الأشجار، والتخطيط)
// =============================================================================
class HomeScreen extends StatelessWidget {
  final String userName;
  const HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // الهيدر المحدث: غيوم كثيرة جداً، أشجار واسعة، وإنسان متأمل كبير واضح
              Container(
                height: 220,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD4E6DC), Color(0xFFE8F0EA)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFC2D9CC),
                    width: 1.5,
                  ),
                ),
                child: Stack(
                  children: [
                    // غيوم كثيرة ومتعددة الأحجام لتملأ الفراغ
                    Positioned(
                      top: 10,
                      left: 15,
                      child: Icon(
                        Icons.cloud,
                        size: 65,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      left: 95,
                      child: Icon(
                        Icons.cloud,
                        size: 50,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 170,
                      child: Icon(
                        Icons.cloud,
                        size: 40,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      right: 210,
                      child: Icon(
                        Icons.cloud,
                        size: 55,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),

                    // أشجار كثيرة تملأ الجزء العلوي الأيمن
                    Positioned(
                      top: 5,
                      right: 15,
                      child: Icon(
                        Icons.park,
                        size: 90,
                        color: const Color(0xFF5A8F76).withOpacity(0.7),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 85,
                      child: Icon(
                        Icons.forest,
                        size: 75,
                        color: const Color(0xFF5A8F76).withOpacity(0.5),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 145,
                      child: Icon(
                        Icons.park,
                        size: 65,
                        color: const Color(0xFF5A8F76).withOpacity(0.6),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      right: 200,
                      child: Icon(
                        Icons.park,
                        size: 55,
                        color: const Color(0xFF5A8F76).withOpacity(0.4),
                      ),
                    ),

                    // الشخص الجالس المتأمل والنص المرافق مكبر وواضح في اليمين تحت الشجرة
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.self_improvement,
                              size: 42,
                              color: Color(0xFF5A8F76),
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            "مساحة هادئة وطبيعية لتصفية الذهن 🌳",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E35),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // بطاقة الترحيب (بدون قلم) وبخط مكبر
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  "أهلاً يا $userName!\nمساحتك الآمنة واستعادة هدوئك.",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E35),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildMainCard(
                context,
                title: "تفريغ الشحنة والتنفس العميق",
                subtitle: "تمرين التنفس وصندوق التفريغ الرقمي",
                icon: Icons.bolt,
                color: const Color(0xFFE2EFCB),
                iconColor: Colors.amber.shade800,
                destination: const DischargeAndBreathingPage(),
              ),
              const SizedBox(height: 16),
              _buildMainCard(
                context,
                title: "أدوات سريعة للمود",
                subtitle: "أفكار وسلوكيات سريعة لمدة 10 دقائق",
                icon: Icons.palette,
                color: const Color(0xFFDCEAF5),
                iconColor: const Color(0xFF4A7C9D),
                destination: const QuickToolsPage(),
              ),
              const SizedBox(height: 16),
              _buildMainCard(
                context,
                title: "طلب الدعم والمساعدة",
                subtitle: "تواصل مباشر وإرفاق دليل المساندة",
                icon: Icons.handshake,
                color: const Color(0xFFE8E1EF),
                iconColor: const Color(0xFF7A5C91),
                destination: const SupportAndHelpPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required Widget destination,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DirectionalityScaffold(child: destination),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E35),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 💡 الصفحات الجديدة في شريط التنقل السفلي (مناسبة لزوار QR لفترة قصيرة)
// =============================================================================

// 1. صفحة رسائل إيجابية سريعة
class QuickTipsPage extends StatelessWidget {
  const QuickTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'رسائل إيجابية لليافعين',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5A8F76),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _TipCard(
            text: "خذ نفس عميق.. مشكلتك مو نهاية العالم، وكل شي بينحل بهدوء 🌿",
          ),
          SizedBox(height: 14),
          _TipCard(
            text: "أنت مو لحالك باللي عم تحسه، عادي تتعب وعادي ترتاح ☀️",
          ),
          SizedBox(height: 14),
          _TipCard(text: "خطوة صغيرة كل يوم بترجع لك توازنك وضحكتك ✨"),
          SizedBox(height: 14),
          _TipCard(
            text: "أحياناً بتجيك أفكار بتخوف أو بتزعجك، تذكر دائماً: الأفكار مو حقيقة، هي مجرد غيوم عابرة رح تمر وتصفى السما من جديد ☁️",
          ),
          SizedBox(height: 14),
          _TipCard(
            text: "أنك تحكي وتطلب المساعدة من شخص تثق فيه أو من مركز مختص، هي أجرأ وأقوى خطوة ممكن تعملها بحياتك. ما تخبي وجعك جواتك 🤝",
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final String text;
  const _TipCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
          color: Color(0xFF2C3E35),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// 2. صفحة تأمل سريع (مفيدة لمن يفتح عبر QR)
class CalmMomentsPage extends StatelessWidget {
  const CalmMomentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'لحظات تأمل سريع',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5A8F76),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0EA),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.self_improvement,
                    size: 60,
                    color: Color(0xFF5A8F76),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "توقف لـ 30 ثانية",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E35),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "أغمض عينيك، خذ نفساً عميقاً من أنفك، وأخرجه ببطء من فمك.\nاستشعر هدوء المكان حولك الآن ✨",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
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
}

// 3. صفحة عن التطبيق وفكرته لليافعين
class AboutSpacePage extends StatelessWidget {
  const AboutSpacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'عن مساحتك الآمنة',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF5A8F76),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "لماذا هذه المساحة؟ 🌿",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E35),
              ),
            ),
            SizedBox(height: 12),
            Text(
              "تم تصميم هذا التطبيق ليكون ملجأً لليافعين للمساعدة على تفريغ الضغوط النفسية، استعادة التركيز، وممارسة التمارين البسيطة التي تعيد التوازن في أي وقت وأي مكان.",
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "الخصوصية والأمان تامان تماماً ولا يتطلبان أي حفظ بيانات شخصية.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 🌩️ 2. الصفحة الثانية: تفريغ الشحنة والتنفس العميق
// =============================================================================
class DischargeAndBreathingPage extends StatefulWidget {
  const DischargeAndBreathingPage({super.key});

  @override
  State<DischargeAndBreathingPage> createState() =>
      _DischargeAndBreathingPageState();
}

class _DischargeAndBreathingPageState extends State<DischargeAndBreathingPage>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  late AnimationController _shredController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _isShredding = false;
  bool _isDischarged = false;

  Timer? _breathTimer;
  int _remainingSeconds = 10;
  bool _isBreathingActive = false;
  String _breathPhase = "شهيق";
  String _breathInstruction = "اضغط على الدائرة لبدء التمرين";
  double _circleScale = 1.0;

  @override
  void initState() {
    super.initState();
    _shredController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(parent: _shredController, curve: Curves.easeInBack),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _shredController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _shredController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _textController.clear();
          _isShredding = false;
          _isDischarged = true;
        });
        _shredController.reset();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text('تم تقطيع الورقة والتخلص من التوتر بنجاح! 🍃'),
            ),
            backgroundColor: Color(0xFF5A8F76),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  void _startBreathingExercise() {
    if (_isBreathingActive) return;

    setState(() {
      _isBreathingActive = true;
      _remainingSeconds = 10;
      _breathPhase = "شهيق";
      _breathInstruction = "خذ شهيقاً عميقاً ببطء...";
      _circleScale = 1.25;
    });

    _breathTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 1) {
          _remainingSeconds--;
          if (_remainingSeconds == 6) {
            _breathPhase = "حبس النفس";
            _breathInstruction = "احبس نفسك لثوانٍ...";
            _circleScale = 1.25;
          } else if (_remainingSeconds <= 5) {
            _breathPhase = "زفير";
            _breathInstruction = "أخرج الهواء ببطء وهدوء...";
            _circleScale = 0.95;
          }
        } else {
          _breathTimer?.cancel();
          _isBreathingActive = false;
          _breathPhase = "تم التمرين";
          _breathInstruction = "أحسنت! استشعر الهدوء والاسترخاء الآن ✨";
          _circleScale = 1.0;
        }
      });
    });
  }

  @override
  void dispose() {
    _breathTimer?.cancel();
    _shredController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _startShreddingProcess() {
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('اكتب أفكارك أولاً لتتمكن من تقطيعها!'),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() {
      _isShredding = true;
    });
    _shredController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تفريغ الشحنة والتنفس العميق',
          style: TextStyle(
            color: Color(0xFF2C3E35),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2C3E35)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7E6),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "تمرين التنفس العميق",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E35),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _breathInstruction,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _isBreathingActive
                          ? null
                          : _startBreathingExercise,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                        width: 130 * _circleScale,
                        height: 130 * _circleScale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE2EFCB).withOpacity(0.6),
                          border: Border.all(
                            color: const Color(0xFF5A8F76),
                            width: 5,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _isBreathingActive
                                    ? "$_remainingSeconds"
                                    : "ابدأ",
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E35),
                                ),
                              ),
                              Text(
                                _breathPhase,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5A8F76),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isBreathingActive
                            ? Colors.grey.shade400
                            : const Color(0xFF5A8F76),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ),
                      ),
                      onPressed: _isBreathingActive
                          ? null
                          : _startBreathingExercise,
                      child: Text(
                        _isBreathingActive
                            ? "التمرين جارٍ..."
                            : "اضغط هنا لبدء التمرين (10 ثوانٍ)",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1E6),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.edit_note,
                          color: Color(0xFF5A8F76),
                          size: 26,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "تفكير ومشاعر على الورق",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E35),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    AnimatedBuilder(
                      animation: _shredController,
                      builder: (context, child) {
                        if (_isShredding) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Transform.translate(
                              offset: Offset(0, _slideAnimation.value),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                  8,
                                  (index) => Container(
                                    width: 28,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: TextField(
                            controller: _textController,
                            maxLines: 4,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2C3E35),
                            ),
                            decoration: const InputDecoration(
                              hintText: "اكتب كل ما يزعجك هنا...\nفكّر فيها كأفكار عابرة على الورق.",
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A8F76),
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 2,
                      ),
                      onPressed: _isShredding ? null : _startShreddingProcess,
                      icon: const Icon(
                        Icons.content_cut,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: const Text(
                        "اكتب واقطع للتخلص من التوتر",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_isDischarged) ...[
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFF5A8F76),
                        size: 22,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "تم التفريغ وتقطيع الورقة! لقد أعدت الهدوء.",
                        style: TextStyle(
                          color: Color(0xFF2C3E35),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 🧩 3. الصفحة الثالثة: أدوات سريعة للمود (النقر حصراً على زر START)
// =============================================================================
class QuickToolsPage extends StatelessWidget {
  const QuickToolsPage({super.key});

  void _showToolAction(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F0EA),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 40, color: const Color(0xFF5A8F76)),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E35),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A8F76),
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "تم، ابدأ الآن ✨",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EEE3),
      appBar: AppBar(
        title: const Text(
          'أدوات سريعة للمود',
          style: TextStyle(
            color: Color(0xFF4A6B5D),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4A6B5D)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              // 🔌 القطعة الأولى: افصل الفيش
              Expanded(
                child: CustomPaint(
                  painter: PuzzlePiecePainter(
                    color: const Color(0xFFD3E2EE),
                    hasLeftTab: false,
                    hasRightTab: true,
                    hasBottomTab: true,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.power,
                                size: 46,
                                color: Color(0xFF1E3A8A),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.access_time_filled,
                                size: 46,
                                color: Color(0xFFEA580C),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "افصل الفيش",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E35),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "ابدأ 10 دقائق (تمرين للتوقف وإعادة الاتصال)",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => _showToolAction(
                            context,
                            "افصل الفيش 🔌",
                            "اترك الهاتف والمهام جانباً لمدة 10 دقائق كاملة، اذهب للشباك واستنشق هواءً نقيّاً لتعيد صفاء ذهنيك.",
                            Icons.power_off_rounded,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: const Text(
                              "START",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5A8F76),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // 🎈 القطعة الثانية: فجر البالون
              Expanded(
                child: CustomPaint(
                  painter: PuzzlePiecePainter(
                    color: const Color(0xFFF7D5C4),
                    hasLeftTab: true,
                    hasRightTab: true,
                    hasBottomTab: true,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.back_hand,
                                size: 44,
                                color: Color(0xFF9A3412),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.bubble_chart_rounded,
                                size: 46,
                                color: Color(0xFFE11D48),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "فجر البالون",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E35),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "ابدأ 10 دقائق (اكتب وافرغ للتنفس)",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => _showToolAction(
                            context,
                            "فجر البالون 🎈",
                            "تخيل الضغط النفسي والتوتر كأنه بالون كبير، اضغط عليه وافرقع الأفكار المزعجة لتتخلص منها نهائياً.",
                            Icons.bubble_chart_rounded,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: const Text(
                              "START",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5A8F76),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // 🚶 القطعة الثالثة: غير مكانك
              Expanded(
                child: CustomPaint(
                  painter: PuzzlePiecePainter(
                    color: const Color(0xFFDED3E7),
                    hasLeftTab: true,
                    hasRightTab: false,
                    hasBottomTab: false,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.menu_book,
                                size: 44,
                                color: Color(0xFF581C87),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.window,
                                size: 46,
                                color: Color(0xFF059669),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "غيّر مكانك",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E35),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "ابدأ 10 دقائق (غير المشهد لتغير الشعور)",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => _showToolAction(
                            context,
                            "غيّر مكانك 🚶",
                            "قم من موقعك الحالي، تجول قليلاً في البيت أو الحديقة، أو غيّر إضاءة الغرفة لكسر روتين التوتر.",
                            Icons.directions_walk_rounded,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: const Text(
                              "START",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5A8F76),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 🎨 رسام مخصص لقطع البازل المتشابكة الحقيقية (PuzzlePiecePainter)
// =============================================================================
class PuzzlePiecePainter extends CustomPainter {
  final Color color;
  final bool hasLeftTab;
  final bool hasRightTab;
  final bool hasBottomTab;

  PuzzlePiecePainter({
    required this.color,
    required this.hasLeftTab,
    required this.hasRightTab,
    required this.hasBottomTab,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    Path path = Path();
    double w = size.width;
    double h = size.height;
    double r = 16.0;

    path.moveTo(r, 0);
    path.lineTo(w - r, 0);
    path.quadraticBezierTo(w, 0, w, r);

    if (hasRightTab) {
      path.lineTo(w, h * 0.35);
      path.cubicTo(w + 14, h * 0.35, w + 14, h * 0.65, w, h * 0.65);
    }
    path.lineTo(w, h - r);
    path.quadraticBezierTo(w, h, w - r, h);

    if (hasBottomTab) {
      path.lineTo(w * 0.62, h);
      path.cubicTo(w * 0.62, h + 14, w * 0.38, h + 14, w * 0.38, h);
    }
    path.lineTo(r, h);
    path.quadraticBezierTo(0, h, 0, h - r);

    if (hasLeftTab) {
      path.lineTo(0, h * 0.65);
      path.cubicTo(0 - 14, h * 0.65, 0 - 14, h * 0.35, 0, h * 0.35);
    }
    path.lineTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);

    path.close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.08), 5, true);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// 🤝 4. الصفحة الرابعة: طلب الدعم والمساعدة
// =============================================================================
// =============================================================================
// 🤝 4. الصفحة الرابعة: طلب الدعم والمساعدة (حسب الشكل المطلوب تماماً)
// =============================================================================
class SupportAndHelpPage extends StatefulWidget {
  const SupportAndHelpPage({super.key});

  @override
  State<SupportAndHelpPage> createState() => _SupportAndHelpPageState();
}

class _SupportAndHelpPageState extends State<SupportAndHelpPage> {
  // محاكاة تنزيل ملف الدليل المرفق من فريق العمل بضغطة زر واحدة
  void _downloadTeamGuideFile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'جاري فتح وتحميل دليل المراكز والمستشارين المجاني (PDF)... 📥',
          ),
        ),
        backgroundColor: Color(0xFF5A8F76),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F0),
      appBar: AppBar(
        title: const Text(
          'طلب الدعم والمساعدة',
          style: TextStyle(
            color: Color(0xFF2C3E35),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2C3E35)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // بطاقة التنبيه والتشجيع العلوية
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7E6),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.mark_email_read,
                    color: Color(0xFF5A8F76),
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "مساعدتك قوة ومش ضعف!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // زر اتصال آمن (رقم رواد / التواصل)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5A8F76),
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'جاري الاتصال بخط الدعم الآمن لمؤسسة رواد التنمية... 📞',
                      ),
                    ),
                    backgroundColor: Color(0xFF5A8F76),
                  ),
                );
              },
              icon: const Icon(Icons.phone, color: Colors.white),
              label: const Text(
                "اتصال آمن",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // زر محادثة سرية
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7A5C91),
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text('جاري بدء المحادثة السرية والفورية... 🔒'),
                    ),
                    backgroundColor: Color(0xFF7A5C91),
                  ),
                );
              },
              icon: const Icon(Icons.lock, color: Colors.white),
              label: const Text(
                "محادثة سرية",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // خانة عرض الدليل المرفق من فريق العمل (جاهز للتحميل بضغطة واحدة دون بطاقات معقدة)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "دليل المراكز والمستشارين المجاني (مرفق فريق العمل)",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E35),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: _downloadTeamGuideFile,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF5A8F76),
                          width: 1.5,
                        ),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.cloud_download_rounded,
                            size: 42,
                            color: Color(0xFF5A8F76),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "اضغط هنا لتنزيل دليل المراكز والمستشارين المعتمد\n(ملف PDF جاهز للقراءة)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E35),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "لخصوصيتك، لا يتم حفظ أو تتبع أي بيانات شخصية.",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
