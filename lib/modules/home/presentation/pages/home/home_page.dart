import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';

import '../../widgets/logo_widget.dart';
import '../../widgets/custom_text_field_widget.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Modular.to.pushNamed('/home/about');
            },
            child: const LogoWidget()),
        title: Text('title_home'.i18n()),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 50,
            ),
            CustomTextFieldWidget(
              labelText: 'brl'.i18n(),
              prefix: 'brl_symbol'.i18n(),
              controller: controller.txtReais,
              onChanged: controller.onRealChanged,
            ),
            CustomTextFieldWidget(
              labelText: 'usd'.i18n(),
              prefix: 'usd_symbol'.i18n(),
              controller: controller.txtDolars,
              onChanged: controller.onDolarChanged,
            ),
            CustomTextFieldWidget(
              labelText: 'eur'.i18n(),
              prefix: 'eur_symbol'.i18n(),
              controller: controller.txtEuros,
              onChanged: controller.onEuroChanged,
            ),
            Observer(
              builder: (context) {
                return Visibility(
                  visible: controller.homeStore.load,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
