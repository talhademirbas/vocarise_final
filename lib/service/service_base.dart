import 'package:vocarise_final/service/model/word_detail_model.dart';

abstract class ServiceBase {
  Future<WordDetailModel?> fetchWordDetails(String word);
}
