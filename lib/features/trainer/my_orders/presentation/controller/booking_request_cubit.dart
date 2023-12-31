import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainee_restaurantapp/features/trainer/my_orders/data/models/booking_request_model.dart';
import '../../../../../core/ui/toast.dart';
import '../../data/repositories/booking_request_repo.dart';

part 'booking_request_state.dart';

class BookingRequestCubit extends Cubit<BookingRequestState> {
  BookingRequestCubit() : super(BookingRequestInitial()) {
    print("object");
  }

  static BookingRequestCubit of(context) => BlocProvider.of(context);

  final _bookingRequestRepo = BookingRequestRepo();

  List<BookingRequestModel> bookingRequests = [];
  int tabbed = 1;
  updateCurrentTap(int index) {
    tabbed = index;

    emit(GetBookingResuestsUpdateTap());
  }

  Future getBookingRequests(int status) async {
    print("init");
    emit(GetBookingRequestsLoading());
    final res = await _bookingRequestRepo.getBookingRequests(status);
    res.fold(
      (err) {
        Toast.show(err);
        emit(GetBookingRequestsError());
      },
      (res) {
        bookingRequests = res;
        emit(GetBookingRequestsLoaded(res));
      },
    );
  }

  Future approveBookingRequest(
      BuildContext context, int bookingRequestId) async {
    emit(ApproveBookingRequestLoading());
    final res =
        await _bookingRequestRepo.approveBookingRequest(bookingRequestId);
    res.fold(
      (err) {
        Toast.show(err);
        emit(ApproveBookingRequestError());
      },
      (res) async {
        getBookingRequests(0);
        emit(ApproveBookingRequestLoaded());
      },
    );
  }

  Future rejectBookingRequest(
      BuildContext context, int bookingRequestId) async {
    emit(RejectBookingRequestLoading());
    final res =
        await _bookingRequestRepo.rejectBookingRequest(bookingRequestId);
    res.fold(
      (err) {
        print(err);
        Toast.show(err);
        emit(RejectBookingRequestError());
      },
      (res) {
        getBookingRequests(0);
        emit(RejectBookingRequestLoaded());
      },
    );
  }
}
