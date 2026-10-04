dofile(LockOn_Options.script_path.."command_defs.lua")

function round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function RFromQuaternion(qx,qy,qz,qw)
	R =
	{
		a11= 1-2*(qy*qy+qz*qz), a12= -2*qw*qz+2*qx*qy,a13= 2*qw*qy+2*qx*qz,
		a21= 2*qw*qz+2*qx*qy, a22 = 1-2*(qx*qx+qz*qz),a23= -2*qw*qx+2*qy*qz, 
		a31= -2*qw*qy+2*qx*qz, a32 = 2*qw*qx+2*qy*qz, a33=1-2*(qx*qx+qy*qy)
	}
	return R
end

function InverseRotationMatrix(R)
	--this uses R^T = R^-1 since rotation matrices are orthogonal. Not valid for any Matrices
	iR =
	{
		a11 = R.a11, a12 = R.a21, a13 = R.a31,
		a21 = R.a12, a22 = R.a22, a23 = R.a32,
		a31 = R.a13, a32 = R.a23, a33 = R.a33,
	}
	return iR
end

function MatMulVec(A,x)
	local y ={
		x = A.a11* x.x+A.a12*x.y+A.a13*x.z,
		y = A.a21* x.x+A.a22*x.y+A.a23*x.z,
		z = A.a31* x.x+A.a32*x.y+A.a33*x.z
	}
	return y
end

function Atan2(y,x)
	if x>0 then 
		return math.atan(y/x)
	end
	if x<0.0 and y > 0 then
		return math.atan(y/x)+ math.pi
	end
	if x<0.0 and y == 0.0 then
		return math.pi
	end
	if x<0.0 and y<0.0 then
		return math.atan(y/x)-math.pi
	end
	if x == 0.0 and y>0.0 then
		return math.pi/2
	end
	if x == 0.0 and y<0.0 then
		return -math.pi/2
	end
end


function Limit(v, v_min,v_max)
	if v < v_min then 
		v= v_min
	end
	if v > v_max then 
		v= v_max
	end
	return v
end