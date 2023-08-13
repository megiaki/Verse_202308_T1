using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/Devices/CreativeAnimation }

objective_marker<public> := struct<concrete>:

    # 動かされる小道具
    @editable
    RootProp<public> : creative_prop = creative_prop{}

    # 一緒に動く小道具の子供。
    @editable
    MapIndicator<public> : map_indicator_device = map_indicator_device{}

# objective_marker の拡張メソッド
# OverTime の前の ? は名前付き引数として指定します
(Marker : objective_marker).MoveMarker<public>(Transform : transform, ?OverTime : float)<suspends> : void =

    if (OverTime > 0.0):
        Marker.RootProp.MoveTo(Transform.Translation, Transform.Rotation, OverTime)
    else:
        if:
            Marker.RootProp.TeleportTo[Transform.Translation, Transform.Rotation]