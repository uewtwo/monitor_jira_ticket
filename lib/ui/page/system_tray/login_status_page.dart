import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:system_tray/system_tray.dart';

import '../../../data/model/config/jira_config.dart';
import '../../../data/provider/login_status_provider.dart';
import '../../../data/repository/jira_repository.dart';
import '../../../data/state/login_status.dart';
import '../../../util/api.dart';
import '../../../util/image.dart';

class LoginStatusPage extends HookConsumerWidget {
  final TextEditingController subDomainController;
  final TextEditingController jqlController;
  final TextEditingController emailController;
  final TextEditingController apiTokenController;
  final SystemTray systemTray;
  final Menu menu;

  const LoginStatusPage({
    required this.subDomainController,
    required this.jqlController,
    required this.emailController,
    required this.apiTokenController,
    required this.systemTray,
    required this.menu,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jiraConfig = JiraConfig();
    final loginStatus = ref.watch(loginStatusProvider);
    applyToTextField(jiraConfig);

    return Expanded(
      child: Container(
        color: const Color(0xFFFFFFFF),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          children: [
            formedCard(
              Column(
                children: [
                  TextField(
                    controller: subDomainController,
                    enabled: true,
                    decoration: const InputDecoration(
                      labelText: 'sub domain',
                      hintText: 'Enter your site name in Jira',
                    ),
                  ),
                  TextField(
                    controller: jqlController,
                    enabled: true,
                    decoration: const InputDecoration(
                      labelText: 'jql',
                      hintText:
                          'project = XXX AND status = Merged AND reporter = YYY',
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    enabled: true,
                    decoration: const InputDecoration(
                      labelText: 'email',
                      hintText: 'Enter your E-Mail',
                    ),
                  ),
                  TextField(
                    controller: apiTokenController,
                    enabled: true,
                    decoration: const InputDecoration(
                      labelText: 'api token',
                      hintText: 'Enter your api token',
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                    // child: Expanded(
                    child: Row(
                      children: [
                        Image.asset(getImagePath('dash-100')),
                        TextButton(
                          onPressed: () => _onPressed(
                            jiraConfig,
                            ref.read(loginStatusProvider.notifier),
                          ),
                          child: const Text('Save & Login'),
                        ),
                        Image.asset(getLoginStatusImagePath(loginStatus)),
                      ],
                    ),
                    // ),
                  )
                ],
              ),
            ),
            // ..._buildDebugMenu(),
          ],
        ),
      ),
    );
  }

  Card formedCard(Widget child) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }

  applyToTextField(JiraConfig jiraConfig) async {
    final loaded = await jiraConfig.load();
    emailController.text = loaded.userEmail;
    apiTokenController.text = loaded.apiToken;
    subDomainController.text = loaded.subDomain;
    jqlController.text = loaded.jql;
  }

  Future<void> _onPressed(
    JiraConfig jiraConfig,
    LoginStatus loginStatus,
  ) async {
    loginStatus.setState('loading');

    final savedConfig = await _onSave(jiraConfig);

    final result = await JiraSearchRepository(
      dio: Dio(BaseOptions(
        baseUrl: getBaseApiUrl(savedConfig.subDomain),
      )),
    ).myself(savedConfig);
    final getLoginStatus = result.when(
      success: (data) => data.self != '' ? 'circle' : 'error',
      failure: (_) => 'error',
      loading: () => 'loading',
    );
    loginStatus.setState(getLoginStatus);

    return;
  }

  Future<JiraConfig> _onSave(JiraConfig jiraConfig) async {
    jiraConfig
      ..setUserConfigFromString(
        email: emailController.text,
        token: apiTokenController.text,
      )
      ..setSubDomain(subDomainController.text)
      ..setJql(jqlController.text);
    await jiraConfig.save();
    return jiraConfig;
  }

  // List<Widget> _buildDebugMenu() {
  //   return [
  //     formedCard(
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Text(
  //             'systemTray.initSystemTray',
  //             style: TextStyle(
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           const Text(
  //             'Create system tray.',
  //           ),
  //           const SizedBox(
  //             height: 12.0,
  //           ),
  //           ElevatedButton(
  //             child: const Text("initSystemTray"),
  //             onPressed: () async {
  //               if (await systemTray.initSystemTray(
  //                   iconPath: getDeployStatusIconPath('loading'))) {
  //                 systemTray.setTitle("new system tray");
  //                 systemTray.setToolTip("How to use system tray with Flutter");
  //                 systemTray.setContextMenu(menu);
  //               }
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //     formedCard(
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Text(
  //             'systemTray.destroy',
  //             style: TextStyle(
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           const Text(
  //             'Destroy system tray.',
  //           ),
  //           const SizedBox(
  //             height: 12.0,
  //           ),
  //           ElevatedButton(
  //             child: const Text("destroy"),
  //             onPressed: () async {
  //               await systemTray.destroy();
  //             },
  //           ),
  //         ],
  //       ),
  //     )
  //   ];
  // }
}
