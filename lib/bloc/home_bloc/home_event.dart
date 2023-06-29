class HomeEvent{}
class AddToCart extends HomeEvent{
  int id;
  AddToCart(this.id);
}
class Remove extends HomeEvent{
  int position;
  Remove(this.position);
}
class Add extends HomeEvent{
  int position;
  Add(this.position);
}
class Minus extends HomeEvent{
  int position;
  Minus(this.position);
}