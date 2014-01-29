class "CarChat"

function CarChat:__init ( )
	self.command = "cc"
	self.color = Color ( 255, 255, 0 )

	Events:Subscribe ( "PlayerChat", self, self.onChat )
end

function CarChat:onChat ( args )
    local msg = args.text
    if ( msg:sub ( 1, 1 ) ~= "/" ) then
        return true
    end

    local msg = msg:sub ( 2 )
    local cmd_args = msg:split ( " " )
    local cmd_name = cmd_args [ 1 ]:lower ( )
	if ( cmd_name == self.command ) then
		table.remove ( cmd_args, 1 )
		local pName = args.player:GetName ( )
		local vehicle = args.player:GetVehicle ( )
		if IsValid ( vehicle ) then
			for _, player in ipairs ( vehicle:GetOccupants ( ) ) do
				player:SendChatMessage ( "(CarChat) ".. tostring ( pName ) ..": ".. tostring ( table.concat ( cmd_args, " " ) ), self.color )
			end
		end
	end
end

carChat = CarChat ( )