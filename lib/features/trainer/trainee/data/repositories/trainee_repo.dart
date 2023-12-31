import 'package:dartz/dartz.dart';
import 'package:trainee_restaurantapp/core/net/api_url.dart';
import 'package:trainee_restaurantapp/features/trainer/trainee/data/models/update_trainee_progress_model.dart';
import '../../../../../core/dioHelper/dio_helper.dart';

class UpdateTraineeProgressRepo {
  Future<Either<String, bool>> updateTraineeProgress(
      UpdateTraineeProgressModel updateTraineeProgressModel) async {
    final response = await DioHelper.put(
      APIUrls.API_UPDATE_TRAINEE_PROGRESS,
      body: updateTraineeProgressModel.toJson(),
    );
    try {
      if (response.data['success'] == true) {
        print("Success update");
        return const Right(true);
      } else {
        return Left(response.data['error']['details']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
