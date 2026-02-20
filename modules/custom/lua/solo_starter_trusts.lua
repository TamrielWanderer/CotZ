-----------------------------------
-- Solo Starter Trusts
--
-- Grants new characters a balanced set of Trust spells and the Trust Permit
-- key item so solo players can immediately form a Trust party covering all
-- core roles (healer, tank, damage dealer, support).
--
-- Trust permits and starter spells are granted in charCreate so existing
-- characters are not affected.
-----------------------------------
require('modules/module_utils')
require('scripts/globals/player')
-----------------------------------
local m = Module:new('solo_starter_trusts')

-- Trust spells to grant at character creation.
-- Chosen to give coverage across all main roles without overwhelming the spell list.
local starterTrusts =
{
    -- Healers (White Mage / Dancer)
    xi.magic.spell.CURILLA,       -- San d'Oria WHM, solid healer/buffer
    xi.magic.spell.KUPIPI,        -- Windurst WHM, dedicated healer
    xi.magic.spell.MIHLI_ALIAPOH, -- WHM, status cures + heals

    -- Tanks
    xi.magic.spell.VALAINERAL,    -- San d'Oria PLD, strong front-line tank
    xi.magic.spell.NAJI,          -- Bastok WAR, reliable physical tank

    -- Damage Dealers
    xi.magic.spell.AYAME,         -- Bastok SAM, high melee DPS
    xi.magic.spell.ZEID,          -- DRK, strong DD with debuffs
    xi.magic.spell.LION,          -- THF, fast attacker with TH utility

    -- Magic DPS / Support
    xi.magic.spell.SHANTOTTO,     -- Windurst BLM, powerful elemental nuker
    xi.magic.spell.AJIDO_MARUJIDO, -- Windurst RDM/BLM, refresh + nukes

    -- Bard / Party Support
    xi.magic.spell.JOACHIM,       -- BRD, songs for the whole Trust party

    -- Versatile / Late-game
    xi.magic.spell.PRISHE,        -- fast melee + healing, great all-rounder
    xi.magic.spell.TENZEN,        -- SAM, good DD with defensive utility
}

m:addOverride('xi.player.charCreate', function(player)
    super(player)

    -- Grant a Trust Permit so the player can summon Trusts immediately.
    -- Any one permit is sufficient; we give all three for completeness.
    if not player:hasKeyItem(xi.ki.WINDURST_TRUST_PERMIT) then
        player:addKeyItem(xi.ki.WINDURST_TRUST_PERMIT)
    end

    if not player:hasKeyItem(xi.ki.BASTOK_TRUST_PERMIT) then
        player:addKeyItem(xi.ki.BASTOK_TRUST_PERMIT)
    end

    if not player:hasKeyItem(xi.ki.SAN_DORIA_TRUST_PERMIT) then
        player:addKeyItem(xi.ki.SAN_DORIA_TRUST_PERMIT)
    end

    -- Grant the starter Trust spells.
    for _, spellId in ipairs(starterTrusts) do
        if not player:hasSpell(spellId) then
            player:addSpell(spellId, { silentLog = true })
        end
    end

    player:printToPlayer(
        'Welcome! You have been granted a starter set of Trust spells. ' ..
        'Use /ma "Trust: <name>" <me> to call allies to your side.',
        xi.msg.channel.SYSTEM_3, '')
end)

return m
