local Dialogs = require "homework.dialogs"
local Macro = {}
function Macro.createfileStructure(components, pid)
    local docs = {}
    for _, component in ipairs(components) do
        if component["type"] == "folder" then
            local next_pid = component["id"]
            if pid ~= nil then
                next_pid = pid..component["id"]
            end
            if component["icon"] == nil or component["icon"] == "" then
                component["icon"] = "e2c8"
            end
            addFolderWithIcon(
                pid,
                next_pid,
                component["icon"],
                component["label"].."..."
            )
            Macro.createfileStructure(component["contents"], next_pid)

        elseif component["type"] == "macro" then
            if component["icon"] == nil or component["icon"] == "" then
                component["icon"] = ""
            end
            addMacroWithIcon(
                pid,
                pid..component["id"],
                component["label"],
                component["icon"],
                component["def"]
            )
            if component["documentation"] ~= nil then
                table.insert(
                    docs,
                    {
                        ["title"] = component["label"],
                        ["text"] = component["documentation"]
                    }
                )
            end
        end
    end
    --- Displays documentation if present
    if #docs > 0 then
        addMacroWithIcon(
            pid,
            pid.."$docs",
            "Documentation",
            "e2c8",
            function()
                Dialogs.displayMultipage(docs, "Documentations", "Macro", "Which documentation?")
            end
        )
    end
end

return Macro
