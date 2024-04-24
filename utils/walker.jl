using Rotations, StaticArrays
function build_walker!(vis, model::NamedTuple)
    # model = (g = -9.81, m = 43.0, J = diagm([0.41,2.1,2.1]), l = 0.8, w = 0.3, h = 0.4, mu = 0.6)
    l,w,h = model.l, model.w, model.h
    # l,w,h = 0.4,0.4,0.6
    body = mc.HyperRectangle(mc.Vec(-l/2,-w/2,0), mc.Vec(l,w,h)) 
    body = mc.GeometryBasics.HyperRectangle(mc.Vec(-l/2,-w/2,h-0.1), mc.Vec(l, w, 0.2))
    # body = mc.GeometryBasics.Sphere(mc.Point(0.0,0.0,0.0), 7l/16)
    setobject!(vis["robot"]["torso"]["body"], body, MeshPhongMaterial(color=colorant"gray"))
    # axle = mc.Cylinder(mc.Point(0.0,0.0,0.0), mc.Point(0.0,w/2,0.0), 0.03)
    # setobject!(vis["robot"]["torso"]["Laxle"], axle, MeshPhongMaterial(color=colorant"black"))
    # setobject!(vis["robot"]["torso"]["Raxle"], axle, MeshPhongMaterial(color=colorant"black"))
    # settransform!(vis["robot"]["torso"]["Laxle"], mc.Translation(0,+l/4,0))
    # settransform!(vis["robot"]["torso"]["Raxle"], mc.Translation(0,-3l/4,0))

    flfoot = mc.HyperSphere(mc.Point(l/2,w/2,0.0), 0.03)
    frfoot = mc.HyperSphere(mc.Point(l/2,-w/2,0.0), 0.03)
    blfoot = mc.HyperSphere(mc.Point(-l/2,w/2,0.0), 0.03)
    brfoot = mc.HyperSphere(mc.Point(-l/2,-w/2,0.0), 0.03)
    FLfoot = setobject!(vis["robot"]["FLfoot"]["geom"], flfoot, MeshPhongMaterial(color=colorant"firebrick"))
    FRfoot = setobject!(vis["robot"]["FRfoot"]["geom"], frfoot, MeshPhongMaterial(color=colorant"firebrick"))
    BLfoot = setobject!(vis["robot"]["BLfoot"]["geom"], blfoot, MeshPhongMaterial(color=colorant"firebrick"))
    BRfoot = setobject!(vis["robot"]["BRfoot"]["geom"], brfoot, MeshPhongMaterial(color=colorant"firebrick"))
    # FRfoot = setobject!(vis["robot"]["Rfoot"]["geom"], foot, MeshPhongMaterial(color=colorant"firebrick"))
    # settransform!(vis["robot"]["Lfoot"]["geom"], mc.Translation(0,+l/2,0))
    # settransform!(vis["robot"]["Rfoot"]["geom"], mc.Translation(0,-l/2,0))

    FLleg = mc.Cylinder(mc.Point(l/2,w/2,0.0),  mc.Point(l/2,w/2,h),  0.03)
    FRleg = mc.Cylinder(mc.Point(l/2,-w/2,0.0), mc.Point(l/2,-w/2,h), 0.03)
    BLleg = mc.Cylinder(mc.Point(-l/2,w/2,0.0), mc.Point(-l/2,w/2,h), 0.03)
    BRleg = mc.Cylinder(mc.Point(-l/2,-w/2,0.0),mc.Point(-l/2,-w/2,h), 0.03)
    Rleg = mc.Cylinder(mc.Point(0.,-l/2,0.), mc.Point(0.,-l/2,1.), 0.03)
    setobject!(vis["robot"]["torso"]["FLleg"]["geom"], FLleg, MeshPhongMaterial(color=colorant=colorant"gray"))
    setobject!(vis["robot"]["torso"]["FRleg"]["geom"], FRleg, MeshPhongMaterial(color=colorant=colorant"gray"))
    setobject!(vis["robot"]["torso"]["BLleg"]["geom"], BLleg, MeshPhongMaterial(color=colorant=colorant"gray"))
    setobject!(vis["robot"]["torso"]["BRleg"]["geom"], BRleg, MeshPhongMaterial(color=colorant=colorant"gray"))
    # setobject!(vis["robot"]["torso"]["Rleg"]["geom"], Rleg, MeshPhongMaterial(color=colorant=colorant"green"))
    # settransform!(vis["robot"]["torso"]["Lleg"]["geom"], Translation(0,+l/2,0))
    # settransform!(vis["robot"]["torso"]["Rleg"]["geom"], Translation(0,-l/2,0))

    return FLfoot
end
# function RotY(θ)
#     s, c = sincos(θ)
#     [c 0 s; 0 1 0;-s 0 c]
# end
# function RotX(θ)
#     LinearMap(mc.RotMatrix(1, θ))
# end
# function RotY(θ)
#     LinearMap(mc.RotMatrix(2, θ))
# end
# function RotZ(θ)
#     LinearMap(mc.RotMatrix(3, θ))
# end

# function update_walker_pose!(vis, model::NamedTuple, x::Vector, u::Vector)
#     xb,yb,zb = x[1],x[2],x[3]-model.h
#     rollb,pitchb,yawb = x[4],x[5],x[6]
#     v_xb,v_yb,v_zb = x[7],x[8],x[9]
#     v_rollb,v_pitchb,v_yawb = x[10],x[11],x[12]
#     g = x[13]
#     # front left, front right, back left , back right
#     # fx fy fz fx fy fz fx fy fz fx fy fz
#     # Fz is 0 when not in contact
#     settransform!(vis["robot"]["torso"], mc.Translation(xb,yb,zb))
#     settransform!(vis["robot"]["FLfoot"], mc.Translation(xb,yb,zb))
#     settransform!(vis["robot"]["FRfoot"], mc.Translation(xb,yb,zb))
#     settransform!(vis["robot"]["BLfoot"], mc.Translation(xb,yb,zb))
#     settransform!(vis["robot"]["BRfoot"], mc.Translation(xb,yb,zb))

    
    
#     rotation_roll = RotX(rollb)  # Rotation around X-axis for roll
#     rotation_pitch = RotY(pitchb)  # Rotation around Y-axis for pitch
#     rotation_yaw = RotZ(yawb)  # Rotation around Z-axis for yaw

#     # # Combining all rotations
#     # rotation_combined = rotation_roll * rotation_pitch * rotation_yaw

#     # # Applying the combined rotation to the body
#     # settransform!(vis["robot"]["torso"], rotation_combined * mc.Translation(xb, yb, zb))

#     # Llen = norm(SA[xl-xb, yl-yb])
#     # Rlen = norm(SA[xr-xb, yr-yb])
#     # θl = atan(xl-xb, yl-yb)
#     # θr = atan(xr-xb, yr-yb)
#     # settransform!(vis["robot"]["torso"], mc.LinearMap(RotY(pitchb)))
#     # settransform!(vis["robot"]["torso"], mc.LinearMap(RotY(θr)))

#     # settransform!(vis["robot"]["torso"]["Lleg"]["geom"], mc.LinearMap(Diagonal([1,1,Llen])))
#     # settransform!(vis["robot"]["torso"]["Rleg"]["geom"], mc.LinearMap(Diagonal([1,1,Rlen])))
# end
function RotY_for_leg(θ)
    s, c = sincos(θ)
    [c 0 s; 0 1 0;-s 0 c]
end

function update_walker_pose!(vis, model::NamedTuple, x::Vector, u::Vector)
    xb, yb, zb = x[1], x[2], x[3] - model.h
    rollb, pitchb, yawb = x[4], x[5], x[6]
    v_xb, v_yb, v_zb = x[7], x[8], x[9]
    v_rollb, v_pitchb, v_yawb = x[10], x[11], x[12]
    g = x[13]

    FLx, FLy, FLz = u[1], u[2], u[3]
    FRx, FRy, FRz = u[4], u[5], u[6]
    BLx, BLy, BLz = u[7], u[8], u[9]
    BRx, BRy, BRz = u[10], u[11], u[12]
    # @show rollb
    # @show pitchb
    # @show yawb
    settransform!(vis["robot"]["torso"], mc.Translation(xb, yb, zb))
    settransform!(vis["robot"]["FLfoot"], mc.Translation(xb, yb, zb))
    settransform!(vis["robot"]["FRfoot"], mc.Translation(xb, yb, zb))
    settransform!(vis["robot"]["BLfoot"], mc.Translation(xb, yb, zb))
    settransform!(vis["robot"]["BRfoot"], mc.Translation(xb, yb, zb))

    # Define rotation matrices for roll, pitch, and yaw
    # RotX(θ) = LinearMap(mc.RotMatrix(3, θ))
    # RotY(θ) = LinearMap(mc.RotMatrix(2, θ))
    # RotZ(θ) = LinearMap(mc.RotMatrix(1, θ))

    # Apply rotations
    rotation_combined = RotXYZ(rollb, pitchb, yawb)
    translation = mc.Translation(xb, yb, zb)
    combined_transform = mc.LinearMap(rotation_combined) ∘ translation
    settransform!(vis["robot"]["torso"], combined_transform)

    # Llen = norm(SA[xl-xb, yl-yb])
    # Rlen = norm(SA[xr-xb, yr-yb])
    
    # settransform!(vis["robot"]["torso"]["Rleg"]["geom"], mc.LinearMap(Diagonal([1,1,Rlen])))
    # @show FLz
    # if FLz < 0.000001 && FRz >0.000001 && BLz > 0.000001 && BRz > 0.000001
    #     setobject!(vis["robot"]["FLfoot"]["geom"], MeshPhongMaterial(color=colorant"gray"))
    #     θl = -0.2
    #     print("front left on ground")
    #     settransform!(vis["robot"]["torso"]["FLleg"], mc.LinearMap(RotY_for_leg(θl)))
    #     settransform!(vis["robot"]["torso"]["FLleg"]["geom"], mc.LinearMap(Diagonal([1,1,2*model.h])))
    # end
    # if FLz > 0.000001 && FRz <0.000001 && BLz > 0.000001 && BRz > 0.000001
    #     θl = -0.2
    #     print("front left on ground")
    #     settransform!(vis["robot"]["torso"]["FRleg"], mc.LinearMap(RotY_for_leg(θl)))
    #     settransform!(vis["robot"]["torso"]["FRleg"]["geom"], mc.LinearMap(Diagonal([1,1,2*model.h])))
    # end
    # if FLz > 0.000001 && FRz >0.000001 && BLz < 0.000001 && BRz > 0.000001
    #     θl = -0.2
    #     print("front left on ground")
    #     settransform!(vis["robot"]["torso"]["BLleg"], mc.LinearMap(RotY_for_leg(θl)))
    #     settransform!(vis["robot"]["torso"]["BLleg"]["geom"], mc.LinearMap(Diagonal([1,1,2*model.h])))
    # end
    # if FLz > 0.000001 && FRz >0.000001 && BLz > 0.000001 && BRz < 0.000001
    #     θl = -0.2
    #     print("front left on ground")
    #     settransform!(vis["robot"]["torso"]["BRleg"], mc.LinearMap(RotY_for_leg(θl)))
    #     settransform!(vis["robot"]["torso"]["BRleg"]["geom"], mc.LinearMap(Diagonal([1,1,2*model.h])))
    # end

    # rotation_pitch = RotY(pitchb)
    # rotation_yaw = RotZ(yawb)
    # rotation_combined = rotation_roll * rotation_pitch * rotation_yaw
    # settransform!(vis["robot"]["torso"], rotation_combined * mc.Translation(xb, yb, zb))

    # Set other elements as needed
end