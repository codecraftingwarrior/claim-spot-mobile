import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/common/preferences.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';
import 'package:insurance_mobile_app/shared/widgets/app_progress_indicator.dart';
import 'package:insurance_mobile_app/utils/paytech.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileFloatingActionButton extends StatefulWidget {
  const ProfileFloatingActionButton({Key? key}) : super(key: key);

  @override
  _ProfileFloatingActionButtonState createState() => _ProfileFloatingActionButtonState();
}

class _ProfileFloatingActionButtonState extends State<ProfileFloatingActionButton> {
  bool _fetching = false;
  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
      elevation: 2.0,
      child: _fetching ? AppProgressIndicator(size: 35.0, color: Colors.white) : Icon(Icons.payment),
      onPressed: () => _beginPaymentProcess(),
      backgroundColor: MainColors.primary,
    );
  }

  void _beginPaymentProcess() async {
    String refCommand = md5.convert(utf8.encode(DateTime.now().microsecond.toString())).toString();
    setState(() => _fetching = true);
    ApplicationUser user = await Preferences.getCurrentUser();
    Paytech paytech = Paytech()
      ..query = {
        'item_name': 'Paiement Frais abonnement',
        'item_price': user.formule!.montant!.toString(),
        'env': 'test',
        'command_name':
        'Paiement des frais mensuel d\'abonnement, formule : ${user.formule!.libelle}'
      }
      ..testMode = true
      ..isMobile = false
      ..currency = 'XOF'
      ..refCommand = refCommand
      ..notificationUrl = {
        'ipn_url': 'https://insurance-claim-management.herokuapp.com/api/formule/payment-notification',
        'success_url': 'https://cia-assurance.web.app/payment/success',
        'cancel_url': 'https://cia-assurance.web.app/payment/failed',
      };

    Map<String, dynamic> response = await paytech.send();
    setState(() => _fetching = false);
    if(response['success'] == 1) {
      if (!await launch(response['redirect_url'])) {
        Notifier.of(context).error(message: 'Impossible d\'accéder à cette page');
        throw 'Impossible d\'acceder à ${response['redirect_url']}';
      }
    }
  }

}
