import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eye_2_project/pages/patients.dart';
import 'package:flutter_eye_2_project/pages/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 14,
                right: 22,
                child: InkWell(
                  onTap: () => _toSettingsPage(context),
                  child: Image.asset(
                    'assets/images/position_icon_settings.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 143,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/position_logo.png',
                      width: 53,
                      height: 53,
                      fit: BoxFit.contain,
                    ),
                    const Text(
                      '波克眼位采集系统',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff002846),
                        fontWeight: FontWeight.bold,
                        height: 1
                      )
                    )
                  ],
                ),
              ),
              const Positioned(
                top: 247,
                left: 30,
                right: 30,
                child: _Content(),
              ),
              Positioned(
                bottom: 26,
                right: 30,
                child: InkWell(
                  onTap: () => _toPatientsPage(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/position_icon2_archives.png',
                        width: 59,
                        height: 59,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16,),
                      const Text(
                        '患者档案',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff002846),
                          height: 1,
                        )
                      )
                    ],
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

  void _toSettingsPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SettingsPage()));
  }

  void _toPatientsPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const PatientsPage()));
  }

}

class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {

  final _codeController = TextEditingController();

  List<(String, String)> archives = [
    ('WJ75846', '张三'),
    ('WJ75847', '李四'),
    ('WJ75848', '王五'),
    ('WJ75849', '赵六'),
    ('WJ75850', '田七'),
    ('WJ75851', '钱八'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color(0xFFE8E8E8), width: 1),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/position_icon_img_1.png',
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        controller: _codeController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [],
                        onEditingComplete: () {},
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          isDense: true,
                          isCollapsed: true,
                          hintText: '输入病历号',
                          hintStyle: TextStyle(
                            color: Color(0xFFCECECE),
                            fontSize: 16,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () => _onCreateArchive(context),
              child: Container(
                width: 110,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF002846),
                ),
                alignment: Alignment.center,
                child: const Text('创建',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1,
                    )),
              ),
            )
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 183,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color(0xFFE8E8E8), width: 1),
                ),
                child: _buildArchiveList(context),
              ),
            ),
            const SizedBox(width: 122,),
          ],
        )
      ],
    );
  }

  Widget _buildArchiveList(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemBuilder: (context, index) {
        final item = archives[index];
        return SizedBox(
          width: double.infinity,
          height: 40,
          child: Row(
            children: [
              Image.asset(
                'assets/images/position_icon_img_2.png',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                '${item.$1} ${item.$2}',
                style: const TextStyle(
                    fontSize: 16, color: Color(0xFF002846), height: 1),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8E8));
      },
      itemCount: archives.length,
    );
  }

  void _onCreateArchive(BuildContext context) {

  }

  void _onStartArchive(BuildContext context) {

  }
}
