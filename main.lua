local PoisonMushroom = RegisterMod("PoisonMushroom", 1);
PoisonMushroom.COLLECTIBLE_POISON_MUSHROOM = Isaac.GetItemIdByName("Poison Mushroom");

function PoisonMushroom:onUpdate()
    -- Poison Mush functionality

    if Game():GetFrameCount() == 1 then
        PoisonMushroom.HasPoisonMushroom = false
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, PoisonMushroom.COLLECTIBLE_POISON_MUSHROOM, Vector(320,300), Vector(0,0), nill)
    end

    -- Checks which players have the item
    for playerNum = 1, Game:getNumPlayers() do
        local player = Game():getPlayer(playerNum);
        
        -- Here is what the item does
        if player:hasCollectible(PoisonMushroom.COLLECTIBLE_POISON_MUSHROOM) then

        end;
    end;
end;


PoisonMushroom:AddCallback(ModCallbacks.MC_POST_UPDATE, PoisonMushroom.onUpdate);