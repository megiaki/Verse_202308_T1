using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
zip_move2 := class(creative_device):

    @editable
    crash_BP : creative_prop = creative_prop{}


    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        spawn:
            Rotation_zip()

    Rotation_zip()<suspends>:void=
            var YawAngle : float = 0.0
            var PitchAngle : float = 0.0
            var RollAngle : float = 0.0
            
            ## 現在位置の取得
            CurrentLocation := crash_BP.GetTransform().Translation
            var Position : vector3 = CurrentLocation + vector3{X:=0.0, Y:=0.0, Z:= 900.0}

            loop:

                targetRotation := MakeRotationFromYawPitchRollDegrees(YawAngle, PitchAngle, RollAngle)
                # 初期位置変更
                # crash_BP.MoveTo(vector3{X:=2208.0, Y:=-1434.9, Z:=900.00}, targetRotation, 1.0)
                # 初期位置固定
                # crash_BP.MoveTo(Position, targetRotation, 1.0)
                crash_BP.MoveTo(Position, targetRotation, 1.0)

                set YawAngle = YawAngle + 20.0
                set PitchAngle = PitchAngle + 20.0
                set RollAngle = RollAngle + 20.0