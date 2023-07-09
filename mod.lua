function data()
return {
	info = {
		minorVersion = 1,
		severityAdd = "NONE",
		severityRemove = "WARNING",
		name = _("mod_name"),
		description = _("mod_desc"),
		authors = {
		    {
		        name = "ModWerkstatt",
		        role = "CREATOR",
		    },
		},
		tags = { "europe", "waggon", "deutschland", "germany", "db", "goods",  },
		minGameVersion = 0,
		dependencies = { },
		url = { "" },

        params = {
			{
				key = "pafake",
				name = _("Fake_pa_wagen"),
				values = { "No", "Yes", },
				tooltip = _("option_pa_fake_desc"),
				defaultIndex = 0,
			},			
			{
				key = "soundCheckpa",
				name = _("sound_check"),
				uiType = "CHECKBOX",
				values = { "No", "Yes", },	
				tooltip = _("option_sound_check"),			
				defaultIndex = 1,	
			},
        },
	},
	options = {
	},
	
	runFn = function (settings, modParams)
	local params = modParams[getCurrentModId()]

        local hidden = {
			["10_fake.mdl"] = true,
			["30_fake.mdl"] = true,
			["mms51_fake.mdl"] = true,
			["mms58_fake.mdl"] = true,
			["ms55_fake.mdl"] = true,
			["s50_fake.mdl"] = true,
			["bkkmms588_fake.mdl"] = true,
			["bs588_fake.mdl"] = true,
			["ms584_fake.mdl"] = true,
			["ms589_Container_1965_fake.mdl"] = true,
			["ms589_Container_1982_fake.mdl"] = true,
			["ms589_DBAG_Container_fake.mdl"] = true,
			["ms589_DBAG_fake.mdl"] = true,
			["ms589_fake.mdl"] = true,
			["s589_fake.mdl"] = true,
        }

		local modelFilter = function(fileName, data)
			local modelName = fileName:match('/BT([^/]*.mdl)')
							or fileName:match('/Laa([^/]*.mdl)')
							or fileName:match('/Lb([^/]*.mdl)')
			return (modelName==nil or hidden[modelName]~=true)
		end

        if modParams[getCurrentModId()] ~= nil then
			local params = modParams[getCurrentModId()]
			if params["pafake"] == 0 then
				addFileFilter("model/vehicle", modelFilter)
			end
		else
			addFileFilter("model/vehicle", modelFilter)
		end
		
		local function metadataHandler(fileName, data)
			if params.soundCheckpa == 0 then
				if fileName:match('/vehicle/waggon/Tragwagen/BT([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Tragwagen/Laa([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Tragwagen/Lb([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Tragwagen/fake/BT([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Tragwagen/fake/Laa([^/]*.mdl)') 
				or fileName:match('/vehicle/waggon/Tragwagen/fake/Lb([^/]*.mdl)') 
				then
					data.metadata.railVehicle.soundSet.name = "waggon_freight_old"
				end
			end
			return data
		end

		addModifier( "loadModel", metadataHandler )
	end
	}
end
