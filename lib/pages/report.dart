import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_eye_2_project/extenions/theme.dart';
import 'package:flutter_eye_2_project/pages/patient_list.dart';
import 'package:oktoast/oktoast.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          '波克眼位采集系统',
        ),
        leadingWidth: 60,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/position_icon_back.png',
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Image.asset(
                'assets/images/position_icon_settings.png',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                      Text(
                        '总结报告',
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _PatientInfoView(
                        info: PatientInfo(id: '5879562', name: '刘小伟', time: '2024年3月28日 10:18:54', age: '29'),
                      ),
                      const SizedBox(height: 15),
                      const _LayoutWrap(
                        key: ValueKey('nine_position'),
                        child: _NinePositionPhoto(),
                      ),
                      const _LayoutWrap(
                        key: ValueKey('single_eye'),
                        child: _SingleEyePhoto(),
                      ),
                      const _LayoutWrap(
                        key: ValueKey('head_tilt_test'),
                        child: _HeadTiltTestPhoto(),
                      ),
                      const _LayoutWrap(
                        key: ValueKey('compensatory_head'),
                        child: _CompensatoryHeadPhoto(),
                      ),
                      const _LayoutWrap(
                        key: ValueKey('custom'),
                        child: _CustomPhoto(),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: Text.rich(TextSpan(style: context.textTheme.titleSmall, children: [
                          const TextSpan(text: '手术建议：'),
                          TextSpan(text: '建议尽快手术治疗', style: TextStyle(color: context.colorScheme.primary)),
                        ])),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: const Color(0xffb7e3f4),
                      ),
                      const SizedBox(height: 1),
                      Container(
                        width: double.infinity,
                        height: 5,
                        color: const Color(0xffb7e3f4),
                      ),
                      const SizedBox(height: 9),
                    ],
                  ),
                ),
              ),
            ),
            _Bottom(
              onShare: _onShare,
              onPrint: _onPrint,
            ),
          ],
        ),
      ),
    );
  }

  void _onShare() {
    // todo 分享
    showToast('分享功能待完成');
  }

  void _onPrint() {
    // todo 打印
    showToast('打印功能待完成');
  }
}

class _PatientInfoView extends StatelessWidget {
  const _PatientInfoView({super.key, required this.info});

  final PatientInfo info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 45),
      child: Column(children: [
        Container(
          width: double.infinity,
          height: 35,
          padding: const EdgeInsets.only(left: 25, right: 12),
          color: const Color(0xffb7e3f4),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: _InfoItem(
                  title: '病历号',
                  content: info.id,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 3,
                child: _InfoItem(
                  title: '姓名',
                  content: info.name,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 3,
                child: _InfoItem(
                  title: '年龄',
                  content: '${info.age}岁',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: const Color(0xffb7e3f4),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          info.time,
          style: context.textTheme.titleSmall?.copyWith(
            fontSize: 12,
          ),
        )
      ]),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title：',
          style: context.textTheme.titleSmall?.copyWith(
            fontSize: 13,
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: context.textTheme.titleSmall?.copyWith(
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({super.key, required this.onShare, required this.onPrint});

  final VoidCallback onShare;

  final VoidCallback onPrint;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.background,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onShare,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset(
                'assets/images/position_icon2_save.png',
                width: 47,
                height: 47,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                '分享',
                style: context.textTheme.titleMedium,
              )
            ]),
          ),
          InkWell(
            onTap: onPrint,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset(
                'assets/images/position_icon2_print.png',
                width: 47,
                height: 47,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                '打印',
                style: context.textTheme.titleMedium,
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class _LayoutWrap extends StatelessWidget {
  const _LayoutWrap({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
          width: 1,
        ),
        color: const Color(0xFFFAFAFA),
      ),
      child: child,
    );
  }
}

class _NinePositionPhoto extends StatelessWidget {
  const _NinePositionPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '眼球九方位拍照',
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        // todo 九方位图
        AspectRatio(
          aspectRatio: 314 / 104,
          child: Container(
            width: double.infinity,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text.rich(TextSpan(style: context.textTheme.titleSmall, children: [
          const TextSpan(text: '结论：'),
          TextSpan(text: '左眼内斜30度', style: TextStyle(color: context.colorScheme.primary)),
          const TextSpan(text: '，眼压正常，结膜无充血，角膜透明，前房正常，瞳孔圆，直径约3mm')
        ]))
      ],
    );
  }
}

class _SingleEyePhoto extends StatelessWidget {
  const _SingleEyePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '单眼注视拍照',
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(
          height: 20,
        ),
        // todo 单眼图
        Container(
          width: 178,
          height: 56,
          color: Colors.grey[300],
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: 178,
          height: 56,
          color: Colors.grey[300],
        ),
        const SizedBox(
          height: 12,
        ),
        Text.rich(TextSpan(style: context.textTheme.titleSmall, children: [
          const TextSpan(text: '结论：'),
          TextSpan(text: '左眼内斜30度', style: TextStyle(color: context.colorScheme.primary)),
          const TextSpan(text: '，眼压正常，结膜无充血，角膜透明，前房正常，瞳孔圆，直径约3mm')
        ]))
      ],
    );
  }
}

class _HeadTiltTestPhoto extends StatelessWidget {
  const _HeadTiltTestPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '歪头实验拍照',
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        // todo 歪头实验图
        Container(
          width: 280,
          height: 127,
          color: Colors.grey[300],
        ),
        const SizedBox(
          height: 12,
        ),
        Text.rich(TextSpan(style: context.textTheme.titleSmall, children: [
          const TextSpan(text: '结论：'),
          TextSpan(text: '左眼内斜30度', style: TextStyle(color: context.colorScheme.primary)),
          const TextSpan(text: '，眼压正常，结膜无充血，角膜透明，前房正常，瞳孔圆，直径约3mm')
        ]))
      ],
    );
  }
}

class _CompensatoryHeadPhoto extends StatelessWidget {
  const _CompensatoryHeadPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '代偿头位拍照',
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(
          height: 16,
        ),
        // todo 代偿头位图
        Container(
          width: 293,
          height: 192,
          color: Colors.grey[300],
        ),
        const SizedBox(
          height: 12,
        ),
        Text.rich(TextSpan(style: context.textTheme.titleSmall, children: [
          const TextSpan(text: '结论：'),
          TextSpan(text: '左眼内斜30度', style: TextStyle(color: context.colorScheme.primary)),
          const TextSpan(text: '，眼压正常，结膜无充血，角膜透明，前房正常，瞳孔圆，直径约3mm')
        ]))
      ],
    );
  }
}

class _CustomPhoto extends StatelessWidget {
  const _CustomPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '自定义拍照',
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(
          height: 20,
        ),
        // todo 歪头实验图
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 18,
            crossAxisSpacing: 12,
            childAspectRatio: 90 / 134,
          ),
          itemBuilder: (context, index) => const _CustomPhotoItem(),
          itemCount: 5,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

class _CustomPhotoItem extends StatelessWidget {
  const _CustomPhotoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // todo 自定义拍照图
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: double.infinity,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: context.colorScheme.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
            ),
            alignment: Alignment.center,
            child: Text('内眼斜视30°',
                style: context.textTheme.titleSmall?.copyWith(
                  fontSize: 12,
                )))
      ],
    );
  }
}
