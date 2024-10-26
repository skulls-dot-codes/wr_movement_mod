--!strict

local partitions = require("./partitions")

local Soldier = {}
Soldier.__index = Soldier
local SoldierInstance = Soldier

function SoldierInstance:on_load(instance: SoldierBlueprint)
	local soldier = instance.object :: SoldierEntityData
    local physics = soldier.characterPhysics :: CharacterPhysicsData
    local air = physics.states[3] :: InAirStateData
    local animation = physics.states[8] :: AnimationControlledStateData
    local slide = physics.states[9] :: SlidingStateData

    local air_stand = air.poseInfo[1] :: CharacterStatePoseInfo
    local air_crouch = air.poseInfo[2] :: CharacterStatePoseInfo
    local air_prone = air.poseInfo[3] :: CharacterStatePoseInfo

    air_stand.velocity = 4
    air_stand.sprintMultiplier = 1.0

    air_crouch.velocity = 1
    air_crouch.sprintMultiplier = 0.0

    air_prone.velocity = 0
    air_prone.speedModifier.forwardConstant = 0.0
    air_prone.sprintMultiplier = 0.0

    local animation_stand = animation.poseInfo[1] :: CharacterStatePoseInfo
    local animation_crouch = animation.poseInfo[2] :: CharacterStatePoseInfo
    local animation_prone = animation.poseInfo[3] :: CharacterStatePoseInfo

    animation_stand.velocity = 4 -- default
    animation_stand.sprintMultiplier = 1.0 -- default

    animation_crouch.velocity = 1
    animation_crouch.sprintMultiplier = 0.0

    animation_prone.velocity = 0.0
    animation_prone.speedModifier.forwardConstant = 0.0
    animation_prone.sprintMultiplier = 0.0 -- default


    local slide_stand = slide.poseInfo[1] :: CharacterStatePoseInfo
    local slide_crouch = slide.poseInfo[2] :: CharacterStatePoseInfo
    local slide_prone = slide.poseInfo[3] :: CharacterStatePoseInfo

    slide_stand.velocity = 2 -- default
    slide_stand.speedModifier.forwardConstant = 1.0 -- default

    slide_crouch.velocity = 1
    slide_crouch.speedModifier.forwardConstant = 0.0

    slide_prone.velocity = 0
    slide_prone.speedModifier.forwardConstant = 0.0

    physics.jumpPenaltyFactor = 1.5 -- default
    physics.jumpPenaltyFactor = 0.33 -- default

    physics.allowPoseChangeDuringTransition = false
    physics.autoPushAwayFromWallsInProne = false
end

partitions.onAllInstancesLoaded(SoldierInstance, SoldierInstance.on_load, {
	partition = Guid("9697F666-AFF6-4035-AC81-148AC0E840F3"),
	instance = Guid("B70DB8C3-C043-41E4-971D-C997970D35A5")
})

return nil