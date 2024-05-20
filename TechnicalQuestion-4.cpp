// ======= Question 4 =======
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
  // Find and store recipient player by Name.
  Player* player = g_game.getPlayerByName(recipient);
  
  // Check if we have a Null pointer to Player (Check mappedPlayerNames and we reach end of unordered_map); if we successfully found the player, we'll have returned the Player (it.second).
  if (player == nullptr) {
    player = new Player(nullptr);
    if (!IOLoginData::loadPlayerByName(player, recipient)) {
      // Player is invalid, so we can safely deallocate the player variable and leave this function
      delete player;
      return;
    }
  }
  
  // Create item with given ID
  Item* item = Item::CreateItem(itemId);
  // We check for a valid item
  if (item == nullptr) {
    // Declared itemId was not valid, deallocate memory we used to create a pointer to player and item, then exit.
    delete player;
    delete item;
    return;
  }
  
  // At this point, we know for sure that our pointers to Item and Player are both valid, so we can safely add the item to the player's inbox.
  g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

  if (player->isOffline()) {
    IOLoginData::savePlayer(player);
  }
  
}
