import 'package:demo_contacts_app/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ContactDetailView extends StatelessWidget {
  const ContactDetailView(
    this._contact, {
    Key? key,
  }) : super(key: key);

  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _image(context),
            _name(context),
            _cell(context),
            _phone(context),
            _mail(context),
            _address(context),
            _map(context),
          ],
        ),
      ),
    );
  }

  Widget _image(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(borderRadius: BorderRadius.circular(50.0), child: Image.network(_contact.imageUrl)),
      ),
    );
  }

  Widget _name(context) {
    return Text(_contact.firstName + ' ' + _contact.lastName, style: const TextStyle(fontSize: 30));
  }

  Widget _cell(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
      child: Row(
        children: [
          const Expanded(child: Icon(Icons.phone_android)),
          Expanded(flex: 3, child: Text(_contact.cell)),
        ],
      ),
    );
  }

  Widget _phone(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Expanded(child: Icon(Icons.phone)),
          Expanded(flex: 3, child: Text(_contact.phone)),
        ],
      ),
    );
  }

  Widget _mail(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Expanded(child: Icon(Icons.email_outlined)),
          Expanded(flex: 3, child: Text(_contact.mail)),
        ],
      ),
    );
  }

  Widget _address(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Expanded(child: Icon(Icons.home_work_outlined)),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${_contact.address.street.name} ${_contact.address.street.number}'),
                Text(_contact.address.city),
                Text(_contact.address.state),
                Text(_contact.address.country),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _map(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(_contact.address.latLng.latitude, _contact.address.latLng.longitude),
            zoom: 3.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(_contact.address.latLng.latitude, _contact.address.latLng.longitude),
                  builder: (ctx) => const Icon(Icons.location_on),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
