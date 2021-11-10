local PoisonMushroom = RegisterMod("PoisonMushroom", 1);
local game = Game();    
local COLLECTIBLE_POISON_MUSHROOM = Isaac.GetItemIdByName("Poison Mushroom");
local hasMush = false;


-- Checks if player has the item
local function updateMush(player)
    hasMush = player:HasCollectible(COLLECTIBLE_POISON_MUSHROOM);
end

-- When the run starts or continues
function PoisonMushroom:onPlayerInit(player)
    updateMush(player)
end

-- Poison Mush functionality
function PoisonMushroom:onUpdate(player)
    -- Spawns the item at the start of the run (debug only)
    if Game():GetFrameCount() == 1 then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, COLLECTIBLE_POISON_MUSHROOM, Vector(320,300), Vector(0,0), nil)   
    end
    updateMush(player)
end;

-- Adds the function above to callbacks
PoisonMushroom:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, PoisonMushroom.onUpdate)

-- Status effects
function PoisonMushroom:onCache(player, cacheFlag)
    local MUSH_DMG_BONUS = (player:GetEffectiveMaxHearts() * 0.50);
    local MUSH_HP_DOWN = ((-1) * player:GetEffectiveMaxHearts());

    if cacheFlag == CacheFlag.CACHE_DAMAGE then
        if player:HasCollectible(COLLECTIBLE_POISON_MUSHROOM, false) and not hasMush then
            if player:GetSoulHearts() >= 1 then
                player.Damage = player.Damage + MUSH_DMG_BONUS
                player:AddMaxHearts((-1) * player:GetEffectiveMaxHearts(), true)
            else
                player.Damage = player.Damage + (MUSH_DMG_BONUS - 1.00)
                player:AddMaxHearts( (-1) * (player:GetEffectiveMaxHearts() - 2), true)
            end
        end
    end  
end

PoisonMushroom:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, PoisonMushroom.onCache)