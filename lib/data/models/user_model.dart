class utilisateur {
  String? firebaseUid;
  String? image;
  String? nom;
  Null? prenom;
  String? email;
  String? dateInscription;
  String? adresse;
  String? role;
  Null? etat;
  int? numeroTelephone;
  String? password;
  String? confirmPassword;

  utilisateur(
      {this.firebaseUid,
        this.image,
        this.nom,
        this.prenom,
        this.email,
        this.dateInscription,
        this.adresse,
        this.role,
        this.etat,
        this.numeroTelephone,
        this.password,
        this.confirmPassword});

  utilisateur.fromJson(Map<String, dynamic> json) {
    firebaseUid = json['firebase_uid'];
    image = json['image'];
    nom = json['nom'];
    prenom = json['prenom'];
    email = json['email'];
    dateInscription = json['date_inscription'];
    adresse = json['adresse'];
    role = json['role'];
    etat = json['etat'];
    numeroTelephone = json['numero_telephone'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firebase_uid'] = this.firebaseUid;
    data['image'] = this.image;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['email'] = this.email;
    data['date_inscription'] = this.dateInscription;
    data['adresse'] = this.adresse;
    data['role'] = this.role;
    data['etat'] = this.etat;
    data['numero_telephone'] = this.numeroTelephone;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}