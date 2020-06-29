

class LocationData {
  final String name;
  final String address;

  LocationData(this.name, this.address);

  static List<LocationData> getAll(){
    return [
      LocationData('EMASEO','Avenida Mariscal Sucre y Mariana de Jesús.'),
      LocationData('''Centro de Educación y Gestión 
Ambiental (CEGAM) Manuela Saénz''','Avenida 24 de Mayo  y Pichincha. (centro)'),
      LocationData('Parque Cumandá',' Avenida 24 de mayo, frente del (CEGAM).'),
    ];
  }
}