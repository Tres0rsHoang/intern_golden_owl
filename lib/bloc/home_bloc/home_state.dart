class HomeStates{
  List<int> id;
  List<int> amount;
  HomeStates({required this.id, required this.amount});
}
class InitStates extends HomeStates{
  InitStates(): super(id: [], amount: []);
}