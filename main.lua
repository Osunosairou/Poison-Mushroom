local PoisonMushroom = RegisterMod("PoisonMushroom", 1);
local game = Game();
local POISON_MUSH = Isaac.GetItemIdByName("Poison Mushroom");

local hasMush = false;
local MUSH_DMG_BONUS = (EntityPlayer:GetEffectiveMaxHearts() * 0.50);

-- Checks if player has the item
function PoisonMushroom:updateMush(player)
    hasMush = player:hasCollectible(POISON_MUSH);
end

-- When the run starts or continues
function PoisonMushroom:onPlayerInit(player)
    PoisonMushroom.updateMush(player)
end

-- Poison Mush functionality
function PoisonMushroom:onUpdate(player)
    -- Spawns the item at the start of the run (debug only)
    if game:GetFrameCount() == 1 then
        PoisonMushroom.HasPoisonMushroom = false
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE,POISON_MUSH, Vector(320,300), Vector(0,0), nill)
    end
   
end;

-- Adds the function above to callbacks
PoisonMushroom:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, PoisonMushroom.onUpdate)

-- Status effects
function PoisonMushroom:onCache(player, cacheFlag)
    if cacheFlag == CacheFlag.CACHE_DAMAGE then
        if player:hasCollectible(POISON_MUSH) and not hasMush then
            player.Damage = player.Damage + MUSH_DMG_BONUS
        end
    end
    if EntityPlayer:GetSoulHearts() >= 1 then
        Isaac.GetPlayer(0):AddMaxHearts( (-1) * (EntityPlayer:GetEffectiveMaxHearts()), true)
    else
        Isaac.GetPlayer(0):AddMaxHearts( (-1) * (EntityPlayer:GetEffectiveMaxHearts() - 2), true)
    end  
    
end

PoisonMushroom:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, PoisonMushroom.onCache)