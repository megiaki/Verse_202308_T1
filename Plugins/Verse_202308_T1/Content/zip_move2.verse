using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
zip_move2 := class(creative_device):

    @editable
    RotateValue: rotation = rotation{}

    @editable
    RotateCenter: creative_prop = creative_prop{}

    @editable
    RotateObject: creative_prop = creative_prop{}

    OnBegin<override>()<suspends>:void=
        Orbit()

    Orbit()<suspends>:void=
        Vector := GetOrbitVector(RotateCenter.GetTransform().Translation, RotateObject.GetTransform().Translation, RotateValue)
        Task := spawn{RotateObject.MoveTo(Vector, RotateObject.GetTransform().Rotation, 2.0)}
        Task.Await()
        Orbit()

    GetOrbitVector(CenterVec: vector3, OrbitVec: vector3, Rotate: rotation):vector3=
        NowRotation := GetFacingRotation(CenterVec, OrbitVec)
        NewRotation := NowRotation.RotateBy(Rotate)
        Position := CenterVec + NewRotation.GetLocalForward() * Distance(CenterVec, OrbitVec)
        return Position


    GetFacingRotation(FacingLocation: vector3, FacedLocation: vector3):rotation=
        var ReturnRotation: rotation = rotation{}
        if (LookDirection := (FacedLocation - FacingLocation).MakeUnitVector[]):
            Yaw := RadiansToDegrees(ArcTan(LookDirection.Y, LookDirection.X))
            Pitch := RadiansToDegrees(ArcTan(LookDirection.Z, Sqrt((LookDirection.X * LookDirection.X) + (LookDirection.Y * LookDirection.Y))))
            Roll := 0.0
            set ReturnRotation = MakeRotationFromYawPitchRollDegrees(Yaw, Pitch, Roll)
        return ReturnRotation