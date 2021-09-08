typedef Future<void> FavouriteController(dynamic item);

class FavItemController {
  FavouriteController? updateFavourite;

  FavItemController();

  void setUpController(FavouriteController _updateFavourite) {
    updateFavourite = _updateFavourite;
  }
}
