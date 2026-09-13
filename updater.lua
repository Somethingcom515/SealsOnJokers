-- This file was legally copied from Maximus but changed for Seals On Everything and improved

local https = require 'SMODS.https'
local modPath = SEALS.path:gsub('/', '\\')
local id = 'SealsOnEverything'
local subpath = ''
local branch = SEALS.config.updatelocation == 2 and 'main' or 'dev'

local function curl_fetch(url)
	local fp = io.popen(('curl -sL "%s"'):format(url:gsub('"','\\"')), 'r')
	if not fp then return nil, "curl not available" end
	local body = fp:read("*a")
	local ok, _, exit = fp:close()
	if not ok then return nil, ("curl exited with code %s"):format(tostring(exit)) end
	return body
end

local function git_check()
	local git_folder = modPath..'.git'
	local fp = io.popen('git', 'r')
	if not fp:read() then return false end
	fp:close()
	if not NFS.getInfo(git_folder) then return false end
	return true
end

local has_git = git_check()

function check_version()
	local owner, repo = 'Somethingcom515', 'SealsOnJokers'
	local url, url2
	local commit
	if SEALS.config.updatelocation == 1 then
		url = string.format('https://api.github.com/repos/%s/%s/releases/latest', owner, repo)
	else
		url = string.format('https://raw.githubusercontent.com/%s/%s/refs/heads/%s/main.json', owner, repo, branch)
		url2 = string.format('https://api.github.com/repos/%s/%s/branches/%s', owner, repo, branch)
		commit = true
	end
	local latest_version = SEALS.requests.latest_version
	local body, err
	if latest_version then
		body, err = unpack(latest_version)
	else
		body, err = curl_fetch(url)
	end
	if not body then
		print('Fetch failed:', err)
		return
	end
	local latest
	if commit then
		local latest_commit = SEALS.requests.latest_commit
		local body2, err2
		if latest_commit then
			body2, err2 = unpack(latest_commit)
		else
			body2, err2 = curl_fetch(url2)
		end
		if not body2 then
			print('Fetch failed:', err2)
			return
		end
		latest = body:match('"version"%s*:%s*"([^"]+)"')
		commit = body2:match('"sha"%s*:%s*"([^"]+)"'):sub(1, 7)
	else
		latest = body:match('"tag_name"%s*:%s*"([^"]+)"')
	end
	if not latest then
		print("Couldn't parse JSON - tag_name missing")
		return
	end
	return latest, commit
end

local function download_file(url, dest_path)
	local cmd = ('curl -sL -A "ModUpdater" -o "%s" "%s"'):format(dest_path, url)
	local success = os.execute(cmd)
	return success == true or success == 0
end

local function get_subdir(path)
	for entry in io.popen('dir "' .. path .. '" /b /ad'):lines() do
		return entry
	end
end

local function unzip_file(zip_path, zip_subpath, out_dir)
	out_dir = out_dir:gsub("/", "\\")
	zip_path = zip_path:gsub("/", "\\")
	zip_subpath = zip_subpath:gsub("/", "\\")
	local is_windows = package.config:sub(1,1) == '\\'
	local tmp_dir = out_dir .. "_tmp"
	local ok1, ok2, ok3
	if is_windows then
		os.execute(('if exist "%s" rmdir /S /Q "%s"'):format(tmp_dir, tmp_dir))
		os.execute(('if exist "%s" rmdir /S /Q "%s"'):format(out_dir, out_dir))
		ok1 = os.execute(string.format('powershell -NoProfile -Command "Expand-Archive -LiteralPath %q -DestinationPath %q -Force"', zip_path, tmp_dir))
		
		local subfolder = get_subdir(tmp_dir)
		if subfolder then
			local src_path = subpath and tmp_dir .. "\\" .. subfolder .. "\\" .. subpath or tmp_dir .. "\\" .. subfolder
			ok2 = os.execute(string.format('powershell -NoProfile -Command "Move-Item -Path %q -Destination %q -Force"', src_path, out_dir))
		else 
			ok2 = false
		end
		
		ok3 = os.execute(string.format('rmdir /S /Q "%s"', tmp_dir))
	else
		ok1 = os.execute(string.format('unzip -o %q %q\'*\' -d %q', zip_path, zip_subpath, out_dir))
		ok2 = true
		ok3 = true
	end
	local ok4 = os.remove(zip_path)
	return  (ok1 == true or ok1 == 0) and (ok2 == true or ok2 == 0) and (ok3 == true or ok3 == 0) and ok4 == true
end

local function install_update()
	if has_git then
		os.execute(('cd %q && git pull'):format(modPath))
		SMODS.restart_game()
		return
	end
	local owner, repo, tag, commit = 'Somethingcom515', 'SealsOnJokers', check_version()
	local zip_url
	if commit then
		zip_url = string.format("https://github.com/%s/%s/releases/download/%s/SealsOnEverything.zip", owner, repo, tag)
	else
		zip_url = string.format("https://github.com/%s/%s/archive/refs/heads/%s.zip", owner, repo, branch)
	end
	local zip_path = ('Mods\\%s-%s.zip'):format(repo, tag)
	local target_dir = ('%s'):format(modPath)
	local true_subpath = subpath and string.format("%s-%s\\%s", repo, tag, subpath) or string.format("%s-%s", repo, tag)
	
	if not download_file(zip_url, zip_path) then
		print('Failed to download update from '..zip_url)
		return
	end
	
	if not unzip_file(zip_path, true_subpath, target_dir) then
		print('Failed to unzip '..zip_path)
		return
	end
	
	SMODS.restart_game()
end

G.FUNCS.soe_update_accepted = function()
	install_update()
	G.FUNCS.exit_overlay_menu()
end

G.FUNCS.soe_update_denied = function()
	G.FUNCS.exit_overlay_menu()
end

local function show_update_prompt(latest, current, latestcommit, currentcommit)
	local msg = {
		("A new version of %s is available!!!\n"):format(SMODS.Mods[id].display_name),
		("Installed: %s%s\n"):format(current, currentcommit and (' ('..currentcommit..')') or ''),
		("Latest: %s%s\n\n"):format(latest, latestcommit and (' ('..latestcommit..')') or ''),
		"Update now? (This will restart Balatro)"
	}
	
	local lines = {
		n = G.UIT.R,
		config = {
			padding = 0.2,
			align = "tm"
		},
		nodes = {
			{
				n = G.UIT.C,
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = msg[1] .. msg[2] .. msg[3] .. msg[4],
							scale = 0.5
						}
					}
				}
			}
		}
	}
	local button_row = {
		n = G.UIT.R,
		config = {
			padding = 0.2,
			align = "bm"
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					padding = 0.1
				},
				nodes = {
					UIBox_button {
						minw = 7,
						colour = G.C.GREEN,
						label = { "Yes" },
						button = "soe_update_accepted",
					}
				}
			},
			{
				n = G.UIT.C,
				config = {
					padding = 0.1
				},
				nodes = {
					UIBox_button {
						maxw = 0.3,
						colour = G.C.RED,
						label = {'No'},
						button = 'soe_update_denied',
					}
				}
			}
		}
	}
	local confirm_ui = {
		n = G.UIT.ROOT,
		config = {
			align = "cm",
			minw = 4,
			minh = 5,
			padding = 0.3,
			colour = G.C.UI.TEXT_DARK,
			outline = 5,
			outline_colour = G.C.BLACK,
			r = 0.1
		},
		nodes = {
			lines,
			{
				n = G.UIT.R,
				nodes = {
					{
						n = G.UIT.B,
						config = {
							h = 2,
							w = 0
						}
					}
				}
			},
			button_row
		}
	}
	G.FUNCS.overlay_menu {
		definition = confirm_ui,
		config = {
			align = "cm",
			bond = "Weak",
			no_esc = true,
			major = G.ROOM_ATTACH
		}
	}
end

return {
	request_asynchronously = function()
		local owner, repo = 'Somethingcom515', 'SealsOnJokers'
		local url, url2
		local commit
		if SEALS.config.updatelocation == 1 then
			url = string.format('https://api.github.com/repos/%s/%s/releases/latest', owner, repo)
		else
			url = string.format('https://raw.githubusercontent.com/%s/%s/refs/heads/%s/main.json', owner, repo, branch)
			url2 = string.format('https://api.github.com/repos/%s/%s/branches/%s', owner, repo, branch)
			commit = true
		end
		https.asyncRequest(url, function(code, body)
			if code == 200 then
				SEALS.requests.latest_version = {body}
			else
				SEALS.requests.latest_version = {nil, body}
			end
		end)
		if commit then
			https.asyncRequest(url2, function(code, body)
				if code == 200 then
					SEALS.requests.latest_commit = {body}
				else
					SEALS.requests.latest_commit = {nil, body}
				end
			end)
		end
	end,
	update_check = function()
		local git_version, git_commit = check_version()
		if not git_version then return nil, 'There appears to have been a connection error' end
		local current_version = SMODS.Mods[id].version
		local fp = io.popen('cd "'..modPath..'" && git rev-parse HEAD')
		local current_commit = fp:read()
		if current_commit then
			current_commit = current_commit:sub(1, 7)
		else
			current_commit = 'Unknown'
		end
		fp:close()
		if git_version and current_version and V(git_version) > V(current_version) then
			show_update_prompt(git_version, current_version, git_commit, current_commit)
		end
	end
}