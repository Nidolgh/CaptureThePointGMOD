local ply = FindMetaTable( "Player" )

--include ("player_class/player_default.lua")
--include ("player_class/player_custom.lua")

local teams = {}

teams[1] = {
    name = "Penguin Team",
    color = Color( 255.0, 0.0, 0.0 ),
    weapons = { "weapon_vampcrowbar", "weapon_revolver", "weapon_bigrevolver", "weapon_chairgun", "weapon_weirdsmg_0"  },
    p_models = { [0] = "BFOL_Penguin_0" },
    spawnPoints = {}
}
teams[2] = {
    name = "Potato Team",
    color = Color( 255.0, 255.0, 0.0 ),
    weapons = { "weapon_vampcrowbar", "weapon_revolver", "weapon_bigrevolver", "weapon_chairgun", "weapon_weirdsmg_0"},
    p_models = { [0] = "Parrotv3" },
    spawnPoints = {}
}
-- teams[3] = {
--     name = "Banana Team",
--     color = Color( 238, 255, 0),
--     weapons = { "weapon_vampcrowbar", "weapon_revolver", "weapon_bigrevolver", "weapon_chairgun", "weapon_weirdsmg_0"  },
--     p_models = { [0] = "BFOL_Banana-Man_0" }
-- }

function SetTeamSpawnPoints( teamId )
    for k, v in pairs( ents.FindByClass("info_player_start") ) do

        entKeyValueTable = v:GetKeyValues()

        if (entKeyValueTable.TeamNum == teamId) then

            teams[teamId].spawnPoints[k] = v:EntIndex()
            
        end
    end
end

function InitialiseTeams()
    for k, v in ipairs( teams ) do

        team.SetUp( k, v.name, v.color )

        SetTeamSpawnPoints( k )

    end
end
InitialiseTeams()

function ply:SetupTeam( n )
    if ( not teams[n] ) then return end

    self:SetTeam( n )
    self:SetPlayerColor( team.GetColor( n ):ToVector() )
    self:SetHealth( 150 )
    self:SetMaxHealth( 200 )
    self:SetWalkSpeed( 100 )
    self:SetRunSpeed( 1000 )

    --print( type( teams[n].p_models[0] ) )
    --print( teams[n].p_models[0] )

    local pm_models = player_manager.AllValidModels()
    self:SetModel( pm_models[teams[n].p_models[0]] )

    self:GiveWeapons( n )
    
end

function ply:GiveWeapons()
    for k, weapon in pairs( teams[self:Team()].weapons ) do
        self:Give( weapon )
    end
end

function ply:GetTeamSpawnPointEnt(  )
    if (table.IsEmpty(teams)) then return 0 end
    
    local teamTable = teams[self:Team()]
    if (teamTable == nill) then return 0 end

    local pointIndex = table.Random( teamTable.spawnPoints )
    return ents.GetByIndex(pointIndex)
end

player_manager.AddValidModel( "BFOL_Banana-Man_0", "models/player/rebs/BFOL_Banana-Man_0/BFOL_Banana-Man.mdl" );
player_manager.AddValidModel( "BFOL_Penguin_0", "models/player/rebs/BFOL_Penguin-Man_0/BFOL_Penguin.mdl" );
player_manager.AddValidModel( "Parrotv3", "models/player/rebs/parrotv3_pm/parrotv3.mdl" );