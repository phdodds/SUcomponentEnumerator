#----------------------------------------------------------------------------#
# componentEnumerator.rb
# Copyright 2016, Peter Dodds

# This software is provided as tool to aid in the creation of loudspeaker
# groups in SketchUp for use in EASE modeling

# Permission to use, copy, modify, and distribute this software for 
# any purpose is not granted without prior permission from the author.

# THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#----------------------------------------------------------------------------#

# Pull in the SketchUp API
#include 'sketchup.rb'

#look at the active sketchup model handle
model = Sketchup.active_model
entities = model.entities

#get the active selected set handle
selection = model.selection

#ensure that the user has selected something
if selection.count == 0
	UI.messagebox('Please select a collection of components.')
end

#prompt the user for the component collection name
 prompts = ["Enter component collection name "]
 defaults = ["Name"]
 userName = UI.inputbox(prompts, defaults, "Name your component collection")
 userName = userName[0] #set the variable to the user's entered value


# ensure that each object in the selection is a component instance
selection.each_with_index do |componentSel, index| #for each object in the selection
	if componentSel.is_a?(Sketchup::ComponentInstance) #if it is a component instance
		name = componentSel.name #retrieve the name (not definition) of the component in the selection

int = index+1  #start counting at 1
		int = int.to_s #convert int from Fixnum to String
		name = userName+int #name will be the user's entered name plus the int
		componentSel.name = name #make the component's name the userName+int
	else
		#if it isn't display the error and exit the loop
		UI.messagebox('Selection must be a component or collection of components.') 
		exit
	end
end


