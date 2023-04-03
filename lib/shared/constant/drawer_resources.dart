class DrawerResource {
  final String title;
  final String routeName;

  const DrawerResource({required this.title, required this.routeName});
}

const DrawerResource accidentResource =
    const DrawerResource(title: 'Mes Déclarations', routeName: '/accident');

const DrawerResource vehiculeResource =
    const DrawerResource(title: 'Mes Véhicules', routeName: '/vehicule');

const DrawerResource annonceResource =
    const DrawerResource(title: 'Mes Annonces', routeName: '/annonce');

const DrawerResource profileResource =
    const DrawerResource(title: 'Mon Profile', routeName: '/profile');

const DrawerResource rendezVousResource =
    const DrawerResource(title: 'Mes Rendez-Vous', routeName: '/rendez-vous');
