Script "stack_allOffsets_button_id_1022"

/*
# Name: button "Offset" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1022 of bkgnd id 1013 of stack "allOffsets"
# Behavior: button id 1028 of stack "allOffsets"
*/


function allOffsets pDelim, pString, pCaseSensitive, pNoOverlap
   local tNewPos, tPos, tResult, tLen
   
   set the caseSensitive to pCaseSensitive is true
   
   put 0 into tPos
   if pNoOverlap then
      put the len of pDelim - 1 into tLen
      repeat forever
         put offset(pDelim, pString, tPos) into tNewPos
         if tNewPos = 0 then exit repeat
         add tNewPos to tPos
         put tPos,"" after tResult
         add tLen to tPos
      end repeat
   else
      repeat forever
         put offset(pDelim, pString, tPos) into tNewPos
         if tNewPos = 0 then exit repeat
         add tNewPos to tPos
         put tPos,"" after tResult
      end repeat
   end if
   
   if tResult is empty then return 0
   else return char 1 to -2 of tResult
end allOffsets
