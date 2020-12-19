function main()
{
	echo start
	declare Check string "bigbootyhoes"
	while 1
	{
		if ${Me.InCombat} == True
		{
			wait 15
			if ${Me.Pet[0].Health} >= 80
			{
				wait 15
				if ${Me.Pet[0].Health} >= 80
				{
					wait 15
					Check:Set[${Me.Maintained["Construct's Sacrifice"]}]
					if ${Check.NotEqual["Construct's Sacrifice"]} && ${Me.Pet[0].Health} >= 80
					{
						echo Checks passed, Casting sacrifice!
						while ${Me.CastingSpell}==True
						{
							wait 1
						}
						OgreBotAtom a_CastFromUplink ${Me.Name} "Construct's Sacrifice" TRUE
						wait 30
					}
					else
					{
						continue
						echo Too much damage, skipping sacrifice!
						wait 10
					}
				}
			}
		}
	}	
}