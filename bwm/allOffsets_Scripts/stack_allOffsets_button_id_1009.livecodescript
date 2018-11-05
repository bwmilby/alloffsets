Script "stack_allOffsets_button_id_1009"

/*
# Name: button "BWM try2" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1009 of bkgnd id 1013 of stack "allOffsets"
# Behavior: button id 1028 of stack "allOffsets"
*/


function allOffsets pDelim, pString, pCaseSensitive
   local tDelimA, tI, tItem, tItemLen, tLen, tLenA, tN, tPos, tResult
   
   -- returns a comma-delimited list of the offsets of pDelim in pString
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
   
   if tN = 0 then
      return _allOffsets0(pDelim, pString, pCaseSensitive)
   else if tN = 1 then
      return _allOffsets1(pDelim, tDelimA[1], pString, pCaseSensitive)
   end if
   
   set the itemDel to pDelim
   put 1 - tLen into tPos
   repeat for each item tItem in pString
      if tPos > 0 then
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
   
   if tPos > len(pString) then
      if tResult is tPos,"" then
         return 0
      else
         delete item -1 of tResult
      end if
   end if
   
   put len(tItem) into tItemLen
   if tItemLen > 0 then
      subtract tItemLen from tLen
      repeat with tI = tN down to 1
         if tLen > tLenA[tI] then
            if char -len(tDelimA[tI]) to -1 of pString is tDelimA[tI] then
               delete item -1 of tResult
            end if
         end if
      end repeat
   end if
   return char 1 to -2 of tResult
end allOffsets


private function _allOffsets0 pDelim, pString, pCaseSensitive
   local tItem, tLen, tPos, tResult
   
   set the caseSensitive to pCaseSensitive is true
   set the itemDel to pDelim
   put len(pDelim) into tLen
   put 1 - tLen into tPos
   repeat for each item tItem in pString
      add len(tItem) + tLen to tPos
      put tPos,"" after tResult
   end repeat
   set the itemDel to comma
   if tPos > len(pString) then
      if tResult is tPos,""  then
         return 0
      else
         return item 1 to -2 of tResult
      end if
   end if
   return char 1 to -2 of tResult
end _allOffsets0


private function _allOffsets1 pDelim, pDelim1, pString, pCaseSensitive
   local tItem, tLen1, tLen, tPos, tResult
   
   set the caseSensitive to pCaseSensitive is true
   set the itemDel to pDelim
   put len(pDelim) into tLen
   put len(pDelim1) into tLen1
   put 1 - tLen into tPos
   repeat for each item tItem in pString
      if tPos > 0 and tItem&pDelim begins with pDelim1 then
         put tPos+tLen1,"" after tResult
      end if
      add len(tItem) + tLen to tPos
      put tPos,"" after tResult
   end repeat
   set the itemDel to comma
   if tPos > len(pString) then
      if tResult is tPos,""  then
         return 0
      else
         return item 1 to -2 of tResult
      end if
   end if
   return char 1 to -2 of tResult
end _allOffsets1
