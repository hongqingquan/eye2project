import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_eye_2_project/extenions/theme.dart';
import 'package:oktoast/oktoast.dart';

import '../widgets/base/dialog.dart';
import '../widgets/base/show_custom_dialog.dart';
import 'patient_archive.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  State<PatientListPage> createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  bool isEdit = false;

  List<PatientInfo> patientList = [
    PatientInfo(name: '刘一', id: '12345678900', age: '18', time: '2024年3月28日 10:18:54'),
    PatientInfo(name: '钱二', id: '12345678901', age: '18', time: '2024年3月28日 10:18:54'),
    PatientInfo(name: '张三', id: '12345678902', age: '18', time: '2024年3月28日 10:18:54'),
    PatientInfo(name: '李四', id: '12345678903', age: '18', time: '2024年3月28日 10:18:54'),
    PatientInfo(name: '王五', id: '12345678904', age: '18', time: '2024年3月28日 10:18:54'),
    PatientInfo(name: '赵六', id: '12345678905', age: '18', time: '2024年3月28日 10:18:54'),
    PatientInfo(name: '孙七', id: '12345678906', age: '18', time: '2024年3月28日 10:18:54'),
    PatientInfo(name: '周八', id: '12345678907', age: '18', time: '2024年3月28日 10:18:54'),
    PatientInfo(name: '吴九', id: '12345678908', age: '18', time: '2024年3月28日 10:18:54'),
    PatientInfo(name: '郑十', id: '12345678909', age: '18', time: '2024年3月28日 10:18:54')
  ];

  List<PatientInfo> get selectedList => patientList.where((it) => it.isSelected == true).toList();

  bool get isAllSelected => patientList.every((it) => it.isSelected == true);

  void _selectAll() {
    for (var it in patientList) {
      it.isSelected = true;
    }
    setState(() {});
  }

  void _unSelectAll() {
    for (var it in patientList) {
      it.isSelected = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: isEdit ? false : true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          isEdit ? '已选择${selectedList.length}项' : '患者档案',
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
            if (isEdit) {
              isEdit = false;
              _unSelectAll();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          if (isEdit)
            InkWell(
              onTap: () {
                if (isAllSelected) {
                  _unSelectAll();
                } else {
                  _selectAll();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                child: Image.asset(
                  isAllSelected ? 'assets/images/position_icon_batch2.png' : 'assets/images/position_icon_batch.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
            )
          else
            InkWell(
              onTap: () {
                setState(() {
                  isEdit = true;
                });
              },
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
            AnimatedCrossFade(
              firstChild: _Search(
                onSearch: () {},
              ),
              secondChild: const SizedBox(
                width: double.infinity,
              ),
              crossFadeState: isEdit ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: patientList.length,
                itemExtent: 82,
                itemBuilder: (context, index) {
                  final info = patientList[index];
                  return _PatientItem(
                    key: ValueKey(info.id),
                    info: info,
                    isEdit: isEdit,
                    onLongPress: () {
                      setState(() {
                        if (!isEdit) {
                          isEdit = true;
                        }
                        info.isSelected = true;
                      });
                    },
                    onSelect: () {
                      setState(() {
                        info.isSelected = !info.isSelected;
                      });
                    },
                  );
                },
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox(
                width: double.infinity,
              ),
              secondChild: _Bottom(
                onDelete: _onDelete,
                onShare: _onShare,
                onPrint: _onPrint,
              ),
              crossFadeState: isEdit ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }

  void _onDelete() {
    showBKDialog(
      context: context,
      builder: (context) {
        return const _DeleteDialog();
      },
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

class _Search extends StatefulWidget {
  const _Search({super.key, required this.onSearch});

  final VoidCallback onSearch;

  @override
  State<_Search> createState() => _SearchState();
}

class _SearchState extends State<_Search> {
  final TextEditingController _textController = TextEditingController();

  bool showCancel = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xfff1f2f2)),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/position_icon_img_12.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                    color: context.colorScheme.secondary,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TextField(
                      maxLength: 11,
                      maxLines: 1,
                      controller: _textController,
                      keyboardType: TextInputType.text,
                      style: context.textTheme.titleMedium,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {},
                      onChanged: (value) {
                        setState(() {
                          if (_textController.text.isNotEmpty) {
                            showCancel = true;
                          } else {
                            showCancel = false;
                          }
                        });
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        isDense: true,
                        isCollapsed: true,
                        hintText: '输入患者信息',
                        hintStyle: context.textTheme.titleMedium?.copyWith(
                          color: const Color(0xFFCECECE),
                        ),
                      ),
                    ),
                  ),
                  if (showCancel)
                    IconButton(
                      onPressed: () {
                        _textController.clear();
                        setState(() {
                          showCancel = false;
                        });
                      },
                      padding: const EdgeInsets.all(16),
                      icon: const Icon(
                        Icons.close,
                        size: 11,
                      ),
                    )
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(
              height: 40,
            ),
            secondChild: InkWell(
              onTap: () {
                _textController.clear();
                setState(() {
                  showCancel = false;
                });
              },
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 22, right: 14),
                alignment: Alignment.center,
                child: Text(
                  '取消',
                  style: context.textTheme.titleMedium,
                  maxLines: 1,
                ),
              ),
            ),
            crossFadeState: showCancel ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          )
        ],
      ),
    );
  }
}

class _PatientItem extends StatelessWidget {
  const _PatientItem({
    super.key,
    required this.info,
    required this.onLongPress,
    required this.onSelect,
    this.isEdit = false,
  });

  final PatientInfo info;

  final VoidCallback onLongPress;

  final VoidCallback onSelect;

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isEdit) {
          onSelect();
        } else {
          _toPatientArchivePage(context);
        }
      },
      onLongPress: onLongPress,
      child: Row(
        children: [
          AnimatedCrossFade(
            firstChild: const SizedBox(
              height: 70,
            ),
            secondChild: Padding(
              padding: const EdgeInsets.only(left: 2, right: 14),
              child: Image.asset(
                info.isSelected
                    ? 'assets/images/position_control_select2.png'
                    : 'assets/images/position_control_select.png',
                width: 16,
                height: 16,
                fit: BoxFit.contain,
              ),
            ),
            crossFadeState: isEdit ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 70,
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
              ),
              clipBehavior: Clip.hardEdge,
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: double.infinity,
                    color: const Color(0xffb7e3f4),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: _InfoItem(
                                title: '病历号',
                                content: info.id,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              flex: 1,
                              child: _InfoItem(
                                title: '姓名',
                                content: info.name,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              flex: 1,
                              child: _InfoItem(
                                title: '年龄',
                                content: '${info.age}岁',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          info.time,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toPatientArchivePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientArchivePage(patientInfo: info)));
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
            color: const Color(0xff999999),
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
  const _Bottom({super.key, required this.onDelete, required this.onShare, required this.onPrint});

  final VoidCallback onDelete;

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
            onTap: onDelete,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset(
                'assets/images/position_icon2_delete.png',
                width: 47,
                height: 47,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                '删除',
                style: context.textTheme.titleMedium,
              )
            ]),
          ),
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

class _DeleteDialog extends StatefulWidget {
  const _DeleteDialog({super.key});

  @override
  State<_DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<_DeleteDialog> {
  final _codeController = TextEditingController();

  bool obscureCode = true;

  @override
  Widget build(BuildContext context) {
    return BKDialog(
      isTextColorPrimary: true,
      text: '确认',
      onPrimaryTap: () {
        _delete();
        Navigator.of(context).pop();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            '确定删除选择的患者信息吗？',
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 208,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/position_icon_img_5.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: TextField(
                    maxLength: 6,
                    maxLines: 1,
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    style: context.textTheme.titleMedium,
                    obscureText: obscureCode,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onEditingComplete: () {},
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      isDense: true,
                      isCollapsed: true,
                      hintText: '输入安全密码',
                      hintStyle: context.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFFCECECE),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                _codeController.text.isNotEmpty
                    ? InkWell(
                        onTap: () => setState(() => obscureCode = !obscureCode),
                        child: Image.asset(
                          'assets/images/position_icon_${obscureCode ? 'invisible' : 'visible'}.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                      )
                    : const SizedBox(
                        width: 20,
                      ),
              ],
            ),
          ),
          const SizedBox(
            height: 44,
          ),
        ],
      ),
    );
  }

  void _delete() {
    // todo 删除
  }
}

class PatientInfo {
  final String name;
  final String id;
  final String age;
  final String time;
  bool isSelected;

  PatientInfo({required this.name, required this.id, required this.age, required this.time, this.isSelected = false});
}
