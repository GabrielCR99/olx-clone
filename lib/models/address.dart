class Address {
  Address(
      {this.place,
      this.district,
      this.city,
      this.postalCode,
      this.federativeUnity});

  String place;
  String district;
  String city;
  String postalCode;
  String federativeUnity;

  @override
  String toString() {
    return '$place, $district, $city, $postalCode, $federativeUnity';
  }
}
