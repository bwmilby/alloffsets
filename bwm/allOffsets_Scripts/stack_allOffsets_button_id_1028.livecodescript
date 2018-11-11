Script "stack_allOffsets_button_id_1028"

/*
# Name: button "MouseUpBehavior" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1028 of bkgnd id 1013 of stack "allOffsets"
*/


on mouseUp
   local tError, tStart, tTime
   local tNeedle, tHaystack, tCaseSensitive, tNoOverlaps, tLen
   
   put field "needle" into tNeedle
   put field "haystack" into tHaystack
   put the hilite of button "Case Sensitive" into tCaseSensitive
   put the hilite of button "No Overlaps" into tNoOverlaps
   put len(tHaystack) into tLen
   
   if word 2 of the target is quote&"Offset"&quote then
      put empty into field "results"
      put tLen into field "length"
   end if
   
   put the milliseconds into tStart
   repeat with i = 1 to 1000
      get allOffsets(tNeedle, tHaystack, tCaseSensitive, tNoOverlaps)
   end repeat
   put the milliseconds - tStart into tTime
   put word 2 of the target & tab after field "results"
   put tTime & "ms" & tab & the number of items of it & tab after field "results"
   put the last item of it > tLen into tError
   put allOffsets(tNeedle, tHaystack, tCaseSensitive, tNoOverlaps) after field "results"
   if tError then put " [Wrong]" after field "results"
   put cr after field "results"
end mouseUp
