--!strict

local partitions = require("./partitions")

local Soldier = {}
Soldier.__index = Soldier
local SoldierInstance = Soldier

function SoldierInstance:on_load(instance: SoldierBlueprint)
	local soldier = instance.object :: SoldierEntityData
    local physics = soldier.characterPhysics :: CharacterPhysicsData

    soldier.collisionInfo.damageAtVerticalVelocity[3].value = 0.0
    soldier.collisionInfo.damageAtVerticalVelocity[4].value = 0.0
    soldier.collisionInfo.damageAtVerticalVelocity[5].value = 0.0

    soldier.collisionInfo.damageAtHorizVelocity[3].value = 0.0
    soldier.collisionInfo.damageAtHorizVelocity[4].value = 0.0
    soldier.collisionInfo.damageAtHorizVelocity[5].value = 0.0

    local ground = physics.states[1] :: OnGroundStateData
    local jump = physics.states[2] :: JumpStateData
    local air = physics.states[3] :: InAirStateData
    local animation = physics.states[8] :: AnimationControlledStateData
    local slide = physics.states[9] :: SlidingStateData

    ground.groundHugging = false
    ground.limitDownwardVelocity = true

    jump.jumpHeight = 50

    local air_stand = air.poseInfo[1] :: CharacterStatePoseInfo
    local air_crouch = air.poseInfo[2] :: CharacterStatePoseInfo
    local air_prone = air.poseInfo[3] :: CharacterStatePoseInfo

    air_stand.velocity = 50
    air_stand.sprintMultiplier = 2.0

    air_crouch.velocity = 1
    air_crouch.sprintMultiplier = 0.0

    air_prone.velocity = 0
    air_prone.speedModifier.forwardConstant = 0.0
    air_prone.speedModifier.backwardConstant = 0.0
    air_prone.speedModifier.leftConstant = 0.0
    air_prone.speedModifier.rightConstant = 0.0
    air_prone.sprintMultiplier = 0.0

    local animation_stand = animation.poseInfo[1] :: CharacterStatePoseInfo
    local animation_crouch = animation.poseInfo[2] :: CharacterStatePoseInfo
    local animation_prone = animation.poseInfo[3] :: CharacterStatePoseInfo

    animation_stand.velocity = 1 -- default
    animation_stand.sprintMultiplier = 1.0 -- default

    animation_crouch.velocity = 0
    animation_crouch.sprintMultiplier = 0.0

    animation_prone.velocity = 0.0
    animation_prone.speedModifier.forwardConstant = 0.0
    animation_prone.speedModifier.backwardConstant = 0.0
    animation_prone.speedModifier.leftConstant = 0.0
    animation_prone.speedModifier.rightConstant = 0.0
    animation_prone.sprintMultiplier = 0.0

    local slide_stand = slide.poseInfo[1] :: CharacterStatePoseInfo
    local slide_crouch = slide.poseInfo[2] :: CharacterStatePoseInfo
    local slide_prone = slide.poseInfo[3] :: CharacterStatePoseInfo

    slide_stand.velocity = 4 -- default
    slide_stand.speedModifier.forwardConstant = 1.0 -- default

    slide_crouch.velocity = 1
    slide_crouch.speedModifier.forwardConstant = 0.0
    slide_crouch.speedModifier.backwardConstant = 0.0
    slide_crouch.speedModifier.leftConstant = 0.0
    slide_crouch.speedModifier.rightConstant = 0.0

    slide_prone.velocity = 0
    slide_prone.speedModifier.forwardConstant = 0.0
    slide_prone.speedModifier.backwardConstant = 0.0
    slide_prone.speedModifier.leftConstant = 0.0
    slide_prone.speedModifier.rightConstant = 0.0

    physics.allowPoseChangeDuringTransition = false
    physics.autoPushAwayFromWallsInProne = false
end

partitions.onAllInstancesLoaded(SoldierInstance, SoldierInstance.on_load, {
	partition = Guid("9697F666-AFF6-4035-AC81-148AC0E840F3"),
	instance = Guid("B70DB8C3-C043-41E4-971D-C997970D35A5")
})

return nil