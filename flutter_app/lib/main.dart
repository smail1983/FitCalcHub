import 'package:flutter/material.dart';

void main() => runApp(const FitCalcHubApp());

const emerald = Color(0xFF10B981);
const deepEmerald = Color(0xFF047857);
const ink = Color(0xFF0F172A);
const soft = Color(0xFFF4FBF8);

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
      cardTheme: CardThemeData(color: Colors.white, elevation: 2, shadowColor: const Color(0x220F172A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
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
        selectedIndex: tab, onDestinationSelected: (i) => setState(() => tab=i),
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
    padding: const EdgeInsets.fromLTRB(20,18,20,8),
    child: Row(children: [
      Container(width:48,height:48,decoration:BoxDecoration(
        gradient: const LinearGradient(colors:[emerald,deepEmerald]), borderRadius:BorderRadius.circular(16),
        boxShadow:const [BoxShadow(color:Color(0x3310B981),blurRadius:18,offset:Offset(0,8))]),
        child:const Icon(Icons.favorite_rounded,color:Colors.white,size:25)),
      const SizedBox(width:13),
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(title,style:const TextStyle(fontSize:22,fontWeight:FontWeight.w800,color:ink)),
        const SizedBox(height:2), Text(subtitle,style:const TextStyle(color:Color(0xFF64748B),fontSize:13))
      ]))
    ])
  );
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding:const EdgeInsets.only(bottom:24),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      const AppHeader(title:'FitCalcHub',subtitle:'Your everyday health toolkit'),
      Container(
        margin:const EdgeInsets.fromLTRB(20,18,20,24), padding:const EdgeInsets.all(24),
        decoration:BoxDecoration(
          gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFFECFDF5),Color(0xFFD1FAE5)]),
          borderRadius:BorderRadius.circular(30), border:Border.all(color:Color(0xFFBBF7D0))),
        child:Stack(children:[
          Positioned(right:-22,top:-30,child:Icon(Icons.auto_graph_rounded,size:145,color:emerald.withOpacity(.10))),
          Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            const Text('Build healthier habits',style:TextStyle(fontSize:27,fontWeight:FontWeight.w900,color:ink)),
            const SizedBox(height:9),
            const Text('Simple calculators for calories, body composition and daily energy needs.',style:TextStyle(height:1.45,color:Color(0xFF475569))),
            const SizedBox(height:20),
            FilledButton.icon(onPressed:(){},icon:const Icon(Icons.calculate_outlined),label:const Text('Explore calculators'),
              style:FilledButton.styleFrom(backgroundColor:deepEmerald,padding:const EdgeInsets.symmetric(horizontal:18,vertical:13)))
          ])
        ])
      ),
      const SectionTitle('Popular tools'),
      Padding(padding:const EdgeInsets.symmetric(horizontal:20),child:Row(children:[
        Expanded(child:ToolCard(icon:Icons.monitor_weight_outlined,title:'BMI',subtitle:'Body mass index')),
        const SizedBox(width:12),Expanded(child:ToolCard(icon:Icons.local_fire_department_outlined,title:'TDEE',subtitle:'Daily energy needs'))
      ])),
      const SizedBox(height:12),
      Padding(padding:const EdgeInsets.symmetric(horizontal:20),child:Row(children:[
        Expanded(child:ToolCard(icon:Icons.accessibility_new_outlined,title:'Body Fat',subtitle:'Body composition')),
        const SizedBox(width:12),Expanded(child:ToolCard(icon:Icons.restaurant_outlined,title:'Calories',subtitle:'Nutrition planning'))
      ])),
      const SizedBox(height:24), const SectionTitle('Daily tip'),
      Container(margin:const EdgeInsets.symmetric(horizontal:20),padding:const EdgeInsets.all(20),
        decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(24),boxShadow:const [BoxShadow(color:Color(0x120F172A),blurRadius:20,offset:Offset(0,8))]),
        child:const Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Icon(Icons.lightbulb_outline_rounded,color:emerald,size:28),SizedBox(width:14),
          Expanded(child:Text('Use your calculator results as a starting point and focus on consistent habits over time.',style:TextStyle(color:Color(0xFF475569),height:1.45)))
        ]))
    ])
  );
}

class SectionTitle extends StatelessWidget {
  final String text; const SectionTitle(this.text,{super.key});
  @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.fromLTRB(20,0,20,12),
    child:Text(text,style:const TextStyle(fontSize:18,fontWeight:FontWeight.w800,color:ink)));
}

class ToolCard extends StatelessWidget {
  final IconData icon; final String title,subtitle;
  const ToolCard({super.key,required this.icon,required this.title,required this.subtitle});
  @override Widget build(BuildContext context)=>Card(child:InkWell(borderRadius:BorderRadius.circular(24),onTap:(){},
    child:Padding(padding:const EdgeInsets.all(17),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Container(width:44,height:44,decoration:BoxDecoration(color:emerald.withOpacity(.11),borderRadius:BorderRadius.circular(14)),child:Icon(icon,color:deepEmerald)),
      const SizedBox(height:14),Text(title,style:const TextStyle(fontSize:17,fontWeight:FontWeight.w800,color:ink)),
      const SizedBox(height:4),Text(subtitle,style:const TextStyle(fontSize:12,color:Color(0xFF64748B)))
    ]))));
}

class CalculatorsTab extends StatelessWidget {
  const CalculatorsTab({super.key});
  @override Widget build(BuildContext context)=>Column(children:[
    const AppHeader(title:'Calculators',subtitle:'Choose a tool to get started'),
    Expanded(child:GridView.count(padding:const EdgeInsets.all(20),crossAxisCount:2,crossAxisSpacing:12,mainAxisSpacing:12,childAspectRatio:1.05,
      children:const[
        ToolCard(icon:Icons.monitor_weight_outlined,title:'BMI',subtitle:'Body mass index'),
        ToolCard(icon:Icons.local_fire_department_outlined,title:'TDEE',subtitle:'Daily energy'),
        ToolCard(icon:Icons.accessibility_new_outlined,title:'Body Fat',subtitle:'Body composition'),
        ToolCard(icon:Icons.restaurant_outlined,title:'Calories',subtitle:'Meal planning'),
        ToolCard(icon:Icons.bolt_outlined,title:'BMR',subtitle:'Basal metabolism'),
        ToolCard(icon:Icons.water_drop_outlined,title:'Water',subtitle:'Daily intake')
      ]))
  ]);
}

class ResultsTab extends StatelessWidget {
  const ResultsTab({super.key});
  @override Widget build(BuildContext context)=>Column(children:[
    const AppHeader(title:'Saved Results',subtitle:'Your local calculation history'),
    Expanded(child:Center(child:Column(mainAxisSize:MainAxisSize.min,children:[
      Container(width:76,height:76,decoration:BoxDecoration(color:emerald.withOpacity(.10),shape:BoxShape.circle),child:const Icon(Icons.history,color:deepEmerald,size:36)),
      const SizedBox(height:16),const Text('No saved results yet',style:TextStyle(fontSize:18,fontWeight:FontWeight.w800,color:ink)),
      const SizedBox(height:7),const Text('Your results can stay on this device.',style:TextStyle(color:Color(0xFF64748B)))
    ])))
  ]);
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.only(bottom:24),children:[
    const AppHeader(title:'Settings',subtitle:'Make FitCalcHub work for you'),
    const SizedBox(height:12),
    const SettingCard(icon:Icons.straighten,title:'Units',value:'Metric'),
    const SettingCard(icon:Icons.dark_mode_outlined,title:'Dark mode',value:'Off'),
    const SettingCard(icon:Icons.privacy_tip_outlined,title:'Privacy Policy',value:''),
    const SettingCard(icon:Icons.medical_information_outlined,title:'Medical Disclaimer',value:''),
    const SizedBox(height:22),const Center(child:Text('FitCalcHubApp  •  v1.0.0',style:TextStyle(color:Colors.blueGrey,fontSize:12)))
  ]);
}

class SettingCard extends StatelessWidget {
  final IconData icon; final String title,value;
  const SettingCard({super.key,required this.icon,required this.title,required this.value});
  @override Widget build(BuildContext context)=>Container(margin:const EdgeInsets.fromLTRB(20,6,20,6),
    decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(20)),
    child:ListTile(contentPadding:const EdgeInsets.symmetric(horizontal:18,vertical:3),
      leading:Container(width:42,height:42,decoration:BoxDecoration(color:emerald.withOpacity(.10),borderRadius:BorderRadius.circular(13)),child:Icon(icon,color:deepEmerald)),
      title:Text(title,style:const TextStyle(fontWeight:FontWeight.w700,color:ink)),
      trailing:value.isEmpty?const Icon(Icons.chevron_right):Text(value,style:const TextStyle(color:Color(0xFF64748B))))
  );
}
