-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
----------------------------------------------------------------------------------------
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end
---------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
    main="Iridal Staff",
    sub="Achaq Grip",
    ammo="Incantor Stone",
    head="Welkin Crown",
    body="Teal Saio",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Gyve Trousers",
    feet="Regal Pumps",
    neck="Baetyl Pendant",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Pahtli Cape",
}
    
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC)

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC)

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = {
	main="Iridal Staff",
    sub="Achaq Grip",
    ammo="Incantor Stone",
    head="Welkin Crown",
    body="Teal Saio",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Orsn. Pantaln. +1",
    feet="Hygieia Clogs",
    neck="Baetyl Pendant",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Pahtli Cape",
}
    
    
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {}

    -- Waltz set (chr and vit)

    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = {}
    gear.default.weaponskill_waist = {}
    sets.precast.WS = {}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
	main="Iridal Staff",
    sub="Achaq Grip",
    ammo="Incantor Stone",
    head="Welkin Crown",
    body="Teal Saio",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Gyve Trousers",
    feet="Regal Pumps",
    neck="Noetic Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Pahtli Cape",
     }
    
    -- Cure sets
    gear.default.obi_waist = {}
    gear.default.obi_back = {}
    
    
    
    sets.midcast.Curaga ={
	main="Iridal Staff",
    sub="Achaq Grip",
    ammo="Incantor Stone",
    head="Orison Cap +1",
    body="Ebers Bliaut",
    hands="Bokwus Gloves",
    legs="Gyve Trousers",
    feet="Hygieia Clogs",
    neck="Noetic Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Orison Cape",
    }
    
    sets.midcast.CuragaSolace ={
	main="Iridal Staff",
    sub="Achaq Grip",
    ammo="Incantor Stone",
    head="Orison Cap +1",
    body="Ebers Bliaut",
    hands="Bokwus Gloves",
    legs="Gyve Trousers",
    feet="Hygieia Clogs",
    neck="Noetic Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Orison Cape",
    }

	 sets.midcast.CureSolace = {
	 main="Iridal Staff",
    sub="Achaq Grip",
    ammo="Incantor Stone",
    head="Orison Cap +1",
    body="Ebers Bliaut",
    hands="Bokwus Gloves",
    legs="Gyve Trousers",
    feet="Hygieia Clogs",
    neck="Noetic Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Orison Cape",
}


    sets.midcast.Cure = {
	main="Iridal Staff",
    sub="Achaq Grip",
    ammo="Incantor Stone",
    head="Orison Cap +1",
    body="Ebers Bliaut",
    hands="Bokwus Gloves",
    legs="Gyve Trousers",
    feet="Hygieia Clogs",
    neck="Noetic Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Orison Cape",
}

    sets.midcast.Cursna = {
    main={ name="Rubicundity", augments={'Mag. Acc.+5','"Mag.Atk.Bns."+1',}},
    sub="Sors Shield",
    ammo="Hydrocera",
    head="Orison Cap +1",
    body="Ebers Bliaut",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Orsn. Pantaln. +1",
    feet="Regal Pumps",
    neck="Henic Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Haoma's ring",
    right_ring="Haoma's ring",
    back="Mending Cape",
	}

    sets.midcast.StatusRemoval = {
    }

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
    main={ name="Rubicundity", augments={'Mag. Acc.+5','"Mag.Atk.Bns."+1',}},
    sub="Sors Shield",
    ammo="Hydrocera",
    head="Orison Cap +1",
    body="Ebers Bliaut",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Orsn. Pantaln. +1",
    feet="Regal Pumps",
    neck="Henic Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Mending Cape",
}

    sets.midcast.Stoneskin = {
   main={ name="Rubicundity", augments={'Mag. Acc.+5','"Mag.Atk.Bns."+1',}},
    sub="Sors Shield",
    ammo="Hydrocera",
    head="Orison Cap +1",
    body="Ebers Bliaut",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Orsn. Pantaln. +1",
    feet="Regal Pumps",
    neck="Henic Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Mending Cape",
	}
   
    sets.midcast.BarElement = 
    {main={ name="Rubicundity", augments={'Mag. Acc.+5','"Mag.Atk.Bns."+1',}},
    sub="Sors Shield",
    ammo="Hydrocera",
    head="Orison Cap +1",
    body="Ebers Bliaut",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Orsn. Pantaln. +1",
    feet="Regal Pumps",
    neck="Henic Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Mending Cape",
}

    sets.midcast.Regen = 
    {main={ name="Rubicundity", augments={'Mag. Acc.+5','"Mag.Atk.Bns."+1',}},
    sub="Sors Shield",
    ammo="Hydrocera",
    head="Orison Cap +1",
    body="Ebers Bliaut",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Orsn. Pantaln. +1",
    feet="Regal Pumps",
    neck="Henic Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Mending Cape",
}

    sets.midcast.Haste = 
    {main={ name="Rubicundity", augments={'Mag. Acc.+5','"Mag.Atk.Bns."+1',}},
    sub="Sors Shield",
    ammo="Hydrocera",
    head="Orison Cap +1",
    body="Ebers Bliaut",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Orsn. Pantaln. +1",
    feet="Regal Pumps",
    neck="Henic Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Mending Cape",
}



    -- Custom spell classes

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
    main={ name="Rubicundity", augments={'Mag. Acc.+5','"Mag.Atk.Bns."+1',}},
    sub="Sors Shield",
    ammo="Hydrocera",
    head="Welkin Crown",
    body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Gyve Trousers",
    feet="Regal Pumps",
    neck="Chrys. Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Aptitude Mantle +1",
    }
    
    sets.idle.Town = {
    main={ name="Rubicundity", augments={'Mag. Acc.+5','"Mag.Atk.Bns."+1',}},
    sub="Sors Shield",
    ammo="Hydrocera",
    head="Welkin Crown",
    body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Gyve Trousers",
    feet="Regal Pumps",
    neck="Chrys. Torque",
    waist="Witful Belt",
    left_ear="Orison Earring",
	right_ear="Mendi. Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back="Aptitude Mantle +1",
    }
    
    
    -- Defense sets


    sets.Kiting = {
    }

    sets.latent_refresh = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Twilight Cape"
    else
        gear.default.obi_back = "Orison Cape"
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.action_type=="Magic" and buffactive.Silence then
        eventArgs.cancel = true
        send_command('input /item "Remedy" <me>')
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 9)
end

