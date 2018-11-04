Script "stack_allOffsets_button_id_1026"

/*
# Name: button "bwmAllOffsets @" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1026 of bkgnd id 1013 of stack "allOffsets"
*/


on mouseUp
   local tStart
   
   put the milliseconds into tStart
   repeat with i = 1 to 1000
      get bwmAllOffsets(field "needle", field "haystack")
   end repeat
   put the milliseconds - tStart & "ms /" && the number of items of it & ": " after field "results"
   put bwmAllOffsets(field "needle", field "haystack") after field "results"
   put cr after field "results"
end mouseUp


function bwmAllOffsets pDelim, pString, pCaseSensitive
   local tDelimA, tI, tItem, tItemLen, tLen, tLenList, tN, tPos, tResult
   
   -- returns a comma-delimited list of the offsets of pDelim in pString
   set the caseSensitive to pCaseSensitive is true
   put len(pDelim) into tLen
   put numtochar(chartonum(char -1 of pDelim) mod 2 + 1) after pString
   if tLen > 1 then
      repeat with tI = 2 to tLen
         if char tI to -1 of pDelim is char 1 to -tI of pDelim then
            put char (1-tI) to -1 of pDelim into tDelimA[tI-1]
            put tI-1 & lf after tLenList
         end if
      end repeat
   end if
   
   if tLenList is empty then
      return _allOffsets0(pDelim, pString, pCaseSensitive)
   else if the number of lines in the keys of tDelimA is 1 then
      return _allOffsets1(pDelim, tDelimA[line 1 of tLenList], pString, pCaseSensitive)
   end if
   
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
   
   repeat until item 1 of tResult > 0
      delete item 1 of tResult
   end repeat
   delete item -1 of tResult
   if tResult is empty then
      return 0
   else
      return char 1 to -2 of tResult
   end if
end bwmAllOffsets


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
   delete item -1 of tResult
   if tResult is empty then
      return 0
   else
      return char 1 to -2 of tResult
   end if
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
   delete item -1 of tResult
   if tResult is empty then
      return 0
   else
      return char 1 to -2 of tResult
   end if
end _allOffsets1
