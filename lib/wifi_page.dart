import 'package:flutter/cupertino.dart';

class WifiSettingsPage extends StatefulWidget {
  final Function(String?) onNetworkConnected;

  const WifiSettingsPage({super.key, required this.onNetworkConnected});

  @override
  State<WifiSettingsPage> createState() => _WifiSettingsPageState();
}

class _WifiSettingsPageState extends State<WifiSettingsPage> {
  bool isWifiOn = false; // Default na OFF
  String? connectedNetwork;
  List<String> myNetworks = ["_FREE Smart WiFi @HCC", "HCC_CpELab"];
  List<String> otherNetworks = ["!!", "#GigaSmartWiFi", "qwerty", "pogi dexter"];
  bool isLoading = false;

  void _simulateWifiConnection() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        connectedNetwork = "HCC_ICSLab";
        isLoading = false;
      });
      widget.onNetworkConnected(connectedNetwork);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Wi-Fi"),
        previousPageTitle: "Settings",
        trailing: Text("Edit", style: TextStyle(color: CupertinoColors.activeBlue)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: CupertinoColors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            CupertinoIcons.wifi,
                            size: 50,
                            color: CupertinoColors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text.rich(
                          TextSpan(
                            text: "Connect to Wi-Fi, view available networks, and\nmanage settings for joining networks and\nnearby hotspots. ",
                            style: TextStyle(color: CupertinoColors.systemGrey),
                            children: [
                              TextSpan(
                                text: "Learn more...",
                                style: TextStyle(color: CupertinoColors.activeBlue),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Wi-Fi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      CupertinoSwitch(
                        value: isWifiOn,
                        onChanged: (value) {
                          setState(() {
                            isWifiOn = value;
                            if (isWifiOn) {
                              _simulateWifiConnection();
                            } else {
                              connectedNetwork = null;
                              widget.onNetworkConnected(null);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            if (isWifiOn) ...[
              Expanded(
                child: isLoading
                    ? const Center(child: CupertinoActivityIndicator())
                    : ListView(
                  children: [
                    CupertinoListSection.insetGrouped(
                      header: const Text("MY NETWORKS"),
                      children: myNetworks.map((network) => _buildNetworkTile(network)).toList(),
                    ),
                    CupertinoListSection.insetGrouped(
                      header: const Text("OTHER NETWORKS"),
                      children: otherNetworks.map((network) => _buildNetworkTile(network)).toList(),
                    ),
                  ],
                ),
              ),
            ] else ...[
              const Expanded(
                child: Center(
                  child: Text("Wi-Fi is Off", style: TextStyle(color: CupertinoColors.systemGrey)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkTile(String networkName) {
    bool isConnected = networkName == connectedNetwork;
    return CupertinoListTile(
      title: Text(networkName),
      subtitle: isConnected ? const Text("Connected", style: TextStyle(color: CupertinoColors.systemGrey)) : null,
      trailing: isConnected
          ? const Text("Connected", style: TextStyle(color: CupertinoColors.activeBlue, fontWeight: FontWeight.bold))
          : const Icon(CupertinoIcons.info, color: CupertinoColors.activeBlue),
      onTap: () {
        setState(() {
          connectedNetwork = networkName;
          isLoading = true;
        });
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isLoading = false;
          });
          widget.onNetworkConnected(networkName);
        });
      },
    );
  }
}
