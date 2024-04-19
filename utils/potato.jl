function build_potato!(vis, model::NamedTuple)
    l,w,h = 0.4,0.4,0.6
    body = mc.HyperRectangle(mc.Vec(-l/2,-w/2,0), mc.Vec(l,w,h)) 
    body = mc.GeometryBasics.Sphere(mc.Point(0.0,0.0,0.0), 7l/16)
    setobject!(vis["robot"]["torso"]["body"], body, MeshPhongMaterial(color=colorant"gray"))
end
function update_potato_pose!(vis, model::NamedTuple, x::Vector)
    xb,yb = x[1],x[2]
    settransform!(vis["robot"]["torso"], mc.Translation(xb,0,yb))
end