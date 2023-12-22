import 'package:famooshed/app/common/util/exports.dart';
import 'package:famooshed/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:famooshed/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/dprint.dart';

class MapPage extends GetView<DashboardController> {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: controller.showAppBar
      //     ? CustomAppbarWidget(
      //         centerTitle: true,
      //         title: "Overview",
      //         backgroundColor: AppColors.white,
      //         statusBarColor: AppColors.white,
      //       )
      //     : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getCurrentLocation();
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.my_location,
          color: Colors.blue,
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: GetBuilder<DashboardController>(
          initState: (state) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              controller.getCurrentLocation();
            });
          },
          dispose: (state) {
            if (controller.googleMapController != null)
              controller.googleMapController!.dispose();
            print("Dispose");
          },
          autoRemove: false,
          global: true,
          builder: (DashboardController dashboardController) {
            return Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  height: SizeConfig.deviceHeight! * .65,
                  child: Stack(children: <Widget>[
                    _map(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(8),
                            vertical: getProportionateScreenHeight(16)),
                        child: TextFormField(
                          obscureText: false,
                          onTap: () {
                            controller.handlePressButton();
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            hintText: "Search Postcode",
                            fillColor: Colors.white,
                            enabled: true,
                            filled: true,
                            prefixIconConstraints: BoxConstraints(
                              maxHeight: getProportionateScreenHeight(45),
                              maxWidth: getProportionateScreenWidth(45),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(8)),
                              child: SvgPicture.asset(
                                AppImages.googleMapIcon,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none),
                          ),
                          // pre: Iconify(Ic.sharp_my_location),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // controller.showBottomSheet();
                      },
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: getProportionateScreenHeight(26),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 42,
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
                Flexible(
                  child: Container(
                    height: SizeConfig.deviceHeight! * .35,
                    child: controller.getAddressWidget(),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _map() {
    dprint("orders.map : GoogleMap");
    return GoogleMap(
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: controller.initialLatLong ?? LatLng(0, 0),
          zoom: controller.initialLatLong != null ? controller.currentZoom : 0,
        ),
        myLocationButtonEnabled: false,
        // myLocationEnabled: true,
        // fortyFiveDegreeImageryEnabled: true,
        onCameraMove: (CameraPosition cameraPosition) {
          controller.currentZoom = 14;
          controller.updateLocation(cameraPosition.target);
          // controller.addMark(cameraPosition.target);
        },
        onMapCreated: (GoogleMapController mController) {
          controller.googleMapController = mController;
        });
    // return GoogleMap(
    //     mapType: MapType.normal,
    //     zoomGesturesEnabled: true,
    //     zoomControlsEnabled:
    //         false, // Whether to show zoom controls (only applicable for Android).
    //     myLocationEnabled:
    //         true, // For showing your current location on the map with a blue dot.
    //     myLocationButtonEnabled:
    //         false, // This button is used to bring the user location to the center of the camera view.
    //
    //     initialCameraPosition: CameraPosition(
    //       target: LatLng(23.0296, 72.5301),
    //       zoom: 14,
    //     ),
    //
    //     // polylines: Set<Polyline>.of(controller.mapPolylines.values),
    //     onCameraMove: (CameraPosition cameraPosition) {
    //       controller.currentZoom = cameraPosition.zoom;
    //       controller.updateLocation(cameraPosition.target);
    //       // controller.addMark(cameraPosition.target);
    //     },
    //     markers: controller.markers.toSet(),
    //     onTap: (LatLng pos) {
    //       controller.addMark(pos);
    //     },
    //     onLongPress: (LatLng pos) {},
    //     // markers: markers,
    //     // markers: controller.markers.toSet(),
    //     onMapCreated: (GoogleMapController mController) {
    //       controller.googleMapController = mController;
    //       // controller
    //       //     .addMark(LatLng(controller.lat.value, controller.lng.value));
    //       // _controller!.setMapStyle(_mapStyle);
    //       // if (idRestaurantOnMap != null)
    //       //   _navigateToMap();
    //     });
  }

  _onMapPlus() {
    controller.googleMapController!.animateCamera(
      CameraUpdate.zoomIn(),
    );
  }

  _onMapMinus() {
    controller.googleMapController!.animateCamera(
      CameraUpdate.zoomOut(),
    );
  }

  buttonMyLocation(Function _getCurrentLocation) {
    return Stack(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          child: IBoxCircle(
              child: Icon(
            Icons.my_location,
            size: 30,
            color: Colors.black.withOpacity(0.5),
          )),
        ),
        Container(
          height: 60,
          width: 60,
          child: Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: () {
                  _getCurrentLocation();
                }, // needed
              )),
        )
      ],
    );
  }

  buttonPlus(Function() callback) {
    return Stack(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          child: IBoxCircle(
              child: Icon(
            Icons.add,
            size: 30,
            color: Colors.black,
          )),
        ),
        Container(
          height: 60,
          width: 60,
          child: Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: callback, // needed
              )),
        )
      ],
    );
  }

  buttonMinus(Function() _onMapMinus) {
    return Stack(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          child: IBoxCircle(
              child: Icon(
            Icons.remove,
            size: 30,
            color: Colors.black,
          )),
        ),
        Container(
          height: 60,
          width: 60,
          child: Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: _onMapMinus, // needed
              )),
        )
      ],
    );
  }
}

class IBoxCircle extends StatelessWidget {
  @required
  final Function()? press;
  final Widget child;
  final Color color;
  IBoxCircle({this.color = Colors.white, this.press, required this.child});

  @override
  Widget build(BuildContext context) {
    // Widget _child = Container();
    // if (child != null)
    //   _child = child;
    return Container(
      margin: EdgeInsets.all(5),
      child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(40),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(2, 2), // changes position of shadow
              ),
            ],
          ),
          child: Container(
//              margin: EdgeInsets.only(left: 10),
              child: child)),
    );
  }
}
