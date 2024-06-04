# ArcCreate Homework Macro Template
ArcCreate Macros organization in a modular and centralized approach.

## Motivation
organizing macros and their built in documentation is difficult (like everything)

## Approach to problem.
Imagine a central config file for all your macros. 
Instead of calling ``AddFolderWithIcon()`` and ``AddMacroWithIcon()`` over and over again. I made use of tables in Lua. Below is how the macro is initiated.
```lua 
Macro.createFileStructure(
    {   --- This is the root directory of the macro file structure,
        --- You can create a folder here as a single macro pack.
        --- Or you can just add a macro here as a single macro but I wont recommend.
        --- Below is an example called "My Macros".
        {
            ["type"]    = "folder",     -- The type of item, can either be "folder" or "macro"
            ["id"]      = "folder_id",  -- The ID of the folder, must be unique
            ["icon"]    = "e2c8",       -- Icon of the folder
            ["label"]   = "My Macros",  -- The label of the macro/folder, this will appear in ArcCreate.
            ["contents"]= {             -- The content of the folder, can contain other folder or macro.
                {
                    ["type"]    = "folder",     -- Another folder in the folder
                    ...                         -- fill up with the properties like above
                    ["contents"]= {             -- Unlike the previous folder, this one contains a macro
                        {   --- Sample Macro
                            ["type"]    = "macro",          -- This is a macro, so put in "macro" as the type.
                            ["id"]      = "macro_id",       -- Like Folder ID, this has to be unique within the scope of the folder. The full ID depends on its parents.
                            ["label"]   = "MakeShartGood",  -- Label of the Macro
                            ["icon"]    = "e934",           -- Icon of the Macro
                            ["def"]     = function()        -- Here you state what the macro does. Where the code goes into.
                                -- do stuff
                                end,
                            ["documentation"]   = [[
                            Make Shart Good (MSG)
                            funny macro make use of dark magic :)
                            ]]
                            -- Documentations for the Macro can be put here. Homework will put all the documentations for all macros
                            -- in a special Documentations macro in the parent folder.
                        },
                        ...     -- Feel free to add more macro or folder in the folder.
                    }
                },
                {
                    ["type"]    = "folder",     -- yet another folder
                    ...
                }
            }

        }
    },
    nil     -- you have to add this due to how the code functions :skull:
)
```

## Advantages over spamming ``AddMacroWithIcon()`` or ``AddFolderWithIcon()``, etc.
everything here is opinionated.
One of the biggest advantage of this is that you dont have to repeat inputting the id of the folder over and over again when you want to add a macro. Which means you dont have to type in the id of the folder over and over again - less chances of typo. Furthermore, this leads to better readability of the folder tree. And many more!

## Am I using this?

Yes, for the semi-private MSGK-CP (Mesugaki Correction Pack) Macro pack which is still under development. [:sob: please it's just a name...]

## Any tips on using this?
Of course, make use of ``require()`` and ``return``s on a file level so that the macro info will be in a separate file. (you can put the macro functionality there as well so that your config file won't be a monolith!).
