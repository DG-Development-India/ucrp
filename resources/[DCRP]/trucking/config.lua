Config = {
    JobCenter = vector3(961.84, -2189.50, 29.74),
    ReAdd = 60, -- seconds after a job is finished until its shown again
    Job = {
        ['jobRequired'] = false, -- if true: only players with the specified job can work, false everyone can work
        ['jobName'] = 'trucker',
    },
    Jobs = {
        -- {title = 'title', payment = reward, vehicles = {'truck', 'trailer'}, start = {vector3(x, y, z), heading}, trailer = {vector3(x, y, z), heading}, arrive = vector3(x, y, z)}
        {title = 'Youtool', payment = math.random(300,500), vehicles = {'phantom', 'trailers'}, start = {vector3(954.77, -2188.86, 29.63), 84.99}, trailer = {vector3(939.0, -1799.2, 30.1), 175.78}, arrive = vector3(2671.0, 3530.35, 51.26)},
        {title = 'Ammunation', payment = math.random(300,600), vehicles = {'phantom', 'trailers'}, start = {vector3(950.15, -2109.86, 30.55), 84.26}, trailer = {vector3(851.69, -2128.85, 30.1), 83.58}, arrive = vector3(-323.91, 6099.74, 31.26)},
		--{title = 'Vapid', payment = math.random(300,500), vehicles = {'phantom', 'trailers'}, start = {vector3(841.51, -2341.86, 30.55), 172.47}, trailer = {vector3(881.45, -2404.16, 28.1), 169.34}, arrive = vector3(2134.74, 4781.10, 40.26)},
	    --{title = 'Bell Farms', payment = math.random(300,600), vehicles = {'packer', 'trailers2'}, start = {vector3(868.77, -2341.7, 29.44), 174.68}, trailer = {vector3(946.29, -2111.86, 29.64), 86.76}, arrive = vector3(-74.40, 6270.54, 31.56)}
    },
}

Strings = {
    ['not_job'] = "You don't have the trucker job!",
    ['somebody_doing'] = 'Somebody is already doing this job, please select another one!',
    ['menu_title'] = 'Trucker - choose job',
    ['e_browse_jobs'] = 'Press ~INPUT_CONTEXT~ to browse available jobs',
    ['start_job'] = 'Trucker - start job',
    ['truck'] = 'Truck',
    ['trailer'] = 'Trailer',
    ['get_to_truck'] = 'Get to the ~y~truck~w~!',
    ['get_to_trailer'] = 'Drive to the ~y~trailer~w~ and attach it!',
    ['destination'] = 'Destination',
    ['get_out'] = 'Get out of your ~y~truck~w~!',
    ['park'] = 'Park the ~y~trailer~w~ at the destination.',
    ['park_truck'] = 'Park the ~y~truck~w~ at the destination.',
    ['drive_destination'] = 'Drive to the ~b~destination~w~.',
    ['reward'] = 'Well done! You recieved $%s',
    ['paid_damages'] = 'Drive better next time! You paid ~r~$~w~%s for the damages caused!',
    ['drive_back'] = 'Drive the ~y~truck ~w~back to where you got it.', 
    ['detach'] = 'Detach the trailer.'
}