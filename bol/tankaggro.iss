;This script when run on tank client will change tank's target to any mob targeting a friendly that is not the tank

; Set logging variable to TRUE if you want Innerspace console, Ogre console, or group chat output
variable(global) bool logtoconsole=TRUE
variable(global) bool logtoogreconsole=FALSE
variable(global) bool logtogroupchat=FALSE

variable(global) bool verboselogging=FALSE   /* Verbose logging for aggro and targets.  Default is disabled. */

function main(string Tank=${Me.Name})
{
	ext -require isxeq2

	if (${logtoconsole})
		echo Starting script to keep aggro on ${Tank}
	if (${logtoogreconsole})
		oc Starting script to keep aggro on ${Tank}
	if (${logtogroupchat})
		eq2execute gs Starting script to keep aggro on ${Tank}

	do
	{
		call CheckMTAggro ${Tank}
		waitframe
		wait 10
	}
	while 1
}

function Lost_Aggro(int mobid, string targetname)
{
	if ${Target.ID} != ${mobid}
	{
		if (${verboselogging})
		{
			if (${logtoconsole})
				echo Targeting ${Actor[${mobid}].Name} to get aggro back from ${targetname}
			if (${logtoogreconsole})
				oc Targeting ${Actor[${mobid}].Name} to get aggro back from ${targetname}
			if (${logtogroupchat})
				eq2execute gs Targeting ${Actor[${mobid}].Name} to get aggro back from ${targetname}
		}
		Target ${mobid}
		wait 30
	} 
	else 
	{
		if (${verboselogging})
		{
			if (${logtoconsole})
				echo Tank is targeting the mob, but ${targetname} still has aggro.
			if (${logtoogreconsole})
				oc Tank is targeting the mob, but ${targetname} still has aggro.
			if (${logtogroupchat})
				eq2execute gs Tank is targeting the mob, but ${targetname} still has aggro.
		}
	}

}

function CheckMTAggro(string Tank)
{
    	variable index:actor Actors
    	variable iterator ActorIterator
	variable int actorid


    	EQ2:QueryActors[Actors, Type  =- "NPC" && Distance <= 25]  
    	Actors:GetIterator[ActorIterator]

   	if ${ActorIterator:First(exists)}
	{
		do
		{
			if ${ActorIterator.Value.InCombatMode}
			{
				if ${ActorIterator.Value.Target.ID} != ${Actor[name,${Tank}].ID}
				{
					actorid:Set[${ActorIterator.Value.ID}]
				
					If (${verboselogging})
					{
           					if (${logtoconsole})
							echo Target: ${ActorIterator.Value.Name} is in combat and targeting ${ActorIterator.Value.Target.Name}
           					if (${logtoogreconsole})
							oc Target: ${ActorIterator.Value.Name} is in combat and targeting ${ActorIterator.Value.Target.Name}
           					if (${logtogroupchat})
							eq2execute gs Target: ${ActorIterator.Value.Name} is in combat and targeting ${ActorIterator.Value.Target.Name}
					}

					if (${Actor[${actorid}].IsDead} || ${Actor[${actorid}].Target.Name.Equal[Ancestral Sentry]})

					{
						continue
					}
		

					if (${Me.Grouped} || ${Me.InRaid})
					{
						if (${verboselogging})
						{
							if (${logtoconsole})
								echo Check if mob is aggro on group or raid player or pet
							if (${logtoogreconsole})
								oc Check if mob is aggro on group or raid player or pet
							if (${logtogroupchat})
								eq2execute gs Check if mob is aggro on group or raid player or pet
						}

						if ${Actor[${actorid}].Target.InMyGroup} 
						{
							if (${verboselogging})
							{
								if (${logtoconsole})
									echo Aggro detected on group or raid.
								if (${logtoogreconsole})
									oc Aggro detected on group or raid.
								if (${logtogroupchat})
									eq2execute gs Aggro detected on group or raid.
							}
							call Lost_Aggro ${actorid} ${ActorIterator.Value.Target.Name}
							return
						}

					}
				}
			}
		}
        	while ${ActorIterator:Next(exists)}
	}
}
