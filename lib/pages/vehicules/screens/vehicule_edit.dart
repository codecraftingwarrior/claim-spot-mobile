import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insurance_mobile_app/pages/vehicules/categorie_vehicule.dart';
import 'package:insurance_mobile_app/pages/vehicules/categorie_vehicule_service.dart';
import 'package:insurance_mobile_app/pages/vehicules/forms/vehicule_edit_form.dart';
import 'package:insurance_mobile_app/pages/vehicules/vehicule.dart';
import 'package:insurance_mobile_app/shared/common/notifier.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';
import 'package:insurance_mobile_app/shared/widgets/app_progress_indicator.dart';
import 'package:insurance_mobile_app/shared/widgets/navbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class VehiculeEdit extends StatefulWidget {
  const VehiculeEdit({Key? key}) : super(key: key);

  @override
  _VehiculeEditState createState() => _VehiculeEditState();
}

class _VehiculeEditState extends State<VehiculeEdit> {
  late Vehicule vehicule;
  bool isAsyncCall = false;
  bool _isLoading = false;
  File? pickedImage;
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  CategorieVehiculeService categorieVehiculeSrv = CategorieVehiculeService();
  List<CategorieVehicule> categorieVehicules = [];

  @override
  void initState() {
    _fetchCategories();
    super.initState();
  }

  void _fetchCategories() {
    setState(() => _isLoading = true);
    categorieVehiculeSrv
        .all()
        .then((List<CategorieVehicule> categorieVehicules) {
      this.categorieVehicules = categorieVehicules;
    }).catchError((err, s) {
      print(err);
      print(s);
      categorieVehiculeSrv.errorMessage(context);
    }).whenComplete(() => setState(() => _isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    vehicule = ModalRoute.of(context)!.settings.arguments as Vehicule;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: ModalProgressHUD(
        inAsyncCall: isAsyncCall,
        dismissible: false,
        opacity: 0.5,
        progressIndicator: AppProgressIndicator(color: Colors.white),
        child: Scaffold(
          appBar: Navbar(title: 'Modifier un véhicule'),
          backgroundColor: MainColors.bgColorScreen,
          body: _isLoading
              ? AppProgressIndicator()
              : SingleChildScrollView(
                  child: SafeArea(
                    bottom: true,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, left: 15.0, right: 15.0, bottom: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Card(
                                  elevation: 5.0,
                                  semanticContainer: false,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                      vehicule.image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 18.0),
                                ElevatedButton.icon(
                                    onPressed: _showPicMenu,
                                    icon: Icon(Icons.add_a_photo_outlined),
                                    style: ElevatedButton.styleFrom(
                                        primary: MainColors.primary),
                                    label: const Text('Modifier'))
                              ],
                            ),
                            SizedBox(height: 25.0),
                            VehiculeEditForm(
                              formKey: _formKey,
                              categories: categorieVehicules,
                              context: context,
                              vehicule: vehicule,
                            ),
                            SizedBox(height: 25.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                  onPressed: _update,
                                  icon: Icon(Icons.check_box),
                                  style: ElevatedButton.styleFrom(
                                      primary: MainColors.primary),
                                  label: const Text('Modifier')),
                            ),
                          ],
                        ),
                      ),
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
                    _chooseImage(ImageSource.camera);
                  },
                ),
                ListTile(
                    leading: Icon(Icons.photo_library_outlined),
                    title: Text('Choisir une photo'),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _chooseImage(ImageSource.gallery);
                    }),
              ],
            ),
          );
        });
  }

  Future<void> _chooseImage(ImageSource imageSrc) async {
    final ImagePicker _picker = ImagePicker();
    setState(() => isAsyncCall = true);
    final XFile? image = await _picker.pickImage(source: imageSrc);
    setState(() => isAsyncCall = false);
    if (image == null) {
      Notifier.of(context).warning(message: 'Veuillez choisir une image');
      return;
    }
    pickedImage = File(image.path);
    if (pickedImage != null) {
      setState(() => isAsyncCall = true);
      pickedImage = await ImageCropper.cropImage(
          sourcePath: pickedImage!.path,
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
    }
  }

  Future<void> _update() async {}
}
