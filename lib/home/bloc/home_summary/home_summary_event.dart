abstract class HomeSummaryEvent {}

class FetchMonthlySummary extends HomeSummaryEvent {}

class UpdateYourOffer extends HomeSummaryEvent {
  final int validity, payout;
  UpdateYourOffer(this.validity, this.payout);
}
