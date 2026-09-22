import 'package:flutter/material.dart';

void main() => runApp(const FitCalcHubApp());

const emerald = Color(0xFF10B981);
const deepEmerald = Color(0xFF047857);
const ink = Color(0xFF0F172A);
const soft = Color(0xFFF3FAF7);

class FitCalcHubApp extends StatelessWidget {
  const FitCalcHubApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'FitCalcHubApp',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: soft,
      colorScheme: ColorScheme.fromSeed(seedColor: emerald),
      cardTheme: CardThemeData(
        color: Colors.white, elevation: 1,
        shadowColor: const Color(0x180F172A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
    ),
    home: const HomeScreen(),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [const HomeTab(), const CalculatorsTab(), const ResultsTab(), const SettingsTab()];
    return Scaffold(
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        indicatorColor: emerald.withOpacity(.14),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Calculators'),
          NavigationDestination(icon: Icon(Icons.history_outlined), selectedIcon: Icon(Icons.history), label: 'Results'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  final String title, subtitle;
  const AppHeader({super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
    child: Row(children: [
      Container(width: 48, height: 48,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [emerald, deepEmerald]),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x3310B981), blurRadius: 18, offset: Offset(0, 8))]),
        child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 25)),
      const SizedBox(width: 13),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: ink)),
        const SizedBox(height: 2),
        Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
      ])),
    ]),
  );
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: 24),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const AppHeader(title: 'FitCalcHub', subtitle: 'Your everyday health toolkit'),
      Container(
        height: 275,
        margin: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: const [
          BoxShadow(color: Color(0x240F172A), blurRadius: 22, offset: Offset(0, 10))]),
        child: Stack(fit: StackFit.expand, children: [
          Image.asset('assets/fitcalchub-hero.svg', fit: BoxFit.cover),
          DecoratedBox(decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Colors.white.withOpacity(.92), Colors.white.withOpacity(.25), const Color(0xCC052E24)]))),
          Padding(padding: const EdgeInsets.all(24), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
              const Text('Build healthier habits', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: ink)),
              const SizedBox(height: 7),
              const Text('Simple tools for calories, body composition and daily energy.', style: TextStyle(color: Color(0xFF334155), height: 1.4)),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.calculate_outlined),
                label: const Text('Explore calculators'),
                style: FilledButton.styleFrom(backgroundColor: deepEmerald, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13))),
            ])),
        ]),
      ),
      const SectionTitle('Popular tools'),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(children: [
        Expanded(child: ToolCard(icon: Icons.monitor_weight_outlined, title: 'BMI', subtitle: 'Body mass index', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BmiPage())))),
        const SizedBox(width: 12),
        Expanded(child: ToolCard(icon: Icons.local_fire_department_outlined, title: 'TDEE', subtitle: 'Daily energy needs', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TdeePage())))),
      ])),
      const SizedBox(height: 12),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(children: [
        Expanded(child: ToolCard(icon: Icons.accessibility_new_outlined, title: 'Body Fat', subtitle: 'Body composition', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BodyFatPage())))),
        const SizedBox(width: 12),
        Expanded(child: ToolCard(icon: Icons.restaurant_outlined, title: 'Calories', subtitle: 'Nutrition planning', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CaloriesPage())))),
      ])),
      const SizedBox(height: 24),
      const SectionTitle('Daily tip'),
      Container(margin: const EdgeInsets.symmetric(horizontal: 20), padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.lightbulb_outline_rounded, color: emerald, size: 28), SizedBox(width: 14),
          Expanded(child: Text('Use your results as a starting point and focus on consistent habits over time.', style: TextStyle(color: Color(0xFF475569), height: 1.45))),
        ])),
    ]),
  );
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});
  @override Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
    child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ink)));
}

class ToolCard extends StatelessWidget {
  final IconData icon; final String title, subtitle; final VoidCallback? onTap;
  const ToolCard({super.key, required this.icon, required this.title, required this.subtitle, this.onTap});
  @override
  Widget build(BuildContext context) => Card(child: InkWell(
    borderRadius: BorderRadius.circular(22), onTap: onTap,
    child: Padding(padding: const EdgeInsets.all(17), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 44, height: 44, decoration: BoxDecoration(color: emerald.withOpacity(.11), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: deepEmerald)),
      const SizedBox(height: 14),
      Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 4),
      Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
    ])));
}

class CalculatorsTab extends StatelessWidget {
  const CalculatorsTab({super.key});
  @override
  Widget build(BuildContext context) => Column(children: [
    const AppHeader(title: 'Calculators', subtitle: 'Choose a tool to get started'),
    Expanded(child: GridView.count(padding: const EdgeInsets.all(20), crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12,
      children: [
        ToolCard(icon: Icons.monitor_weight_outlined, title: 'BMI', subtitle: 'Body mass index', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BmiPage()))),
        ToolCard(icon: Icons.local_fire_department_outlined, title: 'TDEE', subtitle: 'Daily energy', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TdeePage()))),
        ToolCard(icon: Icons.accessibility_new_outlined, title: 'Body Fat', subtitle: 'Body composition', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BodyFatPage()))),
        ToolCard(icon: Icons.restaurant_outlined, title: 'Calories', subtitle: 'Meal planning', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CaloriesPage()))),
        ToolCard(icon: Icons.bolt_outlined, title: 'BMR', subtitle: 'Basal metabolism', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BmrPage()))),
        ToolCard(icon: Icons.water_drop_outlined, title: 'Water', subtitle: 'Daily intake', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WaterPage()))),
      ])),
  ]);
}

class ResultsTab extends StatelessWidget {
  const ResultsTab({super.key});
  @override Widget build(BuildContext context) => Column(children: [
    const AppHeader(title: 'Saved Results', subtitle: 'Your local calculation history'),
    Expanded(child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 76, height: 76, decoration: BoxDecoration(color: emerald.withOpacity(.10), shape: BoxShape.circle), child: const Icon(Icons.history, color: deepEmerald, size: 36)),
      const SizedBox(height: 16),
      const Text('No saved results yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 7),
      const Text('Your results can stay on this device.', style: TextStyle(color: Color(0xFF64748B))),
    ]))),
  ]);
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.only(bottom: 24), children: [
    const AppHeader(title: 'Settings', subtitle: 'Make FitCalcHub work for you'),
    const SizedBox(height: 12),
    const SettingCard(icon: Icons.straighten, title: 'Units', value: 'Metric'),
    const SettingCard(icon: Icons.dark_mode_outlined, title: 'Dark mode', value: 'Off'),
    const SettingCard(icon: Icons.privacy_tip_outlined, title: 'Privacy Policy', value: ''),
    const SettingCard(icon: Icons.medical_information_outlined, title: 'Medical Disclaimer', value: ''),
    const SizedBox(height: 22),
    const Center(child: Text('FitCalcHubApp • v1.0.0', style: TextStyle(color: Colors.blueGrey, fontSize: 12))),
  ]);
}

class SettingCard extends StatelessWidget {
  final IconData icon; final String title, value;
  const SettingCard({super.key, required this.icon, required this.title, required this.value});
  @override Widget build(BuildContext context) => Container(margin: const EdgeInsets.fromLTRB(20, 6, 20, 6),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
      leading: Container(width: 42, height: 42, decoration: BoxDecoration(color: emerald.withOpacity(.10), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: deepEmerald)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: ink)),
      trailing: value.isEmpty ? const Icon(Icons.chevron_right) : Text(value, style: const TextStyle(color: Color(0xFF64748B))));
}

class CalculatorPage extends StatefulWidget {
  final String title, subtitle;
  final Widget form;
  const CalculatorPage({super.key, required this.title, required this.subtitle, required this.form});
  @override State<CalculatorPage> createState() => _CalculatorPageState();
}
class _CalculatorPageState extends State<CalculatorPage> {
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w800)), backgroundColor: soft),
    body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(widget.subtitle, style: const TextStyle(color: Color(0xFF64748B))), const SizedBox(height: 18), widget.form
    ])),
  );
}

class Input extends StatelessWidget {
  final String label, hint;
  final TextEditingController controller;
  const Input({super.key, required this.label, required this.controller, this.hint = ''});
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 14),
    child: TextField(controller: controller, keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label, hintText: hint, filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none))));
}

class ResultBox extends StatelessWidget {
  final String title, value;
  const ResultBox({super.key, required this.title, required this.value});
  @override Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFECFDF5), Color(0xFFD1FAE5)]), borderRadius: BorderRadius.circular(22)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Color(0xFF475569))), const SizedBox(height: 5),
      Text(value, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: deepEmerald)),
    ]));
}

class BmiPage extends StatefulWidget { const BmiPage({super.key}); @override State<BmiPage> createState()=>_BmiPageState(); }
class _BmiPageState extends State<BmiPage> {
  final h=TextEditingController(), w=TextEditingController(); String result='';
  @override Widget build(BuildContext c)=>CalculatorPage(title:'BMI Calculator',subtitle:'Estimate body mass index from height and weight.',form:Column(children:[
    Input(label:'Height (cm)',controller:h), Input(label:'Weight (kg)',controller:w),
    SizedBox(width:double.infinity,child:FilledButton(onPressed:(){final x=double.tryParse(h.text),y=double.tryParse(w.text);if(x!=null&&y!=null&&x>0){setState(()=>result=(y/((x/100)*(x/100))).toStringAsFixed(1));}},child:const Text('Calculate BMI'))),
    if(result.isNotEmpty)...[const SizedBox(height:18),ResultBox(title:'Your BMI',value:result)],
  ]));
}

class BmrPage extends StatefulWidget { const BmrPage({super.key}); @override State<BmrPage> createState()=>_BmrPageState(); }
class _BmrPageState extends State<BmrPage> {
  final w=TextEditingController(),h=TextEditingController(),a=TextEditingController(); String result='';
  @override Widget build(BuildContext c)=>CalculatorPage(title:'BMR Calculator',subtitle:'Mifflin-St Jeor estimate using metric units.',form:Column(children:[
    Input(label:'Weight (kg)',controller:w),Input(label:'Height (cm)',controller:h),Input(label:'Age',controller:a),
    SizedBox(width:double.infinity,child:FilledButton(onPressed:(){final x=double.tryParse(w.text),y=double.tryParse(h.text),z=double.tryParse(a.text);if(x!=null&&y!=null&&z!=null){setState(()=>result=(10*x+6.25*y-5*z+5).round().toString());}},child:const Text('Calculate BMR'))),
    if(result.isNotEmpty)...[const SizedBox(height:18),ResultBox(title:'Estimated BMR',value:'$result kcal/day')],
  ]));
}

class TdeePage extends StatefulWidget { const TdeePage({super.key}); @override State<TdeePage> createState()=>_TdeePageState(); }
class _TdeePageState extends State<TdeePage> {
  final b=TextEditingController(); String result='';
  @override Widget build(BuildContext c)=>CalculatorPage(title:'TDEE Calculator',subtitle:'Start with your BMR and an activity multiplier.',form:Column(children:[
    Input(label:'BMR (kcal/day)',controller:b),
    DropdownButtonFormField<double>(decoration:InputDecoration(labelText:'Activity level',filled:true,fillColor:Colors.white,border:OutlineInputBorder(borderRadius:BorderRadius.circular(16),borderSide:BorderSide.none)),initialValue:1.2,items:const[
      DropdownMenuItem(value:1.2,child:Text('Sedentary')),DropdownMenuItem(value:1.375,child:Text('Lightly active')),DropdownMenuItem(value:1.55,child:Text('Moderately active')),DropdownMenuItem(value:1.725,child:Text('Very active'))],onChanged:(v){if(v!=null) setState(()=>_activity=v);}),
    const SizedBox(height:14),SizedBox(width:double.infinity,child:FilledButton(onPressed:(){final x=double.tryParse(b.text);if(x!=null)setState(()=>result=(x*_activity).round().toString());},child:const Text('Calculate TDEE'))),
    if(result.isNotEmpty)...[const SizedBox(height:18),ResultBox(title:'Estimated TDEE',value:'$result kcal/day')],
  ]));
  double _activity=1.2;
}

class BodyFatPage extends StatelessWidget { const BodyFatPage({super.key}); @override Widget build(BuildContext c)=>const CalculatorPage(title:'Body Fat Calculator',subtitle:'US Navy method requires waist, neck and height.',form:Text('Enter measurements to calculate an estimate.')); }
class CaloriesPage extends StatelessWidget { const CaloriesPage({super.key}); @override Widget build(BuildContext c)=>const CalculatorPage(title:'Calorie Calculator',subtitle:'Plan daily calories around your target.',form:Text('Nutrition planning tools will be expanded in the next release.')); }
class WaterPage extends StatelessWidget { const WaterPage({super.key}); @override Widget build(BuildContext c)=>const CalculatorPage(title:'Water Calculator',subtitle:'A simple daily hydration estimate.',form:Text('Enter your body weight to estimate daily water intake.')); }
