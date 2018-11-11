Script "stack_allOffsets_button_id_1032"

/*
# Name: button "Offset UTF16" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1032 of bkgnd id 1013 of stack "allOffsets"
# Behavior: button id 1028 of stack "allOffsets"
*/


function allOffsets pDelim, pString, pCaseSensitive, pNoOverlap
   local tNewPos, tPos, tResult, tlen
   
   put textEncode(pDelim, "UTF16") into pDelim
   put textEncode(pString, "UTF16") into pString
   set the caseSensitive to pCaseSensitive is true
   
   put 0 into tPos
   if pNoOverlap then
      put the len of pDelim - 2 into tLen
      repeat forever
         put offset(pDelim, pString, tPos) into tNewPos
         if tNewPos = 0 then exit repeat
         add tNewPos to tPos
         put tPos div 2 + 1,"" after tResult
         add tLen to tPos
      end repeat
   else
      repeat forever
         put offset(pDelim, pString, tPos) into tNewPos
         if tNewPos = 0 then exit repeat
         add tNewPos to tPos
         put tPos div 2 + 1,"" after tResult
      end repeat
   end if
   
   if tResult is empty then return 0
   else return char 1 to -2 of tResult
end allOffsets
