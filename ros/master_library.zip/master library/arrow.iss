function main()
{
	echo start
	declare Check string "arrow"
	while 1
	{
		if ${Me.InCombat} == True
		{
			wait 20
			if ${Me.Pet[0].Health} >= 80
			{
				wait 25
				if ${Me.Pet[0].Health} >= 80
				{
					wait 25
					Check:Set[${Me.Maintained["Vengeful Arrow"]}]
					if ${Check.NotEqual["Vengeful Arrow"]} && ${Me.Pet[0].Health} >= 80
					{
						echo Checks passed, Casting arrow!
						while ${Me.CastingSpell}==True
						{
							wait 25
						}
						OgreBotAtom a_CastFromUplink ${Me.Name} "Vengeful Arrow" TRUE
						wait 30
					}
					else
					{
						continue
						echo focusing on healing!
						wait 25
					}
				}
			}
		}
	}	
}