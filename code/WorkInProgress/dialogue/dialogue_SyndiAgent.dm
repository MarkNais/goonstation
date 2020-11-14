/obj/dialogueobj/syndicomms
	name = "Odd Console"
	icon = 'icons/misc/factionreps.dmi'
	icon_state = "syndicomms"
	density = 1
	anchored = 2
	var/datum/dialogueMaster/dialogue = null

	New()
		dialogue = new/datum/dialogueMaster/syndi_faction(src)
		..()

	attack_hand(mob/user as mob)
		if(get_dist(usr, src) > 1 || usr.z != src.z) return
		dialogue.showDialogue(user)
		return

	attackby(obj/item/W as obj, mob/user as mob)
		return attack_hand(user)

/datum/dialogueMaster/syndi_faction
	dialogueName = "Odd Console"
	start = /datum/dialogueNode/syndi_start
	visibleDialogue = 0
	maxDistance = 1

/datum/dialogueNode/
	syndi_start
		nodeImage = "synditango.png"
		linkText = "..."
		links = list(/datum/dialogueNode/test_a,/datum/dialogueNode/test_c,/datum/dialogueNode/test_d,/datum/dialogueNode/test_f)
		var/lastComplaint = 0

		getNodeText(var/client/C)
			var/rep = C.reputations.get_reputation_level("syndi")
			var/rank = C.reputations.get_Syndicate_rank_string("syndi")
			switch(rep)
				if(0)
					return "Hello [C.mob.name]. What business do you have with me?"
				if(-3 to -1)
					return "Smelly."
				if(-4)
					return "Hey nerdo. Your code sucks MASSIVE EGGS."
				if(-6 to -5)
					return "Pooby."
				if(1 to 3)
					return "Good to see you [rank] [C.mob.name]!"
				if(4 to 6)
					return "Hope you're having an excellent day [rank] [C.mob.name]!"
			return ""

	test_a
		nodeImage = "synditango.png"
		linkText = "No it doesn't!"
		nodeText = "Fine. I'll check your code again."
		links = list(/datum/dialogueNode/test_b)

	test_b
		nodeImage = "synditango.png"
		linkText = "Thanks bud."
		nodeText = "Would you look at that. It's even worse than last time!"
		links = list()

	test_c
		nodeImage = "synditango.png"
		linkText = "Yeah... It does..."
		nodeText = "Loser."
		links = list()

	test_d
		nodeImage = "synditango.png"
		linkText = "Here is a butt."
		links = list(/datum/dialogueNode/test_e)

		canShow(var/client/C)
			if(istype(C.mob.equipped(), /obj/item/clothing/head/butt)) return 1
			else return 0

		getNodeText(var/client/C)
			var/rank = C.reputations.get_Syndicate_rank_string("syndi")
			return "Thanks. Butt no thanks [rank]"

	test_e
		nodeImage = "snyditango.png"
		linkText = "TAKE IT NERD!"
		nodeText = ""
		links = list()

		getNodeText(var/client/C)
			var/rank = C.reputations.get_Syndicate_rank_string("syndi")
			return "You suck [rank]."

		canShow(var/client/C)
			if(istype(C.mob.equipped(), /obj/item/clothing/head/butt)) return 1
			else return 0

		onActivate(var/client/C)
			qdel(C.mob.equipped())
			C.reputations.set_reputation(id = "syndi",amt = -1000,absolute = 0)
			boutput(C.mob, "<span class='success'>Your standing with the Syndicate has decreased by -1000!</span>")
			return

	test_f
		nodeImage = "synditango.png"
		linkText = "I am a nerd."
		nodeText = "I knew it!"
		links = list()

		canShow(var/client/C)
			var/rep = C.reputations.get_reputation_level("syndi")
			if(master.getFlag(C, "dim_nerd") == "taken" || rep < -5 ) return 0
			else return 1

		onActivate(var/client/C)
			master.setFlag(C, "dim_nerd", "taken")
			C.mob.put_in_hand_or_drop(/obj/item/clothing/head/cakehat, C.mob.hand)
			return
