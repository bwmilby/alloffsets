Script "stack_allOffsets_button_id_1022"

/*
# Name: button "Offset" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1022 of bkgnd id 1013 of stack "allOffsets"
*/


on mouseUp
   local tStart
   
   put the milliseconds into tStart
   repeat with i = 1 to 1000
      get bwmOffsets(field "needle", field "haystack")
   end repeat
   put the milliseconds - tStart & "ms /" && the number of items of it & ": " after field "results"
   put bwmOffsets(field "needle", field "haystack") after field "results"
   put cr after field "results"
end mouseUp


function bwmOffsets pDelim, pString, pCaseSensitive
   local tNewPos, tPos, tResult
   
   set the caseSensitive to pCaseSensitive is true
   
   put 0 into tPos
   repeat forever
      put offset(pDelim, pString, tPos) into tNewPos
      if tNewPos = 0 then exit repeat
      add tNewPos to tPos
      put tPos,"" after tResult
   end repeat
   
   if tResult is empty then return 0
   else return char 1 to -2 of tResult
end bwmOffsets
