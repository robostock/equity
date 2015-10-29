dofile("logger.lua")
dofile("table.save-1.0.lua")
 
local path = ""
local stopped = false
local recomdates = {}
local qtable
local waitcloselongopenshort = false
local waitcloseshortopenlong = false

function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = tonumber(str)
                i = i + 1
        end
        return t
end

function OnParam( class, sec  )

end

function OnStop( flag )
end

function main() 
	myLogOpen()

	path = getWorkingFolder()
	myLog("WorkingFolder: "..path)

	local cur_time 	
	while not stopped do
		cur_time = os.date('*t')
			
		if( (cur_time.hour==18) and (cur_time.min==45) ) then
			myLog("hour:"..cur_time.hour.." min: "..cur_time.min)

			local itemcount = getNumberOf("FUTURES_CLIENT_LIMITS")
					
			for i = 0,itemcount-1 do
				local limit = getItem("FUTURES_CLIENT_LIMITS",i)
				
				--myLog("firmid: "..limit.firmid.." trdaccid:"..limit.trdaccid.." limittype: "..limit.limit_type.." cbp_prev_limit:"..limit.cbp_prev_limit.." cbplplanned:"..limit.cbplplanned)
				myLog("firmid;trdaccid;limittype;cbp_prev_limit;cbplplanned")
				myLog(limit.firmid..";"..limit.trdaccid..";"..limit.limit_type..";"..limit.cbp_prev_limit..";"..limit.cbplplanned)
			end
			
			itemcount = getNumberOf("money_limits")
			
			for i = 0,itemcount-1 do
				local limit = getItem("money_limits",i)
				
				if(limit.limit_kind==2) then
					--myLog("firmid: "..limit.firmid.." client_code:"..limit.client_code.." limit_kind: "..limit.limit_kind.." openbal:"..limit.openbal.." openlimit:"..limit.openlimit.." currentbal:"..limit.currentbal.." currentlimit:"..limit.currentlimit)
					local portfolio = getPortfolioInfoEx(limit.firmid,limit.client_code,2)
					if portfolio~=nil then
						myLog("firmid;client_code;limit_kind;in_assets;portfolio.assets")
						--myLog("in_assets: "..portfolio.in_assets.." assets:"..portfolio.assets)
						myLog(limit.firmid..";"..limit.client_code..";"..limit.limit_kind..";"..portfolio.in_assets..";"..portfolio.assets)
					end
				end
			end
		end
		
		sleep(60000)
	end
end