import 'package:flutter/cupertino.dart';
import 'wifi_page.dart';
import 'bluetooth_page.dart';

defaultProfilePicture() {
  return Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
      color: CupertinoColors.systemGrey,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        "PA",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.white,
        ),
      ),
    ),
  );
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isAirplaneModeOn = false;
  String? connectedBluetoothDevice;
  String? connectedWifi;

  Widget buildIcon(IconData icon, Color bgColor) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(icon, color: CupertinoColors.white, size: 22),
      ),
    );
  }

  void updateBluetoothDevice(String? device) {
    setState(() {
      connectedBluetoothDevice = device;
    });
  }

  void updateWifiNetwork(String? network) {
    setState(() {
      connectedWifi = network;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Settings'),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CupertinoSearchTextField(),
              ),
              CupertinoListTile(
                leading: defaultProfilePicture(),
                title: Text("Group Matwa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text("Apple Account, iCloud, and more", style: TextStyle(color: CupertinoColors.systemGrey)),
                trailing: const CupertinoListTileChevron(),
              ),
              CupertinoListSection(
                children: [
                  CupertinoListTile(
                    title: const Text("Airplane Mode"),
                    leading: buildIcon(CupertinoIcons.airplane, CupertinoColors.activeOrange),
                    trailing: CupertinoSwitch(
                      value: isAirplaneModeOn,
                      onChanged: (bool value) {
                        setState(() {
                          isAirplaneModeOn = value;
                        });
                      },
                    ),
                  ),
                  CupertinoListTile(
                    title: const Text("Wi-fi"),
                    leading: buildIcon(CupertinoIcons.wifi, CupertinoColors.systemBlue),
                    subtitle: connectedWifi != null
                        ? Text("Connected to $connectedWifi", style: const TextStyle(color: CupertinoColors.systemGrey))
                        : const Text("Off", style: TextStyle(color: CupertinoColors.systemGrey)),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => WifiSettingsPage(onNetworkConnected: updateWifiNetwork),
                        ),
                      );
                    },
                  ),
                  CupertinoListTile(
                    title: const Text("Bluetooth"),
                    leading: buildIcon(CupertinoIcons.bluetooth, CupertinoColors.systemBlue),
                    subtitle: connectedBluetoothDevice != null
                        ? Text("Connected to $connectedBluetoothDevice", style: const TextStyle(color: CupertinoColors.systemGrey))
                        : const Text("Off", style: TextStyle(color: CupertinoColors.systemGrey)),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => BluetoothSettingsPage(onDeviceConnected: updateBluetoothDevice),
                        ),
                      );
                    },
                  ),
                  CupertinoListTile(
                    title: const Text("Cellular"),
                    leading: buildIcon(CupertinoIcons.antenna_radiowaves_left_right, CupertinoColors.systemGreen),
                    subtitle: const Text("Off", style: TextStyle(color: CupertinoColors.systemGrey)),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  CupertinoListTile(
                    title: const Text("Personal Hotspot"),
                    leading: buildIcon(CupertinoIcons.link, CupertinoColors.systemGreen.withOpacity(0.5)),
                    subtitle: const Text("Off", style: TextStyle(color: CupertinoColors.systemGrey)),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  CupertinoListTile(
                    title: const Text("Battery"),
                    leading: buildIcon(CupertinoIcons.battery_100, CupertinoColors.systemGreen),
                    trailing: const CupertinoListTileChevron(),
                  ),
                ],
              ),
              CupertinoListSection(
                children: [
                  CupertinoListTile(
                    title: const Text("General"),
                    leading: buildIcon(CupertinoIcons.settings, CupertinoColors.systemGrey),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  CupertinoListTile(
                    title: const Text("Accessibility"),
                    leading: buildIcon(CupertinoIcons.person_crop_circle, CupertinoColors.systemBlue),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  CupertinoListTile(
                    title: const Text("Camera"),
                    leading: buildIcon(CupertinoIcons.camera, CupertinoColors.systemGrey),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  CupertinoListTile(
                    title: const Text("Control Center"),
                    leading: buildIcon(CupertinoIcons.slider_horizontal_3, CupertinoColors.systemGrey),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  CupertinoListTile(
                    title: const Text("Display & Brightness"),
                    leading: buildIcon(CupertinoIcons.brightness, CupertinoColors.systemBlue),
                    trailing: const CupertinoListTileChevron(),
                  ), CupertinoListTile(
                    title: const Text("Home Screen & App Library"),
                    leading: buildIcon(CupertinoIcons.home, CupertinoColors.systemBlue),
                    trailing: const CupertinoListTileChevron(),
                  ), CupertinoListTile(
                    title: const Text("Search"),
                    leading: buildIcon(CupertinoIcons.search, CupertinoColors.systemGrey),
                    trailing: const CupertinoListTileChevron(),
                  ), CupertinoListTile(
                    title: const Text("Notifications"),
                    leading: buildIcon(CupertinoIcons.bell_solid, CupertinoColors.systemOrange),
                    trailing: const CupertinoListTileChevron(),
                  ), CupertinoListTile(
                    title: const Text("iCloud"),
                    leading: buildIcon(CupertinoIcons.cloud, CupertinoColors.systemBlue),
                    trailing: const CupertinoListTileChevron(),
                  ), CupertinoListTile(
                    title: const Text("Location"),
                    leading: buildIcon(CupertinoIcons.location, CupertinoColors.systemBlue),
                    trailing: const CupertinoListTileChevron(),
                  ), CupertinoListTile(
                    title: const Text("Focus"),
                    leading: buildIcon(CupertinoIcons.moon_fill, CupertinoColors.systemPurple),
                    trailing: const CupertinoListTileChevron(),


                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
