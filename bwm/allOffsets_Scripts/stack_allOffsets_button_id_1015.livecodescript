Script "stack_allOffsets_button_id_1015"

/*
# Name: button "BWM try1" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1015 of bkgnd id 1013 of stack "allOffsets"
# Behavior: button id 1028 of stack "allOffsets"
*/


function allOffsets pDelim, pString, pCaseSensitive
   local tDelimA, tI, tItem, tItemLen, tLen, tLenA, tN, tPos, tRemove
   local tResult
   
   set the caseSensitive to pCaseSensitive is true
   put len(pDelim) into tLen
   put 0 into tN
   if tLen > 1 then
      repeat with tI = 2 to tLen
         if char tI to -1 of pDelim is char 1 to -tI of pDelim then
            add 1 to tN
            put char (1-tI) to -1 of pDelim into tDelimA[tN]
            put len(tDelimA[tN]) into tLenA[tN]
         end if
      end repeat
   end if
   
   set the itemDel to pDelim
   put 1 - tLen into tPos
   repeat for each item tItem in pString
      if tPos > 0 and tN > 0 then
         repeat with tI = 1 to tN
            if tItem&pDelim begins with tDelimA[tI] then
               put tPos+tLenA[tI],"" after tResult
            end if
         end repeat
      end if
      add len(tItem) + tLen to tPos
      put tPos,"" after tResult
   end repeat
   set the itemDel to comma
   
   put 0 into tRemove
   if tPos > len(pString) then
      if tResult is tPos,"" then
         return 0
      else
         add 1 to tRemove
      end if
   end if
   
   if tN > 0 then
      put len(tItem) into tItemLen
      if tItemLen > 0 then
         subtract tItemLen from tLen
         repeat with tI = tN down to 1
            if tLen > tLenA[tI] then
               put char -len(tDelimA[tI]) to -1 of pString into pString
               if pString is tDelimA[tI] then
                  add 1 to tRemove
               end if
            end if
         end repeat
      end if
   end if
   if tRemove > 0 then return item 1 to -(tRemove+1) of tResult
   return char 1 to -2 of tResult
end allOffsets
