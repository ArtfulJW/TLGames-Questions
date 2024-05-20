-- ======= Question 3 =======
-- Assumedly, I can observe that this function tries to remove a specific member from the player's party by Name (membername). I will rename this function appropriately to removePartymemberByName
function removePartymemberByName(playerId, membername)
  
  -- Create local player variable and save a Player with the given playerID.
  local player = Player(playerId)
  -- Save the party that the player is in, in a table.
  local party = player:getParty()
  
  -- For each player in the party, check their names. I'm assuming that getMembers() returns a table of strings.
  for k,v in pairs(party:getMembers()) do
    -- The check for the player's name is rather odd, there's no need to create a new Player just to check the name, when we can just simply do a string comparison (assuming that Names are unique).
    if v:getName() == membername then
      party:removeMember(Player(membername))
      -- print("Removed: " .. v:getName() .. " from your party")
      return true
    end
    
  end
  -- If we can't find and remove the member, we immediately exit
  -- print("Unable to remove:" .. membername .. "as they are not in your party")
  return false
end
