import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insurance_mobile_app/pages/profile/widgets/extrat_info.dart';
import 'package:insurance_mobile_app/pages/profile/widgets/profile_widget.dart';
import 'package:insurance_mobile_app/pages/profile/widgets/update_personal_info.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/common/preferences.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';
import 'package:insurance_mobile_app/shared/services/application_user_service.dart';
import 'package:insurance_mobile_app/shared/services/uploadcare_service.dart';
import 'package:insurance_mobile_app/shared/widgets/custom_progress_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image_cropper/image_cropper.dart';

class ProfileBody extends StatefulWidget {
  final String title;
  final Widget? floatingActionButton;

  const ProfileBody({Key? key, required this.title, this.floatingActionButton})
      : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late ApplicationUser applicationUser;
  bool loading = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  File? pickedFile;
  late ApplicationUserService applicationUserSrv =
      ApplicationUserService(context: context);
  bool isAsyncCall = false;

  @override
  void initState() {
    _fetchCurrentUser();
    super.initState();
  }

  void _onRefresh() async {
    await _fetchCurrentUser(refreshing: true);
  }


  Future<void> _fetchCurrentUser({bool refreshing = false}) async {
    setState(() => loading = !refreshing);
    ApplicationUser user = await Preferences.getCurrentUser();
    const String _url = 'https://flutter.dev';
    setState(() {
      applicationUser = user;
      loading = false;
      _refreshController.refreshCompleted();
    });
  }

  Future<void> _changeImageProfile() async {
    String ext = path.extension(pickedFile!.path);
    if (['.png', '.jpeg', '.jpg'].indexOf(ext) == (-1)) {
      Notifier.of(context).error(message: 'Veuillez choisir une image');
      return;
    }
    Map<String, dynamic> data = {
      'file': await MultipartFile.fromFile(pickedFile!.path,
          filename: path.basenameWithoutExtension(pickedFile!.path))
    };

    setState(() => isAsyncCall = true);

    UploadcareService.upload(data).then((Response<dynamic> value) {
      String uuid = value.data['file'];
      applicationUser
        ..authorities = []
        ..grantedAuthorities = []
        ..imageFilepath = 'https://ucarecdn.com/$uuid/'
        ..imgProfile = 'https://ucarecdn.com/$uuid/';

      applicationUserSrv.update(applicationUser).then((ApplicationUser user) {
        Preferences.setString("currentUser", jsonEncode(user.toJson()));
        _whenUpdated(user);
        Notifier.of(context)
            .success(message: 'Votre photo de profile a été mise à jour.');
      }).catchError((err, s) {
        applicationUserSrv.errorMessage(context);
        print(err);
        print(s);
      }).whenComplete(
          () => setState(() => setState(() => isAsyncCall = false)));
    }).catchError((err, s) {
      print(err);
      print(s);
      applicationUserSrv.errorMessage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Text('')
        : SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            enablePullUp: false,
            enablePullDown: true,
            child: ModalProgressHUD(
              inAsyncCall: isAsyncCall,
              dismissible: false,
              opacity: 0.5,
              progressIndicator: CustomProgressIndicator(),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                    top: 22.0, left: 10.0, right: 10.0, bottom: 30.0),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        ProfileWidget(
                          imagePath: applicationUser.imgProfile!,
                          onClicked: () => _showPicMenu(),
                        ),
                        SizedBox(height: 24),
                        Text(
                          '${applicationUser.prenom} ${applicationUser.nom}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${applicationUser.username}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 24),
                        ExtraInfo(user: applicationUser),
                        SizedBox(height: 30),
                        UpdatePersonalInfo(
                            currentUser: applicationUser,
                            whenUpdated: _whenUpdated)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Future<void> _showPicMenu() async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext sheetContext,
                    void Function(void Function()) sheetState) =>
                Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera_alt_rounded),
                  title: Text('Prendre une photo'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    beginChangingProfileProcess(ImageSource.camera);
                  },
                ),
                ListTile(
                    leading: Icon(Icons.photo_library_outlined),
                    title: Text('Choisir une photo'),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      beginChangingProfileProcess(ImageSource.gallery);
                    }),
              ],
            ),
          );
        });
  }

  Future<void> beginChangingProfileProcess(ImageSource imageSrc) async {
    final ImagePicker _picker = ImagePicker();
    setState(() => isAsyncCall = true);
    final XFile? image = await _picker.pickImage(source: imageSrc);
    setState(() => isAsyncCall = false);
    pickedFile = File(image!.path);
    if (pickedFile != null) {
      setState(() => isAsyncCall = true);
      pickedFile = await ImageCropper.cropImage(
          sourcePath: pickedFile!.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Redimensionner la photo',
              toolbarColor: MainColors.primary,
              activeControlsWidgetColor: MainColors.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      setState(() => isAsyncCall = false);
      if (pickedFile != null) _changeImageProfile();
    }
  }

  void _whenUpdated(ApplicationUser user) =>
      setState(() => applicationUser = user);
}
