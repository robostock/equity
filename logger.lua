f=nil
filename="my.log"
 
function myLog(str)
	--if f==nil then
	   f = io.open(filename, "a+")
	--end

	if f~= nil then
		f:write(os.date() .. " ".. str .. "\n")
		f:close()
	end
end

function myLogOpen()
	f = io.open(filename, "w+t")
	f = io.close()
end

function myLogOpenAppend()
	f = io.open(filename, "a")
	f = io.close()
end

function myLogClose()
    --if f~= nil then
	--	f:close()
	--end
end
