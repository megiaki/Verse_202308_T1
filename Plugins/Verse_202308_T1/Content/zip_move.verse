using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
zip_move := class(creative_device):

    @editable
    crash_BP : creative_prop = creative_prop{}


    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        spawn:
            Rotation_zip()

    Rotation_zip()<suspends>:void=
            var YawAngle : float = 0.0
            var PitchAngle : float = 0.0
            loop:

                targetRotation := MakeRotationFromYawPitchRollDegrees(YawAngle, PitchAngle, 0.0)
                crash_BP.MoveTo(vector3{X:=156.5, Y:=137.0, Z:=901.0}, targetRotation, 1.0)
                set YawAngle = YawAngle + 30.0
                set PitchAngle = PitchAngle + 10.0