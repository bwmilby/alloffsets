Script "stack_allOffsets_button_id_1041"

/*
# Name: button "Offset UTF32 v2" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1041 of bkgnd id 1013 of stack "allOffsets"
# Behavior: button id 1028 of stack "allOffsets"
*/


function allOffsets pFind, pString, pCaseSensitive, pNoOverlap
   local tNewPos, tPos, tResult, tSkip
   
   set the caseSensitive to pCaseSensitive is true
   
   put "せ" after pFind
   put "せ" after pString
   
   put textEncode(pFind, "UTF32") into pFind
   put textEncode(pString, "UTF32") into pString
   
   delete byte -4 to -1 of pFind
   delete byte -4 to -1 of pString
   
   if pNoOverlap then put the len of pFind - 1 into tSkip
   
   put 0 into tPos
   repeat forever
      put Offset(pFind, pString, tPos) into tNewPos
      if tNewPos = 0 then exit repeat
      add tNewPos to tPos
      if tPos mod 4 = 1 then
         put tPos div 4 + 1,"" after tResult
         if pNoOverlap then add tSkip to tPos
      end if
   end repeat
   
   if tResult is empty then return 0
   else return char 1 to -2 of tResult
end allOffsets
