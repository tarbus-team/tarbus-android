import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/data/local/bus_lines_database.dart';
import 'package:tarbus_app/data/local/company_database.dart';
import 'package:tarbus_app/data/model/schedule/company.dart';

part 'bus_lines_state.dart';

class BusLinesCubit extends Cubit<BusLinesState> {
  BusLinesCubit() : super(BusLinesInitial());

  Future<void> getAll() async {
    List<Map<String, dynamic>> result = List.empty(growable: true);
    List<Company> companiesList = await CompanyDatabase.getAllCompanies();
    for (Company company in companiesList) {
      result.add({
        "company": company,
        "lines": await BusLinesDatabase.getByCompany(company.id),
      });
    }
    emit(BusLinesLoaded(data: result));
  }
}
