import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/providers/ui_provider.dart';
import 'package:qr_scan/screens/screens.dart';
import 'package:qr_scan/widgets/widgets.dart';

//Pagina principal de l'aplicació
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false).esborraTots();
            },
          )
        ],
      ),
      body: const _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    
    final currentIndex = uiProvider.SelectedMenuOpt;

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.carregaScansPerTipus('geo');
        return const MapasScreen();

      case 1:
        scanListProvider.carregaScansPerTipus('http');
        return const DireccionsScreen();

      default:
        scanListProvider.carregaScansPerTipus('geo');
        return const MapasScreen();
    }
  }
}
