// This SSDT provides support for Chromebook keyboards and
// their keyboard backlight. Make sure the below definition
// is set correctly for your device.

#define PS2_KBD_DEVICE \_SB.PCI0.PS2K
#define BACKLIGHT_DEVICE \_SB.KBLT

#define TO_STR(str) #str

DefinitionBlock ("", "SSDT", 2, "ACDT", "Chromebook", 0)
{
    External (PS2_KBD_DEVICE, DeviceObj)
    External (BACKLIGHT_DEVICE, DeviceObj)
    
    Scope (BACKLIGHT_DEVICE)
    {
        Method (KBQL, 0, NotSerialized) {
            Return(Package(11)
            {
                Zero,
                0x0A,
                0x14,
                0x1E,
                0x28,
                0x32,
                0x3C,
                0x46,
                0x50,
                0x5A
                0x64
            })
        }
    }
    
    Name(PS2_KBD_DEVICE.RMCF, Package()
    {
        "Keyboard", Package()
        {
            "Keyboard Backlight ACPI Path", TO_STR(BACKLIGHT_DEVICE),
            "Query All Keyboard Backlight Levels", "KBQL",
            "Get Keyboard Backlight Level", "KBQC",
            "Set Keyboard Backlight Level", "KBCM",
            
            "Custom ADB Map", Package()
            {
                Package(){},
                "3b=e010",  // F1 to Previous Track
                "3c=e019",  // F2 to Next Track
                "3d=e022",  // F3 to PlayPause
                // F4 to Full Screen - Map this in Sys Prefs - Keyboard - Shortcuts - App Shortcuts
                // F5 to Mission Control - Map this is Sys Prefs - Keyboard - Shortcuts
                "40=e005"   // F6 to Display Brightness Down
                "41=e006"   // F7 to Display Brightness Up
                "42=e020"   // F8 to Mute
                "43=e02e"   // F9 to VolDown
                "44=e030"   // F10 to VolUp
            },
        },
    })
}
//EOF
