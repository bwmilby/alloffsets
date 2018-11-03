Script "stack_allOffsets_button_id_1003"

/*
# Name: button "allOffsets" of bkgnd id 1013 of stack "allOffsets"
# ID: button id 1003 of bkgnd id 1013 of stack "allOffsets"
*/


on mouseUp
   local tStart, tError
   
   put empty into field "results"
   put the milliseconds into tStart
   repeat with i = 1 to 1000
      get allOffsets(field "needle", field "haystack")
   end repeat
   put the milliseconds - tStart & "ms /" && the number of items of it & ": " after field "results"
   put the last item of it > len(field "haystack") into tError
   put allOffsets(field "needle", field "haystack") after field "results"
   if tError then put " [Wrong]" after field "results"
   put cr after field "results"
end mouseUp


function allOffsets D,S,pCase
   local dLength, C, R, lenC, lenR
   -- returns a comma-delimited list of the offsets of D in S
   set the caseSensitive to pCase is true
   set the itemDel to D
   put length(D) into dLength
   put 1 - dLength into C
   repeat for each item i in S
      add length(i) + dLength to C
      put C,"" after R
   end repeat
   set the itemDel to comma
   if char -dLength to -1 of S is D then return char 1 to -2 of R 
   put length(C) + 1 into lenC
   put length(R) into lenR
   if lenC = lenR then return 0
   return char 1 to lenR - lenC - 1 of R
end allOffsets


function allOffsets2 D,S,pCase
   local dLength, C, R
   -- returns a comma-delimited list of the offsets of D in S
   set the caseSensitive to pCase is true
   set the itemDel to D
   put length(D) into dLength
   put 1 - dLength into C
   
   if dLength > 1 then
      local n, i, j, D2, L2
      put 0 into n
      repeat with i = 2 to dLength 
         if char i to -1 of D is char 1 to -i of D then
            add 1 to n
            put char (1-i) to -1 of D into D2[n]
            put i-1 into L2[n]
         end if
      end repeat
   end if
   
   repeat for each item i in S
      if C > 0 and n > 0 then
         repeat with j = 1 to n
            if i&D begins with D2[j] then
               put C+L2[j],"" after R
            end if
         end repeat
      end if
      add length(i) + dLength to C
      put C,"" after R
   end repeat
   set the itemDel to comma
   delete char -1 of R
   
   if item -1 of R > len(S) then
      if the number of items of R is 1 then
         return 0
      else
         delete item -1 of R
      end if
   end if
   
   if len(i) > 0 then
      repeat with j = n down to len(i)+1
         if char -len(D2[j]) to -1 of S is D2[j] then
            delete item -1 of R
         end if
      end repeat
   end if
   return R
end allOffsets2

