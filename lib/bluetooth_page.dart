import 'package:flutter/cupertino.dart';

class BluetoothSettingsPage extends StatefulWidget {
  final Function(String?) onDeviceConnected;

  const BluetoothSettingsPage({super.key, required this.onDeviceConnected});

  @override
  State<BluetoothSettingsPage> createState() => _BluetoothSettingsPageState();
}

class _BluetoothSettingsPageState extends State<BluetoothSettingsPage> {
  bool isBluetoothOn = false;
  String? connectedDevice;
  List<String> pairedDevices = ["BT-5.0", "AirPods Pro"];
  List<String> availableDevices = ["JBL Speaker", "Sony WH-1000XM4"];
  bool isLoading = false;

  void _simulateBluetoothConnection(String deviceName) {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        connectedDevice = deviceName;
        isLoading = false;
      });
      widget.onDeviceConnected(connectedDevice);
    });
  }

  void _toggleBluetooth(bool value) {
    setState(() {
      isBluetoothOn = value;
      isLoading = true;
    });

    if (isBluetoothOn) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
      });
    } else {
      setState(() {
        connectedDevice = null;
        widget.onDeviceConnected(null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Bluetooth"),
        leading: CupertinoNavigationBarBackButton(),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: CupertinoColors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.bluetooth,
                        size: 50,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text.rich(
                    TextSpan(
                      text: "Connect to accessories you can use for\nactivities such as streaming music, making\nphone calls, and gaming. ",
                      style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Learn more...",
                          style: TextStyle(color: CupertinoColors.activeBlue),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Bluetooth", style: TextStyle(fontSize: 18)),
                      CupertinoSwitch(
                        value: isBluetoothOn,
                        onChanged: _toggleBluetooth,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isBluetoothOn)
              isLoading
                  ? const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoActivityIndicator(),
                      SizedBox(height: 10),
                      Text("",style: TextStyle(color: CupertinoColors.systemGrey)),
                    ],
                  ),
                ),
              )
                  : Column(
                children: [
                  _buildDeviceSection("MY DEVICES", pairedDevices, isPaired: true),
                  _buildDeviceSection("OTHER DEVICES", availableDevices, isPaired: false),
                ],
              )
            else
              const Expanded(
                child: Center(
                  child: Text("Bluetooth is Off", style: TextStyle(color: CupertinoColors.systemGrey)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceSection(String title, List<String> devices, {bool isPaired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(title, style: const TextStyle(color: CupertinoColors.systemGrey, fontSize: 14)),
        ),
        Column(
          children: devices.map((device) => _buildDeviceTile(device, isPaired)).toList(),
        ),
      ],
    );
  }

  Widget _buildDeviceTile(String deviceName, bool isPaired) {
    bool isConnected = deviceName == connectedDevice;
    return GestureDetector(
      onTap: () => _simulateBluetoothConnection(deviceName),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: CupertinoColors.white,
          border: Border(bottom: BorderSide(color: CupertinoColors.systemGrey4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(deviceName, style: const TextStyle(fontSize: 16)),
            Row(
              children: [
                Text(
                  isConnected ? "Connected" : "",
                  style: TextStyle(fontSize: 14, color: CupertinoColors.activeBlue),
                ),
                const SizedBox(width: 8),
                const Icon(CupertinoIcons.info, color: CupertinoColors.activeBlue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
