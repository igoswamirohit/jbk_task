part of 'ticket_cubit.dart';

class TicketState extends Equatable {
  const TicketState(this.selectedTickets);

  final List<String> selectedTickets;

  @override
  List<Object> get props => [selectedTickets.iterator];

  TicketState copyWith({List<String>? selectedTicketsNew}) {
    return TicketState(selectedTicketsNew ?? selectedTickets);
  }
}
