dg.Admin:AddRank("owner", {
    inherits = "dev",
    issuperadmin = true,
    allowafk = true,
    grant = 101
})

dg.Admin:AddRank("dev", {
    inherits = "superadmin",
    issuperadmin = true,
    allowafk = true,
    grant = 100
})

dg.Admin:AddRank("superadmin", {
    inherits = "admin",
    issuperadmin = true,
    allowafk = true,
    grant = 101
})

dg.Admin:AddRank("admin", {
    inherits = "moderator",
    allowafk = true,
    isadmin = true,
    grant = 98
})

dg.Admin:AddRank("moderator", {
    inherits = "trusted",
    isadmin = true,
    grant = 97
})

dg.Admin:AddRank("trusted", {
    inherits = "user",
    isadmin = true,
    grant = 96
})

dg.Admin:AddRank("user", {
    inherits = "",
    grant = 1
})