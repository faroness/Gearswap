 -------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Subduction','Tem. Upheaval','Water Bomb','Tenebral Crush','Spectral Floe','Entomb','Anvil Lightning'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Mighty Guard','Bloodrake','Carcharian Verve',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
        'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Refresh', 'Learning')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Learning')

    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')

    update_combat_form()
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
end


-- Set up gear sets.
function init_gear_sets()
	-- Augmented gear

    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff['Burst Affinity'] = {legs="Assim. Shalwar +1"}
    sets.buff['Chain Affinity'] = {}
    sets.buff.Convergence = {}
    sets.buff.Diffusion = {body="Assim. Jubbah +1"}
    sets.buff.Enchainment = {}
    sets.buff.Efflux = {}

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {}


    -- Waltz set (chr and vit)

        
    -- Don't need any special gear for Healing Waltz.
  
    -- Fast cast sets for spells
    
    sets.precast.FC = {
    ammo="Mantoptera Eye",
    head="Carmine Mask",
    body={ name="Luhlaza Jubbah +1", augments={'Enhances "Enchainment" effect',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+6','Mag. Acc.+2','"Mag.Atk.Bns."+6',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Baetyl Pendant",
    waist="Twilight Belt",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Sangoma Ring",
    right_ring="Rajas Ring",
    back="Swith Cape +1",
}


       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Hydrocera",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Jhakri Robe",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Herculean Trousers", augments={'Attack+24','"Triple Atk."+2','DEX+8',}},
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Noetic Torque",
    waist="Prosilio Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Psystorm Earring",
    left_ring="Rufescent Ring",
    right_ring="Sirona's Ring",
    back="Pahtli Cape",
}
    

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Hydrocera",
    head="Weath. Corona +1",
    body="Jhakri Robe",
    hands={ name="Herculean Gloves", augments={'Attack+25','"Triple Atk."+3','DEX+5',}},
    legs="Gyve Trousers",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Noetic Torque",
    waist="Twilight Belt",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Rufescent Ring",
    right_ring="Sirona's Ring",
    back="Pahtli Cape",
	}
	
	sets.precast.WS['Expiacion'] = {
    ammo="Hydrocera",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Jhakri Robe",
    hands="Jhakri Cuffs +1",
    legs={ name="Herculean Trousers", augments={'Attack+24','"Triple Atk."+2','DEX+8',}},
    feet="Aya. Gambieras +1",
    neck="Noetic Torque",
    waist="Prosilio Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Psystorm Earring",
    left_ring="Rufescent Ring",
    right_ring="Sirona's Ring",
    back="Pahtli Cape",
	}
	
	sets.precast.WS['Savage Blade'] = {
    ammo="Aurgelmir Orb +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Assim. Jubbah +1",
    hands="Jhakri Cuffs +1",
    legs={ name="Herculean Trousers", augments={'Attack+24','"Triple Atk."+2','DEX+8',}},
    feet="Aya. Gambieras +1",
    neck="Mirage Stole +1",
    waist="Sailfi Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Karieyh Ring",
    right_ring="Rufescent Ring",
    back="Rosmerta's cape",
	}

sets.precast.WS['Chant du Cygne'] = {
    ammo="Aurgelmir Orb +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Ayanmo Corazza",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ayanmo Cosciales",
    feet="Aya. Gambieras +1",
    neck="Mirage Stole +1",
    waist="Prosilio Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Karieyh Ring",
    right_ring="Rajas Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+6',}},
	}
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Mantoptera Eye",
    head="Shned. Chapeau +1",
    body="Teal Saio",
    hands={ name="Leyline Gloves", augments={'Accuracy+6','Mag. Acc.+2','"Mag.Atk.Bns."+6',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Baetyl Pendant",
    waist="Twilight Belt",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Sangoma Ring",
    right_ring="Rajas Ring",
    back="Swith Cape +1",
}

        
    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Assim. Jubbah +1",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Prosilio Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",
}

    sets.midcast['Blue Magic'].PhysicalAcc = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Jhakri Robe",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Prosilio Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",
}

    sets.midcast['Blue Magic'].PhysicalStr = {   
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Ayanmo Corazza",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Prosilio Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",}

    sets.midcast['Blue Magic'].PhysicalDex = {main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Ayanmo Corazza",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Prosilio Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",}

    sets.midcast['Blue Magic'].PhysicalVit = {main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    hhead={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Ayanmo Corazza",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Prosilio Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",}

    sets.midcast['Blue Magic'].PhysicalAgi = {main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Ayanmo Corazza",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Prosilio Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",}
	
    sets.midcast['Blue Magic'].PhysicalInt = {main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head="Shned. Chapeau +1",
    body="Jhakri Robe",
    hands={ name="Leyline Gloves", augments={'Accuracy+6','Mag. Acc.+2','"Mag.Atk.Bns."+6',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Twilight Belt",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",}

    sets.midcast['Blue Magic'].PhysicalMnd = {main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head="Shned. Chapeau +1",
    body="Jhakri Robe",
    hands={ name="Leyline Gloves", augments={'Accuracy+6','Mag. Acc.+2','"Mag.Atk.Bns."+6',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Twilight Belt",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",}


    sets.midcast['Blue Magic'].PhysicalHP = {main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head="Shned. Chapeau +1",
    body="Jhakri Robe",
    hands={ name="Leyline Gloves", augments={'Accuracy+6','Mag. Acc.+2','"Mag.Atk.Bns."+6',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Prosilio Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",}


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Hydrocera",
    head="Weath. Corona +1",
    body="Jhakri Robe",
    hands={ name="Leyline Gloves", augments={'Accuracy+6','Mag. Acc.+2','"Mag.Atk.Bns."+6',}},
    legs="Gyve Trousers",
    feet="Weath. Souliers +1",
    neck="Baetyl Pendant",
    waist="Twilight Belt",
    left_ear="Hecate's Earring",
    right_ear="Friomisi Earring",
    left_ring="Sangoma Ring",
    right_ring="Mujin Band",
    back="Rosmerta's cape",
}

    sets.midcast['Blue Magic'].MagicAccuracy = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Hydrocera",
    head="Weath. Corona +1",
    body="Jhakri Robe",
    hands={ name="Leyline Gloves", augments={'Accuracy+6','Mag. Acc.+2','"Mag.Atk.Bns."+6',}},
    legs="Gyve Trousers",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Eddy Necklace",
    waist="Twilight Belt",
    left_ear="Psystorm Earring",
    right_ear="Friomisi Earring",
    left_ring="Sangoma Ring",
    right_ring="Strendu Ring",
    back="Rosmerta's cape",
}
 

    -- Other Types --
    



    
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    
    -- Idle sets
    sets.idle = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head="Ayanmo Zucchetto +1",
    body="Ayanmo Corazza",
    hands={ name="Herculean Gloves", augments={'Attack+25','"Triple Atk."+3','DEX+5',}},
    legs="Ayanmo Cosciales",
    feet="Aya. Gambieras +1",
    neck="Twilight Torque",
    waist="Carrier's Sash",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Defending Ring",
    right_ring="Rajas Ring",
    back="Vespid Mantle",
}

    sets.idle.Town = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head="Shned. Chapeau +1",
    body="Jhakri Robe",
    hands={ name="Leyline Gloves", augments={'Accuracy+6','Mag. Acc.+2','"Mag.Atk.Bns."+6',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Twilight Belt",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",

}

	

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Twilight Belt",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Defending Ring",
    back="Rosmerta's cape",
}

    sets.engaged.Acc = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Twilight Belt",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",
}

    sets.engaged.DW = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Twilight Belt",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",
}

    sets.engaged.DW.Acc = {
    main="Thibron",
    sub={ name="Colada", augments={'Haste+2','Accuracy+9','Attack+9','DMG:+18',}},
    ammo="Aurgelmir Orb +1",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ayanmo Cosciales",
    feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},
    neck="Mirage Stole +1",
    waist="Twilight Belt",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back="Rosmerta's cape",
}

-- Defense Sets
	sets.defense.PDT = {
    ammo="Aurgelmir Orb +1",
    head="Ayanmo Zucchetto +1",
    body="Ayanmo Corazza",
    hands={ name="Herculean Gloves", augments={'Attack+25','"Triple Atk."+3','DEX+5',}},
    legs="Ayanmo Cosciales",
    feet="Aya. Gambieras +1",
    neck="Mirage Stole +1",
    waist="Twilight Belt",
    left_ear="Mache Earring +1",
    right_ear="Suppanomimi",
    left_ring="Defending Ring",
    right_ring="Rajas Ring",
    back="Vespid Mantle",
	}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
        set_macro_page(1, 8)
    end



