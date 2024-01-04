import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vocarise_final/service/model/word_detail_model.dart';
import 'package:vocarise_final/service/service_base.dart';
import 'package:vocarise_final/utils/exceptions.dart';

class GetService implements ServiceBase {
  final Dio _dio;

  GetService()
      : _dio = Dio(BaseOptions(
            baseUrl: "https://api.dictionaryapi.dev/api/v2/entries/en/"));

  @override
  Future<WordDetailModel?> fetchWordDetails(String word) async {
    try {
      final response = await _dio.get(word);

      if (response.statusCode == HttpStatus.ok) {
        WordDetailModel? wordDetailModel;
        wordDetailModel = WordDetailModel.fromJson(response.data[0]);
        return wordDetailModel;
      }
    } on DioException catch (e) {
      throw CustomException(e);
    }
    return null;
  }
}
