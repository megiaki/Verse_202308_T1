using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }
using { /Fortnite.com/Playspaces }
using { /UnrealEngine.com/Temporary/SpatialMath }

objective_coordinator_device<public> := class<concrete>(creative_device):

    var PlayerOpt<private> : ?player = false

    @editable
    PickupMarker<public> : objective_marker = objective_marker{}

    # マーカーが移動する場所
    @editable
    Destination<public> : transform = transform{}

    # マーカーが新しい場所に到達するまでにかかる時間
    @editable
    MoveTime<public> : float = 0.0

    OnBegin<override>()<suspends> : void =

        FindPlayer()

        PickupMarker.MoveMarker(Destination, ?OverTime := MoveTime)

        # プレイヤーが false に設定されている場合、見つかったプレイヤーの objective pulse をアクティブにします
        if (FoundPlayer := PlayerOpt?):
           PickupMarker.MapIndicator.ActivateObjectivePulse(FoundPlayer)

    FindPlayer<private>() : void =

        # これは単一のプレイヤー体験なので、最初のプレイヤー [0] のみが
        # 使用可能となる必要があります。

        AllPlayers := Self.GetPlayspace().GetPlayers()

        if (FirstPlayer := AllPlayers[0]):
            set PlayerOpt = option{FirstPlayer}
            Print("Player found")
        else:
            # プレイヤーが見つからない場合、エラーをログに記録します。
            Print("Can't find valid player")