Script "stack_allOffsets_button_id_1015"

/*
# Name: button "allOffsets2" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1015 of bkgnd id 1013 of stack "allOffsets"
*/


on mouseUp
   local tStart
   
   put the milliseconds into tStart
   repeat with i = 1 to 1000
      get allOffsets2(field "needle", field "haystack")
   end repeat
   put the milliseconds - tStart & "ms /" && the number of items of it & ": " after field "results"
   put allOffsets2(field "needle", field "haystack") after field "results"
   put cr after field "results"
end mouseUp


function allOffsets2 pDelim, pString, pCaseSensitive
   local tDelimA, tI, tItem, tLen, tLenA, tN, tPos, tRemove, tResult
   
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
      put len(tItem) into tLen
      if tLen > 1 then
         put char -len(tDelimA[tN]) to -1 of pString into pString
         repeat with tI = tN down to tLen+1
            if pString is tDelimA[tI] then
               add 1 to tRemove
            end if
            delete char 1 of pString
         end repeat
      end if
   end if
   if tRemove > 0 then return item 1 to -(tRemove+1) of tResult
   return char 1 to -2 of tResult
end allOffsets2
