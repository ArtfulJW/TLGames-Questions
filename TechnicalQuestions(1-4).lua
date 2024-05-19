-- ======= Question 1 =======
--[[ 
Observations:
1. If we delay the call to releaseStorage but return true immediately after, I'm assuming that the player would be logged out and removed from some playerList. Wouldn't our reference to this player be nil when we execute the delayed event?
TODO: Ensure that we move forward only when the reference to the player is valid.
]]

-- Helper Function to set player's storageValue to non-positive integer on log out.
local function releaseStorage(player)
  player:setStorageValue(1000, -1)
end

-- Logout function that we call when a player wants to logout.
function onLogout(player)
  
  if (!player) then
    -- Reference to player is valid, move on
    if player:getStorageValue(1000) == 1 then
      -- Create an event that executes the given function after a delay
      addEvent(releaseStorage, 1000, player)
      return true
  else 
    -- Invalid (Nil) reference to player, leave immediately.
    return false

end

-- ======= Question 2 =======
-- this method is supposed to print names of all guilds that have less than memberCount max members
--[[
Observations
1. What if the return value for the query yields a non-valid response. The original code does not take this into account.
TODO: Detect bad response and deal with it
]]
function printSmallGuildNames(memberCount)
  
  -- Define an SQL Query to select and return all the guilds that have less than memberCount amount of members
  local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
  -- Format and use the query with the given max number of members, and store 
  local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
  
  -- Checking for bad response, in which case we will leave immediately
  if resultId == false then
    return false
  end
  
  -- For sure, we have valid results from the query, so we can move on to printing it all out.
  local guildName = result.getString("name")
  -- Just to make sure, we're going to iterate through them all manually.
  for k,v in pairs(guildName) do
    print( v )
end

-- ======= Question 3 =======
-- Assumedly, I can observe that this function tries to remove a specific member from the player's party by Name (membername). I will rename this function appropriately to removePartymemberByName
function removePartymemberByName(playerId, membername)\
  
  -- Create local player variable and save a Player with the given playerID.
  local player = Player(playerId)
  -- Save the party that the player is in, in a table.
  local party = player:getParty()
  
  -- For each player in the party, check their names. I'm assuming that getMembers() returns a table of strings.
  for k,v in pairs(party:getMembers()) do
    -- My assumption is that party:getMembers() returns a table that we iterate through its key-value pairs. 
    -- The check for the player's name is rather odd, I question the need to create a new Player just to check the name, when we can just simply do a string comparison (assuming that Names are unique).
    if v == membername then
      party:removeMember(Player(membername))
    end
    
  end
  
end

-- ======= Question 4 =======
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
  -- Find and store recipient player by Name.
  Player* player = g_game.getPlayerByName(recipient);
  
  -- Check for Null Player (Check mappedPlayerNames and we reach end of unordered_map); if we successfully found the player, we'll have returned the Player (it.second).
  if (!player) {
    player = new Player(nullptr);
    if (!IOLoginData::loadPlayerByName(player, recipient)) {
      return;
    }
  }
  
  -- Create item with given ID
  Item* item = Item::CreateItem(itemId);
  if (!item) {
    return;
  }

  g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

  if (player->isOffline()) {
    IOLoginData::savePlayer(player);
  }
}
