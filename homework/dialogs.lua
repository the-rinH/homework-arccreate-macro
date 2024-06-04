local Dialogs = {}

function Dialogs.displayWallOfText(title, message)
    local msgField = DialogField.create("_")
        .description(message)
    local dialogInput = DialogInput.withTitle(title)
        .requestInput(
            {
                msgField,
            }
        )
    coroutine.yield()
end

function Dialogs.displayMultipage(docs, title, label, hint)
    local labels = {}
    for _, doc in ipairs(docs) do
        table.insert(labels, doc["title"])
    end
    local root = DialogField.create("root")
        .setLabel(label)
        .setHint(hint)
        .dropdownMenu(table.unpack(labels))
        .defaultTo(labels[1])
    local desc = DialogField.create("_")
        .description("Close this window to exit once you're done.")
    -- As long as close window is not pressed, continue to display docs
    while true do
        local rootInput = DialogInput.withTitle(title)
            .requestInput(
                {
                    root,
                    desc
                }
            )
        coroutine.yield()
        local res = rootInput.result["root"]
        for _, doc in ipairs(docs) do
            if doc["title"] == res then
                Dialogs.displayWallOfText(
                    doc["title"],
                    doc["text"]
                )
                break
            end
        end
    end
end

return Dialogs
