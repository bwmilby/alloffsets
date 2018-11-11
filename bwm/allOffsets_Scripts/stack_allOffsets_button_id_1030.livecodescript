Script "stack_allOffsets_button_id_1030"

/*
# Name: button "BWM try4" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1030 of bkgnd id 1013 of stack "allOffsets"
# Behavior: button id 1028 of stack "allOffsets"
*/


function allOffsets pDelim, pString, pCaseSensitive, pNoOverlaps
   local tDelimA, tI, tItem, tItemLen, tLen, tLenList, tN, tPos, tResult
   
   -- returns a comma-delimited list of the offsets of pDelim in pString
   set the caseSensitive to pCaseSensitive is true
   put len(pDelim) into tLen
   put numtochar(chartonum(char -1 of pDelim) mod 2 + 1) after pString
   if tLen > 1 and not pNoOverlaps then
      repeat with tI = 2 to tLen
         if char tI to -1 of pDelim is char 1 to -tI of pDelim then
            put char (1-tI) to -1 of pDelim into tDelimA[tI-1]
            put tI-1 & lf after tLenList
         end if
      end repeat
   end if
   
   put the number of lines in the keys of tDelimA into tN
   switch tN
      case 0
         return _allOffsets0(pDelim, pString, pCaseSensitive)
         break
      case 1
         return _allOffsets1(pDelim, tDelimA[line 1 of tLenList], pString, pCaseSensitive)
         break
   end switch
   
   set the itemDel to pDelim
   put 1 - tLen into tPos
   repeat for each item tItem in pString
      repeat for each line tI in tLenList
         if tItem&pDelim begins with tDelimA[tI] then
            put tPos+tI,"" after tResult
         end if
      end repeat
      add len(tItem) + tLen to tPos
      put tPos,"" after tResult
   end repeat
   
   set the itemDel to comma
   repeat with tI = 1 to tLen
      if item tI of tResult > 0 then exit repeat
   end repeat
   delete item 1 to tI - 1 of tResult
   if tResult begins with tPos then return 0
   return char 1 to -3 - length(tPos) of tResult
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
   if tResult begins with tPos then return 0
   return char 1 to -3 - length(tPos) of tResult
end _allOffsets0


private function _allOffsets1 pDelim, pDelim1, pString, pCaseSensitive
   local tItem, tLen1, tLen, tPos, tResult
   
   set the caseSensitive to pCaseSensitive is true
   set the itemDel to pDelim
   put len(pDelim) into tLen
   put len(pDelim1) into tLen1
   put 1 - tLen into tPos
   repeat for each item tItem in pString
      if tItem&pDelim begins with pDelim1 then
         put tPos+tLen1,"" after tResult
      end if
      add len(tItem) + tLen to tPos
      put tPos,"" after tResult
   end repeat
   set the itemDel to comma
   if item 1 of tResult <= 0 then
      delete item 1 of tResult
   end if
   if tResult begins with tPos then return 0
   return char 1 to -3 - length(tPos) of tResult
end _allOffsets1
