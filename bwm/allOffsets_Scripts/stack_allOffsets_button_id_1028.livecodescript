Script "stack_allOffsets_button_id_1028"

/*
# Name: button "MouseUpBehavior" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1028 of bkgnd id 1013 of stack "allOffsets"
*/


on mouseUp
   local tStart, tTime, tError
   if word 2 of the target is quote&"Offset"&quote then put empty into field "results"
   
   put the milliseconds into tStart
   repeat with i = 1 to 1000
      get allOffsets(field "needle", field "haystack", false, false)
   end repeat
   put the milliseconds - tStart into tTime
   put word 2 of the target & tab after field "results"
   put tTime & "ms" & tab & the number of items of it & tab after field "results"
   put the last item of it > len(field "haystack") into tError
   put allOffsets(field "needle", field "haystack", false, false) after field "results"
   if tError then put " [Wrong]" after field "results"
   put cr after field "results"
end mouseUp
