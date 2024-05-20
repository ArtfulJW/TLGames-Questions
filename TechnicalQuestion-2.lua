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
    print(v)
end
