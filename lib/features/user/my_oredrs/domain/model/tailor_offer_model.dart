// ══════════════════════════════════════════════════════════════════════════════
// TailorOfferModel — represents a single tailor offer for a user's order
// ══════════════════════════════════════════════════════════════════════════════

/// Availability status of the tailor at offer-submission time.
enum TailorAvailability {
  /// Tailor is currently free — can accept new orders
  available,

  /// Tailor is currently busy with other orders
  busy,
}

/// A single offer submitted by a tailor in response to a user's custom order.
class TailorOfferModel {
  final String offerId;

  // ── Tailor info ─────────────────────────────────────────────────────────────
  final String tailorId;
  final String tailorName;
  final String tailorAvatarUrl;
  final TailorAvailability availability;

  /// e.g. "خياط محترف", "خياط مميز"
  final String tailorBadge;
  final double rating;
  final int reviewCount;

  /// How long ago the tailor replied, e.g. "5 دقائق"
  final String repliedAgo;

  // ── Offer details ────────────────────────────────────────────────────────────
  final int durationDays;
  final double price;
  final String description;

  /// URLs of fabric sample images (typically 2–4)
  final List<String> sampleImageUrls;

  const TailorOfferModel({
    required this.offerId,
    required this.tailorId,
    required this.tailorName,
    required this.tailorAvatarUrl,
    required this.availability,
    required this.tailorBadge,
    required this.rating,
    required this.reviewCount,
    required this.repliedAgo,
    required this.durationDays,
    required this.price,
    required this.description,
    required this.sampleImageUrls,
  });
}

// ══════════════════════════════════════════════════════════════════════════════
// Mock data
// ══════════════════════════════════════════════════════════════════════════════

class TailorOfferMockData {
  static const List<TailorOfferModel> offers = [
    TailorOfferModel(
      offerId: 'OFFER-001',
      tailorId: '',
      tailorName: 'خياطة فاطمة المهيري',
      tailorAvatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&q=80',
      availability: TailorAvailability.available,
      tailorBadge: 'خياط محترف',
      rating: 4.9,
      reviewCount: 342,
      repliedAgo: '5 دقائق',
      durationDays: 5,
      price: 850,
      description:
          'يسعدني تنفيذ طلبك بكل اهتمام لدي تجربة واسعة في التطريز اليدوي والتفاصيل الفاخرة. سأستخدم أجود أنواع الأقمشة المتوفرة.',
      sampleImageUrls: [
        'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=200&q=80',
        'https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?w=200&q=80',
        'https://images.unsplash.com/photo-1604176354204-9268737828e4?w=200&q=80',
      ],
    ),
    TailorOfferModel(
      offerId: 'OFFER-002',
      tailorId: '',
      tailorName: 'خياطة فاطمة المهيري',
      tailorAvatarUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&q=80',
      availability: TailorAvailability.busy,
      tailorBadge: 'خياط محترف',
      rating: 4.9,
      reviewCount: 342,
      repliedAgo: '5 دقائق',
      durationDays: 5,
      price: 850,
      description:
          'يسعدني تنفيذ طلبك بكل اهتمام لدي تجربة واسعة في التطريز اليدوي والتفاصيل الفاخرة. سأستخدم أجود أنواع الأقمشة المتوفرة.',
      sampleImageUrls: [
        'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=200&q=80',
        'https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?w=200&q=80',
        'https://images.unsplash.com/photo-1604176354204-9268737828e4?w=200&q=80',
      ],
    ),
  ];
}
