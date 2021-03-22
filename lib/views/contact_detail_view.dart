
import 'package:demo_contacts_app/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class ContactDetailView extends StatelessWidget {
  const ContactDetailView(this._contact, {Key key,}) : super(key: key);

  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(),),
      body: SingleChildScrollView(
        child: Column(
          children: [

            _image(context),

            Text(_contact.firstName + ' ' + _contact.lastName, style: const TextStyle(fontSize: 30)),

            Text(_contact.cell ),

            Text(_contact.phone ),

            Text(_contact.mail ),

            Text(_contact.address.street.name + ' ' + _contact.address.street.number.toString()),

            Text(_contact.address.city ),

            Text(_contact.address.state ),

            Text(_contact.address.country ),

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
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.network(_contact.imageUrl)),
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
            center: LatLng(
                _contact.address.latLng.latitude,
                _contact.address.latLng.longitude),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(
                      _contact.address.latLng.latitude,
                      _contact.address.latLng.longitude),
                  builder: (ctx) =>
                      Container(
                        child: Icon(Icons.location_on),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}