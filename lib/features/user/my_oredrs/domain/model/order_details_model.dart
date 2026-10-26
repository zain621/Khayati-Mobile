// ──────────────────────────────────────────────────────────────────────────────
// Order Details — data models & mock data
// ──────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

// ── Enums ─────────────────────────────────────────────────────────────────────

/// Type / origin of the order.
enum OrderDetailsType {
  /// "طلب مباشر من الخياط"
  direct,

  /// "طلب مخصص — على ذوقك"
  custom,

  /// "قطع جاهزة"
  readyPieces,
}

/// Current lifecycle status of the order.
enum OrderDetailsStatus {
  waitingOffers,
  hasOffers,
  inProgress,
  readyForShipping,
  shipped,
  delivering,
  completed,
}

/// State of a single tracking step.
enum OrderTrackingStepState {
  completed,
  current,
  pending,
}

// ── Sub-models ────────────────────────────────────────────────────────────────

/// Product info shown in the "تفاصيل المنتج" section.
class OrderProduct {
  final String name;
  final String imageUrl;
  final String fabric;
  final String measurements;
  final double totalPrice;
  final bool isPaid;
  final String? description;

  const OrderProduct({
    required this.name,
    required this.imageUrl,
    required this.fabric,
    required this.measurements,
    required this.totalPrice,
    required this.isPaid,
    this.description,
  });
}

/// Tailor / shop info shown in the "معلومات الخياط" section.
class OrderTailor {
  final String name;
  final String location;
  final String? phoneNumber;

  const OrderTailor({
    required this.name,
    required this.location,
    this.phoneNumber,
  });
}

/// A single step in the order tracking timeline.
class OrderTrackingStep {
  final String title;
  final String description;
  final String dateTime;
  final OrderTrackingStepState state;
  final IconData? icon;

  const OrderTrackingStep({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.state,
    this.icon,
  });

  bool get isCompleted => state == OrderTrackingStepState.completed;
  bool get isCurrent => state == OrderTrackingStepState.current;
  bool get isPending => state == OrderTrackingStepState.pending;
}

// ── Main model ────────────────────────────────────────────────────────────────

/// Full data model for the Order Details screen.
class OrderDetailsModel {
  final String orderId;
  final OrderDetailsType orderType;
  final OrderDetailsStatus status;
  final String? trackingNumber;
  final String orderDate;
  final String deliveryDate;
  final OrderProduct product;
  final OrderTailor tailor;
  final List<OrderTrackingStep> trackingSteps;

  const OrderDetailsModel({
    required this.orderId,
    required this.orderType,
    required this.status,
    this.trackingNumber,
    required this.orderDate,
    required this.deliveryDate,
    required this.product,
    required this.tailor,
    required this.trackingSteps,
  });

  /// Number of completed tracking steps (used for "X من Y" counter).
  int get completedStepsCount =>
      trackingSteps.where((s) => s.isCompleted).length;
}

// ──────────────────────────────────────────────────────────────────────────────
// Mock data — replace with real API once wired
// ──────────────────────────────────────────────────────────────────────────────

class OrderDetailsMockData {
  static final OrderDetailsModel sample = OrderDetailsModel(
    orderId: 'ORD-2024-002',
    orderType: OrderDetailsType.direct,
    status: OrderDetailsStatus.shipped,
    trackingNumber: 'AX-2024-789456',
    orderDate: '2024-01-10',
    deliveryDate: '2024-01-18',
    product: const OrderProduct(
      name: 'عباية كحلي عصرية مع تفاصيل لؤلؤية',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt3w_NsvFAc0cKHFU7FkaPESdVggx80Uvhyw&s',
      fabric: 'قطن مخلوط فاخر',
      measurements: 'مقاس 54',
      totalPrice: 450,
      isPaid: true,
      description: 'عباية عصرية بتصميم أنيق مع تفاصيل لؤلؤية على الأكمام والصدر، مصنوعة من أجود أنواع الأقمشة لتناسب جميع المناسبات.',
    ),
    tailor: const OrderTailor(
      name: 'دار الأناقة',
      location: 'أبوظبي، مارينا مول',
      phoneNumber: '+971500000000',
    ),
    trackingSteps: [
      OrderTrackingStep(
        title: 'اختيار الخياط',
        description: 'تم اختيار دار الأناقة مباشرة من ملفها الشخصي',
        dateTime: '2024-01-10  15:20',
        state: OrderTrackingStepState.completed,
        icon: Icons.person_rounded,
      ),
      OrderTrackingStep(
        title: 'بدء التنفيذ',
        description: 'الخياطة بدأت العمل على طلبك فوراً',
        dateTime: '2024-01-11  09:00',
        state: OrderTrackingStepState.completed,
        icon: Icons.play_arrow_rounded,
      ),
      OrderTrackingStep(
        title: 'جاهز للشحن',
        description: 'تم تحضير العباءة وتغليفها للشحن',
        dateTime: '2024-01-14  10:30',
        state: OrderTrackingStepState.completed,
        icon: Icons.inventory_2_rounded,
      ),
      OrderTrackingStep(
        title: 'تم الشحن',
        description: 'تم شحن طلبك عبر أرامكس - رقم التتبع: AX-2024-789456',
        dateTime: '2024-01-15  08:00',
        state: OrderTrackingStepState.completed,
        icon: Icons.local_shipping_rounded,
      ),
      OrderTrackingStep(
        title: 'قيد التوصيل',
        description: 'الطلب في طريقه إليك - التسليم المتوقع اليوم',
        dateTime: '2024-01-18',
        state: OrderTrackingStepState.current,
        icon: Icons.location_on_rounded,
      ),
      OrderTrackingStep(
        title: 'تم التسليم',
        description: 'سيتم تأكيد التسليم بمجرد استلامك للطلب',
        dateTime: '',
        state: OrderTrackingStepState.pending,
        icon: Icons.check_circle_rounded,
      ),
      OrderTrackingStep(
        title: 'مكتمل',
        description: 'تم إغلاق الطلب بنجاح',
        dateTime: '',
        state: OrderTrackingStepState.pending,
        icon: Icons.star_rounded,
      ),
    ],
  );
}
