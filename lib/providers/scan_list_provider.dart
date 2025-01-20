import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  Future<ScanModel> nouScan(String valor) async{
    final nouScan = ScanModel(valor: valor);
    final id = await DbProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if(nouScan.tipus == tipusSeleccionat){
      scans.add(nouScan);
      notifyListeners();
    }
    return nouScan;
  }

  carregaScans() async{
    final scans = await DbProvider.db.getAllScan();
    this.scans = [...scans];
    notifyListeners();
  }

  //TODO:
  carregaScansPerTipus(String tipus) async{
    final scans = await DbProvider.db.getScanPerTipus(tipus);
    this.scans = [...scans];
    notifyListeners();
  }

  esborraTots() async{
    await DbProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  esborraPerId(int id) async{
    await DbProvider.db.deleteScan(id);
    scans.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}