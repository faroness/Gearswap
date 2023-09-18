-- Original: Motenten / Modified: Arislan

-- Haste/DW Detection Requires Gearinfo Addon



-------------------------------------------------------------------------------------------------------------------

--  Keybinds

-------------------------------------------------------------------------------------------------------------------



  --Modes:      [ F9 ]              Cycle Offense Modes

--              [ CTRL+F9 ]         Cycle Hybrid Modes

--              [ WIN+F9 ]          Cycle Weapon Skill Modes

--              [ F10 ]             Emergency -PDT Mode

--              [ ALT+F10 ]         Toggle Kiting Mode

--              [ F11 ]             Emergency -MDT Mode

--              [ F12 ]             Update Current Gear / Report Current Status

--              [ CTRL+F12 ]        Cycle Idle Modes

--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode

--              [ CTRL+` ]          Cycle Treasure Hunter Mode

--              [ WIN+C ]           Toggle Capacity Points Mode

--

--  Abilities:  [ ALT+` ]           Flee

--              [ CTRL+Numpad/ ]    Berserk

--              [ CTRL+Numpad* ]    Warcry

--              [ CTRL+Numpad- ]    Aggressor

--              [ CTRL+Numpad0 ]    Sneak Attack

--              [ CTRL+Numpad. ]    Trick Attack

--

--  Spells:     [ WIN+, ]           Utsusemi: Ichi

--              [ WIN+. ]           Utsusemi: Ni

--

--  WS:         [ CTRL+Numpad7 ]    Exenterator

--              [ CTRL+Numpad8 ]    Mandalic Stab

--              [ CTRL+Numpad4 ]    Evisceration

--              [ CTRL+Numpad5 ]    Rudra's Storm

--              [ CTRL+Numpad1 ]    Aeolian Edge

--

--

--              (Global-Binds.lua contains additional non-job-related keybinds)





-------------------------------------------------------------------------------------------------------------------

--  Custom Commands (preface with /console to use these in macros)

-------------------------------------------------------------------------------------------------------------------



--  gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.

--

--  TH Modes:  None                 Will never equip TH gear

--             Tag                  Will equip TH gear sufficient for initial contact with a mob (either melee,

--

--             SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA

--             Fulltime - Will keep TH gear equipped fulltime





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

    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false

    state.Buff['Trick Attack'] = buffactive['trick attack'] or false

    state.Buff['Feint'] = buffactive['feint'] or false



    include('Mote-TreasureHunter')



    -- For th_action_check():

    -- JA IDs for actions that always have TH: Provoke, Animated Flourish

    info.default_ja_ids = S{35, 204}

    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish

    info.default_u_ja_ids = S{201, 202, 203, 205, 207}



    state.CP = M(false, "Capacity Points Mode")



    lockstyleset = 81

end



-------------------------------------------------------------------------------------------------------------------

-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.

-------------------------------------------------------------------------------------------------------------------



-- Setup vars that are user-dependent.  Can override this function in a sidecar file.

function user_setup()

    state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')

    state.HybridMode:options('Normal', 'DT')

    state.RangedMode:options('Normal', 'Acc')

    state.WeaponskillMode:options('Normal', 'Acc')

    state.IdleMode:options('Normal', 'DT')



    -- Additional local binds

    


    send_command('bind ^` gs c cycle treasuremode')

    send_command('bind !` input /ja "Flee" <me>')

    send_command('bind @c gs c toggle CP')



    send_command('bind ^numlock input /ja "Assassin\'s Charge" <me>')



    if player.sub_job == 'WAR' then

        send_command('bind ^numpad/ input /ja "Berserk" <me>')

        send_command('bind ^numpad* input /ja "Warcry" <me>')

        send_command('bind ^numpad- input /ja "Aggressor" <me>')

    elseif player.sub_job == 'SAM' then

        send_command('bind ^numpad/ input /ja "Meditate" <me>')

        send_command('bind ^numpad* input /ja "Sekkanoki" <me>')

        send_command('bind ^numpad- input /ja "Third Eye" <me>')

    end



    send_command('bind ^numpad7 input /ws "Exenterator" <t>')

    send_command('bind ^numpad8 input /ws "Mandalic Stab" <t>')

    send_command('bind ^numpad4 input /ws "Evisceration" <t>')

    send_command('bind ^numpad5 input /ws "Rudra\'s Storm" <t>')

    send_command('bind ^numpad1 input /ws "Aeolian Edge" <t>')



    send_command('bind ^numpad0 input /ja "Sneak Attack" <me>')

    send_command('bind ^numpad. input /ja "Trick Attack" <me>')



    select_default_macro_book()

    set_lockstyle()



    Haste = 0

    DW_needed = 0

    DW = false

    moving = false

    update_combat_form()

    determine_haste_group()

end





-- Called when this job file is unloaded (eg: job change)

function user_unload()

    send_command('unbind ^`')

    send_command('unbind !`')

    send_command('unbind ^,')

    send_command('unbind @c')

    send_command('unbind @r')

    send_command('unbind ^numlock')

    send_command('unbind ^numpad/')

    send_command('unbind ^numpad*')

    send_command('unbind ^numpad-')

    send_command('unbind ^numpad7')

    send_command('unbind ^numpad8')

    send_command('unbind ^numpad4')

    send_command('unbind ^numpad5')

    send_command('unbind ^numpad1')

    send_command('unbind ^numpad0')

    send_command('unbind ^numpad.')



    send_command('unbind #`')

    send_command('unbind #1')

    send_command('unbind #2')

    send_command('unbind #3')

    send_command('unbind #4')

    send_command('unbind #5')

    send_command('unbind #6')

    send_command('unbind #7')

    send_command('unbind #8')

    send_command('unbind #9')

    send_command('unbind #0')

end





-- Define sets and vars used by this job file.

function init_gear_sets()



    ------------------------------------------------------------------------------------------------

    ---------------------------------------- Precast Sets ------------------------------------------

    ------------------------------------------------------------------------------------------------



    sets.TreasureHunter = {
		
	
        hands="Plunderer's Armlets +1", --3

        feet="Skulker's Poulaines", --2

        ammo="Perfect Lucky Egg", --1

        }



    sets.buff['Sneak Attack'] = {

		-- Sneak attack adds dex as damage on top of guaranteeing a critical hit.

        ammo="Aurgelmir Orb +1",

        head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},

        body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},

        hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},

        legs="Lustratio subligar",

        feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},

        neck="Asn. Gorget +1",

        ear1="Crep. Earring",

        ear2="Mache Earring +1",

        ring1="Petrov Ring",

        ring2="Rajas Ring",
        
        waist="Sailfi Belt",

        back="Atheling Mantle",
		
		}


    sets.buff['Trick Attack'] = {

        ammo="Aurgelmir Orb +1",

        head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},

        body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},

        hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},

        legs={ name="Herculean Trousers", augments={'Attack+24','"Triple Atk."+2','DEX+8',}},

        feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},

        neck="Houyi's Gorget",

        ear1="Crep. Earring",

        ear2="Mache Earring +1",

        ring1="Petrov Ring",

        ring2="Rajas Ring",
        
        waist="Sailfi Belt",

        back="Atheling Mantle"

		}

    -- Actions we want to use to tag TH.

    sets.precast.Step = sets.TreasureHunter

    sets.precast.Flourish1 = sets.TreasureHunter

    sets.precast.JA.Provoke = sets.TreasureHunter
    
    sets.precast.JA.Bully = sets.TreasureHunter





    ------------------------------------------------------------------------------------------------

    ---------------------------------------- Precast Sets ------------------------------------------

    ------------------------------------------------------------------------------------------------



    -- Precast sets to enhance JAs

    --sets.precast.JA['Collaborator'] = {}

    --sets.precast.JA['Accomplice'] = {}

    --sets.precast.JA['Flee'] = {feet="Pill. Poulaines +1"}

    --sets.precast.JA['Hide'] = {body="Pillager's Vest +1"}

    --sets.precast.JA['Conspirator'] = {body="Skulker's Vest +1"}



    sets.precast.JA['Steal'] = {

        neck="Rabbit Charm", --1

        }



    sets.precast.JA['Despoil'] = {feet="Skulk. Poulaines"}

    --sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +3"}

    --sets.precast.JA['Feint'] = {legs="Plunderer's Culottes +3"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']

    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']



    --[[sets.precast.Waltz = {

        ammo="Yamarang",

        body="Passion Jacket",

        legs="Dashing Subligar",

        neck="Phalaina Locket",

        ring1="Asklepian Ring",

        waist="Gishdubar Sash",

        }--]]



    --sets.precast.Waltz['Healing Waltz'] = {}



    --[[sets.precast.FC = {

    ammo="Impatiens",
    head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+25','Crit.hit rate+1','MND+2','Mag. Acc.+11',}},
    body="Foppish Tunica",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Malignance Tights",
    feet={ name="Herculean Boots", augments={'INT+7','Pet: STR+9','"Fast Cast"+6','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
    neck="Baetyl Pendant",
    waist="Chaac Belt",
    left_ear="Etiolation Earring",
    right_ear="Enchntr. Earring +1",
    left_ring="Prolix Ring",
    right_ring="Moonlight Ring",
    back="Moonlight Cape",
}--]]



    --[[sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {

        body="Passion Jacket",

        --ring1="Lebeche Ring",
        neck="Magoraga bead necklace",

        })--]]



    ------------------------------------------------------------------------------------------------

    ------------------------------------- Weapon Skill Sets ----------------------------------------

    ------------------------------------------------------------------------------------------------



    sets.precast.WS = {

        ammo="Aurgelmir Orb +1",

        head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},

        body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},

        hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},

        legs="Lustratio Subligar",

        feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},

        neck="Asn. Gorget +1",

        ear1="Steelflash Earring",

        ear2="Bladeborn Earring",

        ring1="Petrov Ring",

        ring2="Rajas Ring",
        
        waist="Prosilio Belt +1",

        back="Vespid Mantle",

        } -- default set



    --[[sets.precast.WS.Acc = set_combine(sets.precast.WS, {

        ammo="Honed Tathlum",

        --legs="Meg. Chausses +2",

        ear1="Mache Earring +1",

        })--]]



    --sets.precast.WS.Critical = {ammo="Yetshila +1", body="Plunderer's Vest +3", legs="Lustratio subligar +1"}



    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {

        body="Meghanada Cuirie",

        legs={ name="Herculean Trousers", augments={'Attack+24','"Triple Atk."+2','DEX+8',}},

        feet="Pursuer's Gaiters",
        
        waist="Soil Belt",

        })



    --[[sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {

        ammo="Honed Tathlum",

        head="Plunderer's Bonnet +3",

        })--]]



    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {

        head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},

        body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},

        hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},

        legs="Lustratio Subligar",

        feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},

        neck="Love Torque",

        ear1="Crep. Earring",

        ear2="Mache Earring +1",
        
        waist="Soil Belt",


        })



    --[[sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {

        --ammo="Falcon Eye",

        head="Pillager's Bonnet +2",

        ring1="Regal Ring",

        })--]]



    --[[sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {

        ammo="Jukukik Feather",

        neck="Assassin's Gorget +2",

        ear1="Odr Earring",

        waist="Grunfeld Rope",

        })



    sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS['Rudra\'s Storm'], {

        --ammo="Falcon Eye",

        --legs=gear.Herc_WS_legs,

        --feet=gear.Herc_STP_feet,

        ear1="Mache Earring +1",

        ear2="Moonshade Earring",

        })



    sets.precast.WS['Mandalic Stab'] = sets.precast.WS["Rudra's Storm"]

    sets.precast.WS['Mandalic Stab'].Acc = sets.precast.WS["Rudra's Storm"].Acc



    sets.precast.WS['Aeolian Edge'] = {
    ammo="Seething Bomblet",
    ammo="Staunch Tathlum",
    head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+25','Crit.hit rate+1','MND+2','Mag. Acc.+11',}},
    body={ name="Herculean Vest", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','"Mag.Atk.Bns."+13',}},
    hands={ name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','MND+8','"Mag.Atk.Bns."+3',}},
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +1%','Mag. Acc.+6',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','"Fast Cast"+3','MND+2','"Mag.Atk.Bns."+6',}},
    neck="Baetyl Pendant",
    waist="Salire Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back="Toro Cape",
} 


    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)





    ------------------------------------------------------------------------------------------------

    ---------------------------------------- Midcast Sets ------------------------------------------

    ------------------------------------------------------------------------------------------------



    sets.midcast.FastRecast = sets.precast.FC



    sets.midcast.SpellInterrupt = {

        --ammo="Impatiens", --10

        --ring1="Evanescence Ring", --5

        }



    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt




--]]
    ------------------------------------------------------------------------------------------------

    ----------------------------------------- Idle Sets --------------------------------------------

    ------------------------------------------------------------------------------------------------



    sets.resting = {}



    sets.idle = {

        ammo="Sihirik",

        head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},

        body="Meghanada Cuirie",

        hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},

        legs={ name="Herculean Trousers", augments={'Attack+24','"Triple Atk."+2','DEX+8',}},

        feet="Fajin Boots",

        neck="Twilight Torque",

        ear1="Raider's Earring",

        ear2="Crep. Earring",

        ring1="Haoma's Ring",

        ring2="Haoma's Ring",

        back="Vespid Mantle",

        waist="Prosilio Belt +1",

        }
        
        sets.idle.Town = {

        ammo="Aurgelmir Orb +1",

        head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},

        body="Councilor's Garb",

        hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},

        legs={ name="Herculean Trousers", augments={'Attack+24','"Triple Atk."+2','DEX+8',}},

        feet="Fajin Boots",

        neck="Asn. Gorget +1",

        ear1="Steelflash Earring",

        ear2="Bladeborn Earring",

        ring1="Petrov Ring",

        ring2="Rajas Ring",
        
        waist="Prosilio Belt +1",

        back="Vespid Mantle",

        }



    --[[sets.idle.DT = set_combine(sets.idle, {

        ammo="Staunch Tathlum +1", --3/3

        head="Turms Cap +1",

        body="Turms Harness +1",

        hands="Malignance Gloves", --7/5

        legs="Malignance Tights", --5/5

        feet="Malignance Boots",

        neck={ name="Loricate Torque +1", augments={'Path: A',}}, --6/6

        ear1="Etiolation Earring", --2/0
        
        ear2="Genmei Earring",

        ring1="Defending Ring", --7/(-1)

        ring2="Moonlight Ring", --10/10

        back="Moonlight Cape", --6/6

        waist="Flume Belt +1", --4/0

        })



    sets.idle.Weak = sets.idle.DT





    ------------------------------------------------------------------------------------------------

    ---------------------------------------- Defense Sets ------------------------------------------

    ------------------------------------------------------------------------------------------------



    sets.defense.PDT = {

        ammo="Staunch Tathlum +1", --3/3

        head="Malignance Chapeau",
	
	    body="Malignance Tabard",

        hands="Malignance Gloves", --7/5

        legs="Malignance Tights", --5/5

        feet="Malignance Boots",

        neck={ name="Loricate Torque +1", augments={'Path: A',}}, --6/6

        ear1="Suppanomimi", 
        
        ear2="Sherida Earring",

        ring1="Moonlight Ring", --7/(-1)

        ring2="Moonlight Ring", --10/10

        back="Moonlight Cape", --6/6

        waist="Reiki Yotai", --4/0

        }

    sets.defense.MDT = {

        ammo="Staunch Tathlum +1", --3/3

        head="Malignance Chapeau",
	
	    body="Malignance Tabard",

        hands="Malignance Gloves", --7/5

        legs="Malignance Tights", --5/5

        feet="Malignance Boots",

        neck={ name="Loricate Torque +1", augments={'Path: A',}}, --6/6

        ear1="Suppanomimi", 
        
        ear2="Sherida Earring",

        ring1="Moonlight Ring", --7/(-1)

        ring2="Moonlight Ring", --10/10

        back="Moonlight Cape", --6/6

        waist="Reiki Yotai", --4/0

        }



    sets.Kiting = {feet="Jute Boots +1"}


--]]


    ------------------------------------------------------------------------------------------------

    ---------------------------------------- Engaged Sets ------------------------------------------

    ------------------------------------------------------------------------------------------------



    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous

    -- sets if more refined versions aren't defined.

    -- If you create a set with both offense and defense modes, the offense mode should be first.

    -- EG: sets.engaged.Dagger.Accuracy.Evasion



    sets.engaged = {

        main={ name="Ipetam", augments={'Quadruple Attack +1',}},
		
		sub="Izhiikoh",
		
		ammo="Aurgelmir Orb +1",

        head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},

        body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},

        hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},

        legs={ name="Herculean Trousers", augments={'Attack+24','"Triple Atk."+2','DEX+8',}},

        feet={ name="Herculean Boots", augments={'Accuracy+20','"Triple Atk."+4','AGI+3',}},

        neck="Asn. Gorget +1",

        ear1="Steelflash Earring",

        ear2="Bladeborn Earring",

        ring1="Petrov Ring",

        ring2="Rajas Ring",
        
        waist="Sailfi Belt",

        back="Vespid Mantle",

        }


--[[
    sets.engaged.LowAcc = set_combine(sets.engaged, {

        head="Plunderer's Bonnet +3",
		legs="Pillager's Culottes +3",

        --neck="Combatant's Torque",

        --ear2="Telos Earring",

        })



    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {

        ammo="Honed Tathlum",

        head="Plunderer's Bonnet +3",
		
		legs="Pillager's Culottes +3",

        body="Pillager's Vest +3",

        ear1="Mache Earring +1",

        ring1="Chirich Ring +1",
        
        ring2="Moonlight Ring",

        waist="Patentia Sash",

        })



    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {

        legs="Plunderer's Culottes +3",

        --feet=gear.Herc_STP_feet,

        ear1="Mache Earring +1",

        ring1="Chirich Ring +1",
        
        ring2="Moonlight Ring",

        waist="Patentia Sash",

        })



    sets.engaged.STP = set_combine(sets.engaged, {

        --neck="Anu Torque", 

        ear2="Sherida Earring",

        ear1="Dedition Earring",
        
        ring2="Chirich Ring +1",
   

        })



    -- * DNC Native DW Trait: 30% DW

    -- * DNC Job Points DW Gift: 5% DW



    -- No Magic Haste (74% DW to cap)

    sets.engaged.DW = {

        ammo="Aurgelmir Orb +1",

        head="Adhemar Bonnet +1",

        body="Pillager's Vest +3",

        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},

        legs="Pillager's Culottes +3",

        feet="Plunderer's Poulaines +3", --9

        neck="Assassin's Gorget +2",

        --ear1="Eabani Earring", --4

        ear2="Suppanomimi", --5

        ring1="Chirich Ring +1",

        ring2="Epona's Ring",

        --back=gear.THF_DW_Cape, --10

        waist="Patentia Sash", --7

        } -- 41%



    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {

        --head="Skulker's Bonnet +1",

        --neck="Combatant's Torque",

        })



    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {

        --head="Dampening Tam",

        --body="Pillager's Vest +3",

        ring1="Chirich Ring +1",
        
        ring2="Moonlight Ring",

        waist="Patentia Sash",

        })



    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {

        legs="Plunderer's Culottes +3",

        feet="Plunderer's Poulaines +3",

        ear1="Mache Earring +1",

        ear2="Mache Earring +1",

        ring1="Chirich Ring +1",
        
        ring2="Moonlight Ring",
        
        waist="Patentia Sash",

        })



    sets.engaged.DW.STP = set_combine(sets.engaged.DW, {

        --neck="Anu Torque",

        ring1="Chirich Ring +1",

        })



    -- 15% Magic Haste (67% DW to cap)

    sets.engaged.DW.LowHaste = {

        ammo="Aurgelmir Orb +1",

        head="Adhemar Bonnet +1",

        body="Pillager's Vest +3",

        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},

        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},

        feet="Plunderer's Poulaines +3", 

        neck="Assassin's Gorget +2",

        ear1="Mache Earring +1",

        ear2="Suppanomimi", --5

       ring1="Chirich Ring +1",

        ring2="Epona's Ring",

        --back=gear.THF_DW_Cape, --10

        waist="Patentia Sash", --5

        } -- 37%



    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {

        --head="Skulker's Bonnet +1",

        --neck="Combatant's Torque",

        })



    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {

        --head="Dampening Tam",

        --body="Pillager's Vest +3",

        ring1="Chirich Ring +1",

        waist="Windbuffet Belt +1",

        })



    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {

        legs="Plunderer's Culottes +3",

        --feet=gear.Herc_STP_feet,

        ear2="Mache Earring +1",

        ring1="Chirich Ring +1",

        ring2="Moonlight Ring",

        waist="Windbuffet Belt +1",

        })



    sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {

        --neck="Anu Torque",

        ring1="Chirich Ring +1",

        })



    -- 30% Magic Haste (56% DW to cap)

    sets.engaged.DW.MidHaste = {

        ammo="Aurgelmir Orb +1",

        head="Adhemar Bonnet +1",

        body="Pillager's Vest +3",

        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},

        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}},

        feet="Plunderer's Poulaines +3",

        neck="Erudit. Necklace",

        ear1="Mach Earring +1", 

        ear2="Suppanomimi", --5

        ring1="Chirich Ring +1",

        ring2="Epona's Ring",

        --back=gear.THF_DW_Cape, 

        --waist="Reiki Yotai", 

        } -- 26%



    sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {

        --head="Skulker's Bonnet +1",

        --neck="Combatant's Torque",

        })



    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {

        --head="Dampening Tam",

        --ear1="Cessance Earring",

        ring1="Chirich Ring +1",

        waist="Windbuffet Belt +1",

        })



    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {

        --legs="Plunderer's Culottes +3",

        --feet=gear.Herc_STP_feet,

        ear2="Mache Earring +1",

        ring1="Chirich Ring +1",

        ring2="Moonlight Ring",

        --waist="Olseni Belt",

        })



    sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {

        --neck="Anu Torque",

        --ear1="Sherida Earring",

        ring1="Chirich Ring +1",

        })



    -- 35% Magic Haste (51% DW to cap)

    sets.engaged.DW.HighHaste = {

        ammo="Aurgelmir Orb +1",

        head="Adhemar Bonnet +1",

        body="Adhemar Jacket +1",

        hands="Pillager's Vest +3",

        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}}, --6

        feet="Plunderer's Poulaines +3",

        neck="Assassin's Gorget +2",

        ear1="Mach Earring +1",
        
        ear2="Suppanomimi", --5

        ring1="Chirich Ring +1",

        ring2="Epona's Ring",

        --back=gear.THF_DW_Cape, --10

        waist="Patentia Sash", --5

        } -- 32%



    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {

        --head="Skulker's Bonnet +1",

        --neck="Combatant's Torque",

        })



    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {

        --head="Dampening Tam",

        ear1="Mache Earring +1",

        ring1="Chirich Ring +1",

        waist="Windbuffet Belt +1",

        })



    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {

        legs="Plunderer's Culottes +2",

        --feet=gear.Herc_STP_feet,

        ear2="Mache Earring +1",

        ring1="Chirch Ring +1",

        ring2="Moonlight Ring",

        --waist="Olseni Belt",

        })



    sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {

        --neck="Anu Torque",

        --ear1="Sherida Earring",

        --ear2="Telos Earring",

        --ring1="Chirich Ring",

        })



    -- 45% Magic Haste (36% DW to cap)

    sets.engaged.DW.MaxHaste = {

        ammo="Aurgelmir Orb +1",

        head="Adhemar Bonnet +1",

        body="Pillager's Vest +3",

        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},

        legs={ name="Samnuha Tights", augments={'STR+8','DEX+9','"Dbl.Atk."+3','"Triple Atk."+2',}}, --6

        feet="Plunderer's Poulaines +3",

        neck="Assassin's Gorget +2",

        ear1="Mach Earring +1",
        
        ear2="Suppanomimi", --5

        ring1="Chirich Ring +1",

        ring2="Epona's Ring",

        --back=gear.THF_DW_Cape, --10

        waist="Patentia Sash", --5

        } -- 32%



    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {

        --head="Skulker's Bonnet +1",

        --neck="Combatant's Torque",

        })



    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {

        --head="Dampening Tam",

        ear1="Mache Earring +1",

        ring2="Chirich Ring +1",

        waist="Windbuffet Belt +1",

        })



    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {

        legs="Plunderer's Culottes +2",

        --feet=gear.Herc_STP_feet,

        ear2="Mache Earring +1",

        ring1="Chirch Ring +1",

        ring2="Moonlight Ring",

        --waist="Olseni Belt",

        })



    sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {

        --neck="Anu Torque",

       -- ear1="Sherida Earring",

        --ear2="Telos Earring",

        ring2="Chirich Ring +1",

        waist="Windbuffet Belt +1",

        })



    ------------------------------------------------------------------------------------------------

    ---------------------------------------- Hybrid Sets -------------------------------------------

    ------------------------------------------------------------------------------------------------



    sets.engaged.Hybrid = {

        --head=gear.Adhemar_D_head, --4/0

        --neck={ name="Loricate Torque +1", augments={'Path: A',}}, --6/6

        ring1="Moonlight Ring", --5/5

        ring2="Defending Ring", --10/10

        }



    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)

    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)

    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)

    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)



    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)

    sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)

    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)

    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)



    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)



    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)



    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)



    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)





    ------------------------------------------------------------------------------------------------

    ---------------------------------------- Special Sets ------------------------------------------

    ------------------------------------------------------------------------------------------------



    sets.buff.Doom = {

        --neck="Nicander's Necklace", --20

        --ring1="Eshmun's Ring", --20

        --ring2="Eshmun's Ring", --20

        --waist="Gishdubar Sash", --10

        }

     --]]

    sets.Reive = {neck="Ygnas's Resolve +1"}

    sets.CP = {back="Aptitude Mantle +1"}



end





-------------------------------------------------------------------------------------------------------------------

-- Job-specific hooks for standard casting events.

-------------------------------------------------------------------------------------------------------------------



-- Run after the general precast() is done.

function job_post_precast(spell, action, spellMap, eventArgs)

    if spellMap == 'Utsusemi' then

        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then

            cancel_spell()

            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')

            eventArgs.handled = true

            return

        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then

            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')

        end

    end

    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then

        equip(sets.TreasureHunter)

    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' then

        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then

            equip(sets.TreasureHunter)

        end

    end

    if spell.type == "WeaponSkill" then

        if state.Buff['Sneak Attack'] == true or state.Buff['Trick Attack'] == true then

            equip(sets.precast.WS.Critical)

        end

    end

end



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.

function job_aftercast(spell, action, spellMap, eventArgs)

    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.

    if spell.type == 'WeaponSkill' and not spell.interrupted then

        state.Buff['Sneak Attack'] = false

        state.Buff['Trick Attack'] = false

        state.Buff['Feint'] = false

    end

end



-- Called after the default aftercast handling is complete.

function job_post_aftercast(spell, action, spellMap, eventArgs)

    -- If Feint is active, put that gear set on on top of regular gear.

    -- This includes overlaying SATA gear.

    check_buff('Feint', eventArgs)

end



-------------------------------------------------------------------------------------------------------------------

-- Job-specific hooks for non-casting events.

-------------------------------------------------------------------------------------------------------------------



-- Called when a player gains or loses a buff.

-- buff == buff gained or lost

-- gain == true if the buff was gained, false if it was lost.

function job_buff_change(buff,gain)



    if buffactive['Reive Mark'] then

        if gain then

            equip(sets.Reive)

            disable('neck')

        else

            enable('neck')

        end

    end

--[[

    if buff == "doom" then

        if gain then

            equip(sets.buff.Doom)

            send_command('@input /p Doomed.')

             disable('ring1','ring2','waist')

        else

            enable('ring1','ring2','waist')

            handle_equipping_gear(player.status)

        end

    end



    if not midaction() then

        handle_equipping_gear(player.status)

	end
--]]
end





-------------------------------------------------------------------------------------------------------------------

-- User code that supplements standard library decisions.

-------------------------------------------------------------------------------------------------------------------



-- Called by the 'update' self-command, for common needs.

-- Set eventArgs.handled to true if we don't want automatic equipping of gear.

function job_handle_equipping_gear(playerStatus, eventArgs)

    update_combat_form()

    determine_haste_group()

end



function job_update(cmdParams, eventArgs)

    handle_equipping_gear(player.status)

    th_update(cmdParams, eventArgs)

end



function update_combat_form()

    if DW == true then

        state.CombatForm:set('DW')

    elseif DW == false then

        state.CombatForm:reset()

    end

end



function get_custom_wsmode(spell, spellMap, defaut_wsmode)

    local wsmode



    if state.Buff['Sneak Attack'] then

        wsmode = 'SA'

    end

    if state.Buff['Trick Attack'] then

        wsmode = (wsmode or '') .. 'TA'

    end



    return wsmode

end



function customize_idle_set(idleSet)

    if state.CP.current == 'on' then

        equip(sets.CP)

        disable('back')

    else

        enable('back')

    end



    return idleSet

end



function customize_melee_set(meleeSet)

    if state.TreasureMode.value == 'Fulltime' then

        meleeSet = set_combine(meleeSet, sets.TreasureHunter)

    end



    return meleeSet

end



-- Function to display the current relevant user state when doing an update.

-- Return true if display was handled, and you don't want the default info shown.

function display_current_job_state(eventArgs)

    local msg = '[ Melee'



    if state.CombatForm.has_value then

        msg = msg .. ' (' .. state.CombatForm.value .. ')'

    end



    msg = msg .. ': '



    msg = msg .. state.OffenseMode.value

    if state.HybridMode.value ~= 'Normal' then

        msg = msg .. '/' .. state.HybridMode.value

    end

    msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value



    if state.DefenseMode.value ~= 'None' then

        msg = msg .. ' ][ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value

    end



    if state.Kiting.value then

        msg = msg .. ' ][ Kiting Mode: ON'

    end



    msg = msg .. ' ][ TH: ' .. state.TreasureMode.value



    msg = msg .. ' ]'



    add_to_chat(060, msg)



    eventArgs.handled = true

end





-------------------------------------------------------------------------------------------------------------------

-- Utility functions specific to this job.

-------------------------------------------------------------------------------------------------------------------



function determine_haste_group()

    classes.CustomMeleeGroups:clear()

    if DW == true then

        if DW_needed <= 6 then

            classes.CustomMeleeGroups:append('MaxHaste')

        elseif DW_needed > 6 and DW_needed <= 22 then

            classes.CustomMeleeGroups:append('HighHaste')

        elseif DW_needed > 22 and DW_needed <= 26 then

            classes.CustomMeleeGroups:append('MidHaste')

        elseif DW_needed > 26 and DW_needed <= 37 then

            classes.CustomMeleeGroups:append('LowHaste')

        elseif DW_needed > 37 then

            classes.CustomMeleeGroups:append('')

        end

    end

end



function job_self_command(cmdParams, eventArgs)

    gearinfo(cmdParams, eventArgs)

end



function gearinfo(cmdParams, eventArgs)

    if cmdParams[1] == 'gearinfo' then

        if type(tonumber(cmdParams[2])) == 'number' then

            if tonumber(cmdParams[2]) ~= DW_needed then

            DW_needed = tonumber(cmdParams[2])

            DW = true

            end

        elseif type(cmdParams[2]) == 'string' then

            if cmdParams[2] == 'false' then

        	    DW_needed = 0

                DW = false

      	    end

        end

        if type(tonumber(cmdParams[3])) == 'number' then

          	if tonumber(cmdParams[3]) ~= Haste then

              	Haste = tonumber(cmdParams[3])

            end

        end

        if type(cmdParams[4]) == 'string' then

            if cmdParams[4] == 'true' then

                moving = true

            elseif cmdParams[4] == 'false' then

                moving = false

            end

        end

        if not midaction() then

            job_update()

        end

    end

end





-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves

function job_pretarget(spell, action, spellMap, eventArgs)

    if spell.type == 'Step' then

        local allRecasts = windower.ffxi.get_ability_recasts()

        local prestoCooldown = allRecasts[236]

        local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']



        if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then

            cast_delay(1.1)

            send_command('input /ja "Presto" <me>')

        end

    end

end



-- State buff checks that will equip buff gear and mark the event as handled.

function check_buff(buff_name, eventArgs)

    if state.Buff[buff_name] then

        equip(sets.buff[buff_name] or {})

        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then

            equip(sets.TreasureHunter)

        end

        eventArgs.handled = true

    end

end





-- Check for various actions that we've specified in user code as being used with TH gear.

-- This will only ever be called if TreasureMode is not 'None'.

-- Category and Param are as specified in the action event packet.

function th_action_check(category, param)

    if category == 2 or -- any ranged attack

        --category == 4 or -- any magic action

        (category == 3 and param == 30) or -- Aeolian Edge

        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish

        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish

        then return true

    end

end



-- Select default macro book on initial load or subjob change.

function select_default_macro_book()

    -- Default macro set/book

    if player.sub_job == 'DNC' then

        set_macro_page(3, 1)

    elseif player.sub_job == 'WAR' then

        set_macro_page(3, 1)

    elseif player.sub_job == 'NIN' then

        set_macro_page(3, 1)

    else

        set_macro_page(3, 1)

    end

end



function set_lockstyle()

    send_command('wait 2; input /lockstyleset ' .. lockstyleset)

end