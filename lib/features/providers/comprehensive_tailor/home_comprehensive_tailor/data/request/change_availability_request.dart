import '../../../../../../constants/request_constants/request_constants.dart';

class ChangeAvailabilityRequest {
  final bool isAcceptingOrders;

  const ChangeAvailabilityRequest({required this.isAcceptingOrders});

  Map<String, dynamic> toMap() => {
        RequestConstants.isAcceptingOrders: isAcceptingOrders,
      };
}
