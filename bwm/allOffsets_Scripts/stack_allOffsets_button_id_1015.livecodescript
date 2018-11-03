Script "stack_allOffsets_button_id_1015"

/*
# Name: button "allOffsets2" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1015 of bkgnd id 1013 of stack "allOffsets"
*/


on mouseUp
   put allOffsets2(field "needle", field "haystack") after field "results"
   put cr after field "results"
end mouseUp


function allOffsets2 pDelim, pString, pCaseSensitive
   local tDelimA, tI, tItem, tLen, tLenA, tN, tPos, tResult
   
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
   delete char -1 of tResult
   
   if item -1 of tResult > len(pString) then
      if the number of items of tResult is 1 then
         return 0
      else
         delete item -1 of tResult
      end if
   end if
   
   if len(tItem) > 0 then
      repeat with tI = tN down to len(tItem)+1
         if char -len(tDelimA[tI]) to -1 of pString is tDelimA[tI] then
            delete item -1 of tResult
         end if
      end repeat
   end if
   return tResult
end allOffsets2
